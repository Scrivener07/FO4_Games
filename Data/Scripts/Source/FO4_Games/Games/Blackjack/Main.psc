ScriptName Games:Blackjack:Main extends Games:Blackjack:Type
import Games
import Games:Shared
import Games:Shared:Log
import Games:Shared:Papyrus

CustomEvent PhaseEvent

int IdlingID   = 10 const
int StartingID = 20 const
int WageringID = 30 const
int DealingID  = 40 const
int PlayingID  = 50 const
int ScoringID  = 60 const
int ExitingID  = 70 const

float TimeDelay = 1.5 const


; Events
;---------------------------------------------

Event OnTimer(int aiTimerID)
	If (aiTimerID == IdlingID)
		ChangeState(self, IdlingState)
	ElseIf (aiTimerID == StartingID)
		ChangeState(self, StartingState)
	ElseIf (aiTimerID == WageringID)
		ChangeState(self, WageringState)
	ElseIf (aiTimerID == DealingID)
		ChangeState(self, DealingState)
	ElseIf (aiTimerID == PlayingID)
		ChangeState(self, PlayingState)
	ElseIf (aiTimerID == ScoringID)
		ChangeState(self, ScoringState)
	ElseIf (aiTimerID == ExitingID)
		ChangeState(self, ExitingState)
	Else
		WriteUnexpectedValue(self, "OnTimer", "aiTimerID", "The timer ID "+aiTimerID+" was unhandled.")
	EndIf
EndEvent


; Methods
;---------------------------------------------

bool Function Play(ObjectReference aExitMarker)
	If (Idling)
		If (Environment.SetExit(aExitMarker))
			return RequestState(self, StartingID)
		Else
			WriteUnexpected(self, "Play", "Environment could not set the exit marker.")
			return false
		EndIf
	Else
		WriteUnexpected(self, "Play", "The game is not ready to play in the '"+StateName+"' state.")
		return false
	EndIf
EndFunction


bool Function PlayAsk(ObjectReference aExitMarker)
	int selected = Games_Blackjack_MessagePlay.Show()
	int OptionExit = 0 const
	int OptionStart = 1 const

	If (selected == OptionStart)
		return Play(aExitMarker)
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


Function ShowNoFunds()
	Games_Blackjack_MessageNoFunds.Show()
EndFunction


bool Function RequestState(ScriptObject script, int stateID)
	If (script)
		script.StartTimer(0.1, stateID)
		return true
	Else
		WriteUnexpectedValue(self, "RequestState", "script", "Cannot request state ID "+stateID+" on a none script.")
		return false
	EndIf
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


bool Function UnregisterForPhaseEvent(Blackjack:Main script)
	If (script)
		script.UnregisterForCustomEvent(self, "PhaseEvent")
		return true
	Else
		WriteUnexpectedValue(self, "UnregisterForPhaseEvent", "script", "Cannot unregister a none script for phase events.")
		return false
	EndIf
EndFunction


; States
;---------------------------------------------

State Starting
	Event OnBeginState(string asOldState)
		{Session Begin}
		WriteLine("Blackjack", "Starting")

		If (Human.HasCaps == false)
			RequestState(self, IdlingID)
			ShowNoFunds()
			return
		EndIf

		If (SendPhase(self, StartingState, Begun))
			AwaitState(Environment, StartingState)
			AwaitState(Cards, StartingState)
			AwaitState(Actors, StartingState)
			RequestState(self, WageringID)
		Else
			WriteUnexpected(self, "Starting.OnBeginState", "Could not begin the '"+StartingState+"' task.")
			RequestState(self, ExitingID)
		EndIf
	EndEvent


	Event OnEndState(string asNewState)
		If (asNewState == WageringState)
			SendPhase(self, StartingState, Ended)
		EndIf
	EndEvent
EndState


