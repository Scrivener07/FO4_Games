ScriptName Games:Blackjack:Game extends Games:Blackjack:GameType
import Games
import Games:Shared
import Games:Shared:Log
import Games:Shared:Papyrus


ObjectReference Entry
CustomEvent PhaseEvent

float TimeWait = 2.0 const


; Methods
;---------------------------------------------

bool Function Play(ObjectReference aEntryPoint)
	If (Idling)
		If (aEntryPoint)
			Entry = aEntryPoint
			return ChangeState(self, StartingTask)
		Else
			WriteUnexpectedValue(self, "Play", "aEntryPoint", "The entry point reference cannot be none.")
			return false
		EndIf
	Else
		WriteUnexpected(self, "Play", "The game is not ready to play in the '"+StateName+"' state.")
		return false
	EndIf
EndFunction


bool Function PlayAsk(ObjectReference aEntryPoint)
	int selected = Games_Blackjack_MessagePlay.Show()
	int OptionExit = 0 const
	int OptionStart = 1 const

	If (selected == OptionStart)
		return Play(aEntryPoint)

	ElseIf (selected == OptionExit || selected == Invalid)
		WriteLine(self, "Chose not to play Blackjack.")
		return false
	Else
		WriteUnexpectedValue(self, "PlayAsk", "selected", "The option '"+selected+"' is unhandled.")
		return false
	EndIf
EndFunction


bool Function PlayAgain()
	return Games_Blackjack_MessagePlayAgain.Show() == 1
EndFunction


Function ShowKicked()
	WriteMessage(self, "Kicked", "Your all out of caps. Better luck next time.")
EndFunction


bool Function RegisterForPhaseEvent(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "PhaseEvent")
		return true
	Else
		WriteUnexpectedValue(self, "RegisterForPhaseEvent", "script", "Cannot register a none script for phase events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForPhaseEvent(Blackjack:Game script)
	If (script)
		script.UnregisterForCustomEvent(self, "PhaseEvent")
		return true
	Else
		WriteUnexpectedValue(self, "UnregisterForPhaseEvent", "script", "Cannot unregister a none script for phase events.")
		return false
	EndIf
EndFunction


; FSM - Finite State Machine
;---------------------------------------------

State Starting
	Event OnBeginState(string asOldState)
		{Session Begin}
		StartObjectProfiling()
		WriteLine("Blackjack", "Starting")
		If (Session.Human.HasCaps == false)
			ChangeState(self, NoTask)
			WriteMessage(self, "Kicked", "You dont have any caps to play Blackjack.")
			return
		EndIf

		If (SendPhase(self, StartingTask, Begun))
			TaskAwait(Table, StartingTask)
			TaskAwait(Cards, StartingTask)
			TaskAwait(Session, StartingTask)
			ChangeState(self, WageringTask)
		Else
			WriteUnexpected(self, "Starting.OnBeginState", "Could not begin the '"+StartingTask+"' task.")
			ChangeState(self, ExitingTask)
		EndIf
	EndEvent

	Event OnEndState(string asNewState)
		If (asNewState == WageringTask)
			SendPhase(self, StartingTask, Ended)
		EndIf
	EndEvent
EndState


State Wagering
	Event OnBeginState(string asOldState)
		{Game State}
		WriteLine("Blackjack", "Wagering")
		If (Session.Human.HasCaps == false)
			ChangeState(self, ExitingTask)
			ShowKicked()
			return
		EndIf

		If (SendPhase(self, WageringTask, Begun))
			Utility.Wait(TimeWait)
			TaskAwait(Session, WageringTask)

			If (Session.Human.Bet == Invalid)
				ChangeState(self, ExitingTask)
			Else
				ChangeState(self, DealingTask)
			EndIf
		Else
			WriteUnexpected(self, "Wagering.OnBeginState", "Could not begin the '"+WageringTask+"' task.")
			ChangeState(self, ExitingTask)
		EndIf
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, WageringTask, Ended)
	EndEvent
