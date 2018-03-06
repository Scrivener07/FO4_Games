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
			return TryState(self, StartingID)
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


; Functions
;---------------------------------------------

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
			TryState(self, IdlingID)
			Games_Blackjack_MessageNoFunds.Show()
			return
		EndIf

		If (SendPhase(self, StartingState, Begun))
			AwaitState(Environment, StartingState)
			AwaitState(Cards, StartingState)
			AwaitState(Players, StartingState)
			TryState(self, WageringID)
		Else
			WriteUnexpected(self, "Starting.OnBeginState", "Could not begin the '"+StartingState+"' state.")
			TryState(self, ExitingID)
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
			WriteLine("Blackjack", "Kicking because there are no funds to wager.")
			TryState(self, ExitingID)
			Games_Blackjack_MessageNoFunds.Show()
			return
		EndIf

		If (SendPhase(self, WageringState, Begun))
			Utility.Wait(TimeDelay)
			AwaitState(Players, WageringState)

			If (Players.HasHuman)
				If (Human.Bet == Invalid)
					TryState(self, ExitingID)
				Else
					TryState(self, DealingID)
				EndIf
			Else
				TryState(self, ExitingID)
			EndIf
		Else
			WriteUnexpected(self, "Wagering.OnBeginState", "Could not begin the '"+WageringState+"' state.")
			TryState(self, ExitingID)
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
			AwaitState(Players, DealingState)
			TryState(self, PlayingID)
		Else
			WriteUnexpected(self, "Dealing.OnBeginState", "Could not begin the '"+DealingState+"' state.")
			TryState(self, ExitingID)
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
			AwaitState(Players, PlayingState)
			TryState(self, ScoringID)
		Else
			WriteUnexpected(self, "Playing.OnBeginState", "Could not begin the '"+PlayingState+"' state.")
			TryState(self, ExitingID)
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
			AwaitState(Players, ScoringState)

			If (Players.HasHuman)
				If (Human.HasCaps)
					WriteLine("Blackjack", "The player will continue playing game.")
					TryState(self, WageringID)
				Else
					WriteLine("Blackjack", "Kicked from game for low funds.")
					TryState(self, ExitingID)
					Games_Blackjack_MessageNoFunds.Show()
				EndIf
			Else
				WriteLine("Blackjack", "The human player left the game.")
				TryState(self, ExitingID)
			EndIf
		Else
			WriteUnexpected(self, "Scoring.OnBeginState", "Could not begin the '"+ScoringState+"' state.")
			TryState(self, ExitingID)
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
			AwaitState(Players, ExitingState)
			AwaitState(Environment, ExitingState)
		Else
			WriteUnexpected(self, "Exiting.OnBeginState", "Could not begin the '"+ExitingState+"' state.")
		EndIf

		TryState(self, IdlingID)
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, ExitingState, Ended)
	EndEvent
EndState


; Properties
;---------------------------------------------

Group Messages
	Message Property Games_Blackjack_MessagePlay Auto Const Mandatory
	Message Property Games_Blackjack_MessageNoFunds Auto Const Mandatory
EndGroup

Group Scripts
	Blackjack:Environment Property Environment Auto Const Mandatory
	Blackjack:Cards Property Cards Auto Const Mandatory
	Blackjack:Players Property Players Auto Const Mandatory
	Blackjack:Players:Human Property Human Auto Const Mandatory
EndGroup