State Wagering
	Event OnBeginState(string asOldState)
		{Game State}
		WriteLine("Blackjack", "Wagering")

		If (Human.HasCaps == false)
			RequestState(self, ExitingID)
			ShowNoFunds()
			return
		EndIf

		If (SendPhase(self, WageringState, Begun))
			Utility.Wait(TimeDelay)
			AwaitState(Actors, WageringState)

			If (Human.Bet == Invalid)
				RequestState(self, ExitingID)
			Else
				RequestState(self, DealingID)
			EndIf
		Else
			WriteUnexpected(self, "Wagering.OnBeginState", "Could not begin the '"+WageringState+"' task.")
			RequestState(self, ExitingID)
		EndIf
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, WageringState, Ended)
	EndEvent
EndState


State Dealing
	Event OnBeginState(string asOldState)
		{Game State}
		WriteLine("Blackjack", "Dealing")
		If (SendPhase(self, DealingState, Begun))
			Utility.Wait(TimeDelay)
			AwaitState(Cards, DealingState)
			AwaitState(Actors, DealingState)
			RequestState(self, PlayingID)
		Else
			WriteUnexpected(self, "Dealing.OnBeginState", "Could not begin the '"+DealingState+"' task.")
			RequestState(self, ExitingID)
		EndIf
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, DealingState, Ended)
	EndEvent
EndState


State Playing
	Event OnBeginState(string asOldState)
		{Game State}
		WriteLine("Blackjack", "Playing")
		If (SendPhase(self, PlayingState, Begun))
			Utility.Wait(TimeDelay)
			AwaitState(Actors, PlayingState)
			RequestState(self, ScoringID)
		Else
			WriteUnexpected(self, "Playing.OnBeginState", "Could not begin the '"+PlayingState+"' task.")
			RequestState(self, ExitingID)
		EndIf
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, PlayingState, Ended)
	EndEvent
EndState


State Scoring
	Event OnBeginState(string asOldState)
		{Game State}
		WriteLine("Blackjack", "Scoring")
		If (SendPhase(self, ScoringState, Begun))
			Utility.Wait(TimeDelay)
			AwaitState(Actors, ScoringState)

			If (Human.HasCaps)
				If (Human.Rematch)
					WriteLine("Blackjack", "Chose to play again for a rematch.")
					RequestState(self, WageringID)
				Else
					WriteLine("Blackjack", "Chose to leave the game.")
					RequestState(self, ExitingID)
				EndIf
			Else
				WriteLine("Blackjack", "Kicked from game for low funds.")
				RequestState(self, ExitingID)
				ShowNoFunds()
			EndIf
		Else
			WriteUnexpected(self, "Scoring.OnBeginState", "Could not begin the '"+ScoringState+"' task.")
			RequestState(self, ExitingID)
		EndIf
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, ScoringState, Ended)
	EndEvent
EndState


State Exiting
	Event OnBeginState(string asOldState)
		{Session End}
		WriteLine("Blackjack", "Exiting")
		If (SendPhase(self, ExitingState, Begun))
			Utility.Wait(TimeDelay)
			AwaitState(Actors, ExitingState)
			AwaitState(Environment, ExitingState)
		Else
			WriteUnexpected(self, "Exiting.OnBeginState", "Could not begin the '"+ExitingState+"' task.")
		EndIf

		RequestState(self, IdlingID)
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, ExitingState, Ended)
	EndEvent
EndState


; Properties
;---------------------------------------------

Group Messages
	Message Property Games_Blackjack_MessageNoFunds Auto Const Mandatory
	Message Property Games_Blackjack_MessagePlay Auto Const Mandatory
	Message Property Games_Blackjack_MessagePlayAgain Auto Const Mandatory
EndGroup

Group Scripts
	Blackjack:Environment Property Environment Auto Const Mandatory
	Blackjack:Cards Property Cards Auto Const Mandatory
	Blackjack:Actors Property Actors Auto Const Mandatory
	Blackjack:Players:Human Property Human Auto Const Mandatory
EndGroup
