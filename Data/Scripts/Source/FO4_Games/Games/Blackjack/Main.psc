ScriptName Games:Blackjack:Main extends Games:Blackjack:Type
import Games
import Games:Blackjack
import Games:Shared
;---------------------------------------------
import Games:Shared:Deck
import Games:Shared:Log
import Games:Shared:Papyrus
import Games:Blackjack:Players:ObjectType


CustomEvent PhaseEvent

int EmptyID    = 10 const
int StartingID = 20 const
int WageringID = 30 const
int DealingID  = 40 const
int PlayingID  = 50 const
int ScoringID  = 60 const
int ExitingID  = 70 const

float TimeDelay = 1.0 const


; Events
;---------------------------------------------

Event OnTimer(int timerID)
	If (timerID == EmptyID)
		ChangeState(self, EmptyState)
	ElseIf (timerID == StartingID)
		ChangeState(self, StartingState)
	ElseIf (timerID == WageringID)
		ChangeState(self, WageringState)
	ElseIf (timerID == DealingID)
		ChangeState(self, DealingState)
	ElseIf (timerID == PlayingID)
		ChangeState(self, PlayingState)
	ElseIf (timerID == ScoringID)
		ChangeState(self, ScoringState)
	ElseIf (timerID == ExitingID)
		ChangeState(self, ExitingState)
	Else
		WriteUnexpectedValue(self, "OnTimer", "timerID", "The timer ID "+timerID+" was unhandled.")
	EndIf
EndEvent


; Methods
;---------------------------------------------

bool Function Play(ObjectReference exitMarker)
	If (IsEmptyState)
		If (Setup.SetExit(exitMarker))
			return NewState(self, StartingID)
		Else
			WriteUnexpected(self, "Play", "Setup could not set the exit marker "+exitMarker)
			return false
		EndIf
	Else
		WriteUnexpected(self, "Play", "The game is not ready to play in the '"+StateName+"' state.")
		return false
	EndIf
EndFunction


bool Function PlayAsk(ObjectReference exitMarker)
	int selected = Games_Blackjack_MessagePlay.Show()
	int OptionExit = 0 const
	int OptionStart = 1 const

	If (selected == OptionStart)
		return Play(exitMarker)
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


bool Function UnregisterForPhaseEvent(ScriptObject script)
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
	Event OnBeginState(string oldState)
		{Session Begin}
		WriteLine("Blackjack", "Starting")

		If (Human.HasCaps == false)
			NewState(self, EmptyID)
			Games_Blackjack_MessageNoFunds.Show()
			return
		EndIf

		If (SendPhase(self, StartingState, Begun))
			AwaitState(Setup, StartingState)
			AwaitState(Deck, StartingState)
			BeginState(Dealer, StartingState)
			BeginState(Human, StartingState)
			NewState(self, WageringID)
		Else
			WriteUnexpected(self, "Starting.OnBeginState", "Could not begin the '"+StartingState+"' state.")
			NewState(self, ExitingID)
		EndIf
	EndEvent


	Event OnEndState(string newState)
		If (newState == WageringState)
			SendPhase(self, StartingState, Ended)
		EndIf
	EndEvent
EndState


State Wagering
	Event OnBeginState(string oldState)
		{Game State}
		WriteLine("Blackjack", "Wagering")

		If (Human.HasCaps == false)
			WriteLine("Blackjack", "Kicking because there are no funds to wager.")
			NewState(self, ExitingID)
			Games_Blackjack_MessageNoFunds.Show()
			return
		EndIf

		If (SendPhase(self, WageringState, Begun))
			Utility.Wait(TimeDelay)

			BeginState(Dealer, WageringState)
			BeginState(Human, WageringState)

			If (!Human.Quit)
				If (Human.Bet == Invalid)
					WriteUnexpected(self, "Wagering.OnBeginState", "Exiting. Human bet of "+Human.Bet+" is invalid.")
					NewState(self, ExitingID)
				Else
					NewState(self, DealingID)
				EndIf
			Else
				WriteUnexpected(self, "Wagering.OnBeginState", "Exiting. Has no human. State:"+Human.StateName)
				NewState(self, ExitingID)
			EndIf
		Else
			WriteUnexpected(self, "Wagering.OnBeginState", "Could not begin the '"+WageringState+"' state.")
			NewState(self, ExitingID)
		EndIf
	EndEvent

	Event OnEndState(string newState)
		SendPhase(self, WageringState, Ended)
	EndEvent