EndState


State Dealing
	Event OnBeginState(string asOldState)
		{Game State}
		WriteLine("Blackjack", "Dealing")
		If (SendPhase(self, DealingTask, Begun))
			Utility.Wait(TimeWait)
			Cards.Shuffle()
			TaskAwait(Session, DealingTask)
			ChangeState(self, PlayingTask)
		Else
			WriteUnexpected(self, "Dealing.OnBeginState", "Could not begin the '"+DealingTask+"' task.")
			ChangeState(self, ExitingTask)
		EndIf
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, DealingTask, Ended)
	EndEvent
EndState


State Playing
	Event OnBeginState(string asOldState)
		{Game State}
		WriteLine("Blackjack", "Playing")
		If (SendPhase(self, PlayingTask, Begun))
			Utility.Wait(TimeWait)
			TaskAwait(Session, PlayingTask)
			ChangeState(self, ScoringTask)
		Else
			WriteUnexpected(self, "Playing.OnBeginState", "Could not begin the '"+PlayingTask+"' task.")
			ChangeState(self, ExitingTask)
		EndIf
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, PlayingTask, Ended)
	EndEvent
EndState


State Scoring
	Event OnBeginState(string asOldState)
		{Game State}
		WriteLine("Blackjack", "Scoring")
		If (SendPhase(self, ScoringTask, Begun))
			Utility.Wait(TimeWait)
			TaskAwait(Session, ScoringTask)

			If (Session.Human.HasCaps)
				If (Session.Human.Rematch)
					WriteLine("Blackjack", "Chose to play again for a rematch.")
					ChangeState(self, WageringTask)
				Else
					WriteLine("Blackjack", "Chose to leave the game.")
					ChangeState(self, ExitingTask)
				EndIf
			Else
				WriteLine("Blackjack", "Kicked from game for low funds.")
				ChangeState(self, ExitingTask)
				ShowKicked()
			EndIf
		Else
			WriteUnexpected(self, "Scoring.OnBeginState", "Could not begin the '"+ScoringTask+"' task.")
			ChangeState(self, ExitingTask)
		EndIf
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, ScoringTask, Ended)
	EndEvent
EndState


State Exiting
	Event OnBeginState(string asOldState)
		{Session End}
		WriteLine("Blackjack", "Exiting")
		If (SendPhase(self, ExitingTask, Begun))
			Utility.Wait(TimeWait)
			TaskAwait(Table, ExitingTask)
			TaskAwait(Cards, ExitingTask)
			TaskAwait(Session, ExitingTask)
		Else
			WriteUnexpected(self, "Exiting.OnBeginState", "Could not begin the '"+ExitingTask+"' task.")
		EndIf

		ChangeState(self, NoTask)
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, ExitingTask, Ended)
		StopObjectProfiling()
	EndEvent
EndState


; Properties
;---------------------------------------------

Group Tasks
	Tasks:Table Property Table Auto Const Mandatory
	Tasks:Session Property Session Auto Const Mandatory
	Tasks:Cards Property Cards Auto Const Mandatory
EndGroup

Group Actions
	ObjectReference Property EntryPoint Hidden
		ObjectReference Function Get()
			return Entry
		EndFunction
	EndProperty
EndGroup

Group Messages
	Message Property Games_Blackjack_MessageWager Auto Const Mandatory
	Message Property Games_Blackjack_MessageTurn Auto Const Mandatory
	Message Property Games_Blackjack_MessageTurnDealt Auto Const Mandatory
	Message Property Games_Blackjack_MessagePlay Auto Const Mandatory
	Message Property Games_Blackjack_MessagePlayAgain Auto Const Mandatory
	Message Property Games_Blackjack_MessageWin Auto Const Mandatory
	Message Property Games_Blackjack_MessageBust Auto Const Mandatory
EndGroup
