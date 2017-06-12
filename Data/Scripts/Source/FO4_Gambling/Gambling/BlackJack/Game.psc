ScriptName Gambling:BlackJack:Game extends Gambling:BlackJack:Component
import Gambling
import Gambling:BlackJack
import Gambling:Shared
import Gambling:Shared:Common


CustomEvent PhaseEvent


; Methods
;---------------------------------------------

State Starting
	Event OnBeginState(string asOldState)
		{Session Begin}

		If (GUI.PromptPlay())
			Table.StartAndWait()
			Cards.StartAndWait()
			Players.StartAndWait()

			ChangeState(self, WageringPhase)
			SendPhase(self, StartingPhase, Begun)
		Else
			ChangeState(self, IdlePhase)
		EndIf
	EndEvent

	Event OnEndState(string asNewState)
		If (asNewState == WageringPhase)
			SendPhase(self, StartingPhase, Ended)
		EndIf
	EndEvent
EndState


State Wagering
	Event OnBeginState(string asOldState)
		{Game State}

		Players.WagerAndWait()

		ChangeState(self, DealingPhase)
		SendPhase(self, WageringPhase, Begun)
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, WageringPhase, Ended)
	EndEvent
EndState


State Dealing
	Event OnBeginState(string asOldState)
		{Game State}
		Cards.Shuffle()
		Players.DealAndWait()

		ChangeState(self, PlayingPhase)
		SendPhase(self, DealingPhase, Begun)
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, DealingPhase, Ended)
	EndEvent
EndState


State Playing
	Event OnBeginState(string asOldState)
		{Game State}
		Players.PlayAndWait()
		; after all players have taken all of their turns

		ChangeState(self, ScoringPhase)
		SendPhase(self, PlayingPhase, Begun)
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, PlayingPhase, Ended)
	EndEvent
EndState


State Scoring
	Event OnBeginState(string asOldState)
		{Game State}

		If (GUI.PromptPlayAgain())
			ChangeState(self, WageringPhase)
		Else
			ChangeState(self, ExitingPhase)
		EndIf

		SendPhase(self, ScoringPhase, Begun)
	EndEvent

	Event OnEndState(string asNewState)
		Cards.CollectAll()
		SendPhase(self, ScoringPhase, Ended)
	EndEvent
EndState


State Exiting
	Event OnBeginState(string asOldState)
		{Session End}
		Table.ExitAndWait()
		Cards.ExitAndWait()
		Players.ExitAndWait()

		ChangeState(self, IdlePhase)
		SendPhase(self, ExitingPhase, Begun)
	EndEvent

	Event OnEndState(string asNewState)
		; final chance to clean up
		SendPhase(self, ExitingPhase, Ended)
	EndEvent
EndState


; Functions
;---------------------------------------------

bool Function Play(Actions:Play playAction)
	If (Idling)
		If (playAction)
			Table.PlayAction = playAction
		EndIf
		return ChangeState(self, StartingPhase)
	Else
		WriteLine(self, "The game is not ready to play right now.")
		return false
	EndIf
EndFunction


Function SendPhase(BlackJack:Game sender, string name, bool change) Global
	string stateName = sender.GetState()
	If (stateName == name)

		PhaseEventArgs phase = new PhaseEventArgs
		phase.Name = name
		phase.Change = change

		var[] arguments = new var[1]
		arguments[0] = phase

		WriteLine(sender, "Sending phase event:" + phase)
		sender.SendCustomEvent("PhaseEvent", arguments)
	Else
		WriteLine(sender, "Cannot not send the phase '"+name+"' while in the '"+stateName+"' state.")
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Object
	Components:Rules Property Rules Auto Const Mandatory
	Components:GUI Property GUI Auto Const Mandatory
	Components:Table Property Table Auto Const Mandatory
	Components:Cards Property Cards Auto Const Mandatory
	Components:Players Property Players Auto Const Mandatory
EndGroup

Group Game
	bool Property HasHuman Hidden
		bool Function Get()
			return Players.Contains(Players.Human)
		EndFunction
	EndProperty
EndGroup
