ScriptName Gambling:BlackJack:Game extends Gambling:BlackJack:Component
import Gambling
import Gambling:BlackJack
import Gambling:Shared
import Gambling:Shared:Common


CustomEvent PhaseEvent


; Component
;---------------------------------------------

State Starting
	Event OnBeginState(string asOldState)
		{Session Begin}
		WriteLine(self, "Starting")
		SendPhase(self, StartingPhase, Begun)

		If (GUI.PromptPlay())

			If (Table.StartAndWait())
				WriteLine(self, "Table component has finished the Starting thread.")
			EndIf
			If (Cards.StartAndWait())
				WriteLine(self, "Cards component has finished the Starting thread.")
			EndIf
			If (Players.StartAndWait())
				WriteLine(self, "Players component has finished the Starting thread.")
			EndIf

			ChangeState(self, WageringPhase)
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
		WriteLine(self, "Wagering")
		SendPhase(self, WageringPhase, Begun)

		If (Players.WagerAndWait())
			WriteLine(self, "Players component has finished the Wagering thread.")
		EndIf

		ChangeState(self, DealingPhase)
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, WageringPhase, Ended)
	EndEvent
EndState


State Dealing
	Event OnBeginState(string asOldState)
		{Game State}
		WriteLine(self, "Dealing")
		SendPhase(self, DealingPhase, Begun)

		Cards.Shuffle()
		If (Players.DealAndWait())
			WriteLine(self, "Players component has finished the Dealing thread.")
		EndIf

		ChangeState(self, PlayingPhase)

	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, DealingPhase, Ended)
	EndEvent
EndState


State Playing
	Event OnBeginState(string asOldState)
		{Game State}
		WriteLine(self, "Playing")
		SendPhase(self, PlayingPhase, Begun)

		If (Players.PlayAndWait())
			WriteLine(self, "Players component has finished the Playing thread.")
		EndIf

		ChangeState(self, ScoringPhase)
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, PlayingPhase, Ended)
	EndEvent
EndState


State Scoring
	Event OnBeginState(string asOldState)
		{Game State}
		WriteLine(self, "Scoring")
		SendPhase(self, ScoringPhase, Begun)

		If (Players.ScoreAndWait())
			WriteLine(self, "Players component has finished the Scoring thread.")
		EndIf

		If (GUI.PromptPlayAgain())
			ChangeState(self, WageringPhase)
		Else
			ChangeState(self, ExitingPhase)
		EndIf
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, ScoringPhase, Ended)
	EndEvent
EndState


State Exiting
	Event OnBeginState(string asOldState)
		{Session End}
		WriteLine(self, "Exiting")
		SendPhase(self, ExitingPhase, Begun)

		If (Table.ExitAndWait())
			WriteLine(self, "Table component has finished the Exiting thread.")
		EndIf
		If (Cards.ExitAndWait())
			WriteLine(self, "Cards component has finished the Exiting thread.")
		EndIf
		If (Players.ExitAndWait())
			WriteLine(self, "Players component has finished the Exiting thread.")
		EndIf

		ChangeState(self, IdlePhase)
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, ExitingPhase, Ended)
	EndEvent
EndState


; Methods
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


; Functions
;---------------------------------------------

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