EndState


State Dealing
	Event OnBeginState(string oldState)
		{Game State}
		WriteLine("Blackjack", "Dealing")
		If (SendPhase(self, DealingState, Begun))
			Utility.Wait(TimeDelay)
			AwaitState(Deck, DealingState)

			AwaitState(Dealer, DealingState)
			AwaitState(Human, DealingState)

			AwaitState(Dealer, DealingState)
			AwaitState(Human, DealingState)

			If (Dealer.Hand.IsBlackjack)
				NewState(self, ScoringID)
			Else
				NewState(self, PlayingID)
			EndIf

			NewState(self, PlayingID)
		Else
			WriteUnexpected(self, "Dealing.OnBeginState", "Could not begin the '"+DealingState+"' state.")
			NewState(self, ExitingID)
		EndIf
	EndEvent

	Event OnEndState(string newState)
		SendPhase(self, DealingState, Ended)
	EndEvent
EndState


State Playing
	Event OnBeginState(string oldState)
		{Game State}
		WriteLine("Blackjack", "Playing")
		If (SendPhase(self, PlayingState, Begun))
			Utility.Wait(TimeDelay)

			AwaitState(Human, PlayingState)

			If (Human.Hand.IsInPlay)
				AwaitState(Dealer, PlayingState)
			EndIf

			NewState(self, ScoringID)
		Else
			WriteUnexpected(self, "Playing.OnBeginState", "Could not begin the '"+PlayingState+"' state.")
			NewState(self, ExitingID)
		EndIf
	EndEvent

	Event OnEndState(string newState)
		SendPhase(self, PlayingState, Ended)
	EndEvent
EndState


State Scoring
	Event OnBeginState(string oldState)
		{Game State}
		WriteLine("Blackjack", "Scoring")
		If (SendPhase(self, ScoringState, Begun))
			Utility.Wait(TimeDelay)

			AwaitState(Human, ScoringState)
			Human.Hand.Undraw()

			AwaitState(Dealer, ScoringState)
			Dealer.Hand.Undraw()

			If (!Human.Quit)
				If (Human.HasCaps)
					WriteLine("Blackjack", "The player will continue playing game.")
					NewState(self, WageringID)
				Else
					WriteLine("Blackjack", "Kicked from game for low funds.")
					NewState(self, ExitingID)
					Games_Blackjack_MessageNoFunds.Show()
				EndIf
			Else
				WriteLine("Blackjack", "The human player left the game.")
				NewState(self, ExitingID)
			EndIf
		Else
			WriteUnexpected(self, "Scoring.OnBeginState", "Could not begin the '"+ScoringState+"' state.")
			NewState(self, ExitingID)
		EndIf
	EndEvent

	Event OnEndState(string newState)
		SendPhase(self, ScoringState, Ended)
	EndEvent
EndState


State Exiting
	Event OnBeginState(string oldState)
		{Session End}
		WriteLine("Blackjack", "Exiting")
		If (SendPhase(self, ExitingState, Begun))
			Utility.Wait(TimeDelay)
			AwaitState(Deck, ExitingState)

			AwaitState(Human, ExitingState)
			AwaitState(Dealer, ExitingState)

			AwaitState(Setup, ExitingState)
		Else
			WriteUnexpected(self, "Exiting.OnBeginState", "Could not begin the '"+ExitingState+"' state.")
		EndIf

		NewState(self, EmptyID)
	EndEvent

	Event OnEndState(string newState)
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
	Blackjack:Setup Property Setup Auto Const Mandatory
	Blackjack:Deck Property Deck Auto Const Mandatory
	Blackjack:Dealer Property Dealer Auto Const Mandatory
	Blackjack:Human Property Human Auto Const Mandatory
EndGroup
