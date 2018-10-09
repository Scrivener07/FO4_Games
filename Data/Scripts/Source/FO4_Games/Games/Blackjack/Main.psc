ScriptName Games:Blackjack:Main extends Games:Blackjack:Type
{The main entry point for Blackjack.}
import Games
import Games:Shared:Log
import Games:Shared:Papyrus

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
		WriteUnexpectedValue(ToString(), "OnTimer", "timerID", "The timer ID "+timerID+" was unhandled.")
	EndIf
EndEvent


; Methods
;---------------------------------------------

bool Function Play(ObjectReference exitMarker)
	If (IsEmptyState)
		If (Setup.SetExit(exitMarker))
			return NewState(self, StartingID)
		Else
			WriteUnexpected(ToString(), "Play", "Setup could not set the exit marker "+exitMarker)
			return false
		EndIf
	Else
		WriteUnexpected(ToString(), "Play", "The game is not ready to play in the '"+StateName+"' state.")
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
		WriteLine(ToString(), "Chose not to play Blackjack.")
		return false
	Else
		WriteUnexpectedValue(ToString(), "PlayAsk", "selected", "The option '"+selected+"' is unhandled.")
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
		WriteUnexpectedValue(ToString(), "RegisterForPhaseEvent", "script", "Cannot register a none script for phase events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForPhaseEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "PhaseEvent")
		return true
	Else
		WriteUnexpectedValue(ToString(), "UnregisterForPhaseEvent", "script", "Cannot unregister a none script for phase events.")
		return false
	EndIf
EndFunction


; States
;---------------------------------------------

State Starting
	Event OnBeginState(string oldState)
		{Session Begin}
		WriteLine(ToString(), "Starting")

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
			WriteUnexpected(ToString(), "Starting.OnBeginState", "Could not begin the '"+StartingState+"' state.")
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
		WriteLine(ToString(), "Wagering")

		If (Human.HasCaps == false)
			WriteLine(ToString(), "Kicking because there are no funds to wager.")
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
					WriteUnexpected(ToString(), "Wagering.OnBeginState", "Exiting. Human bet of "+Human.Bet+" is invalid.")
					NewState(self, ExitingID)
				Else
					NewState(self, DealingID)
				EndIf
			Else
				WriteUnexpected(ToString(), "Wagering.OnBeginState", "Exiting. Has no human. State:"+Human.StateName)
				NewState(self, ExitingID)
			EndIf
		Else
			WriteUnexpected(ToString(), "Wagering.OnBeginState", "Could not begin the '"+WageringState+"' state.")
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
		WriteLine(ToString(), "Dealing")
		If (SendPhase(self, DealingState, Begun))
			Utility.Wait(TimeDelay)
			AwaitState(Deck, DealingState)

			AwaitState(Dealer, DealingState)
			AwaitState(Human, DealingState)
			AwaitState(Dealer, DealingState)
			AwaitState(Human, DealingState)

			NewState(self, PlayingID)
		Else
			WriteUnexpected(ToString(), "Dealing.OnBeginState", "Could not begin the '"+DealingState+"' state.")
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
		WriteLine(ToString(), "Playing")
		If (SendPhase(self, PlayingState, Begun))
			Utility.Wait(TimeDelay)
			If (Dealer.Hand.IsBlackjack || Human.Hand.IsBlackjack)
				WriteLine(ToString(), "A blackjack is on the table. A push will be resolved at scoring.")
				Dealer.Reveal()
			Else
				AwaitState(Human, PlayingState)
				If (Human.Hand.IsBust == false)
					WriteLine(ToString(), "The dealer will challenge the players hand.")
					AwaitState(Dealer, PlayingState)
				Else
					WriteLine(ToString(), "The dealer will not challenge a busted hand.")
					Dealer.Reveal()
				EndIf
			EndIf
			NewState(self, ScoringID)
		Else
			WriteUnexpected(ToString(), "Playing.OnBeginState", "Could not begin the '"+PlayingState+"' state.")
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
		WriteLine(ToString(), "Scoring")
		If (SendPhase(self, ScoringState, Begun))
			Utility.Wait(TimeDelay)

			AwaitState(Human, ScoringState)
			AwaitState(Dealer, ScoringState)

			Human.Collect()
			Dealer.Collect()

			If (!Human.Quit)
				If (Human.HasCaps)
					WriteLine(ToString(), "The player will continue playing game.")
					NewState(self, WageringID)
				Else
					WriteLine(ToString(), "Kicked from game for low funds.")
					NewState(self, ExitingID)
					Games_Blackjack_MessageNoFunds.Show()
				EndIf
			Else
				WriteLine(ToString(), "The human player left the game.")
				NewState(self, ExitingID)
			EndIf
		Else
			WriteUnexpected(ToString(), "Scoring.OnBeginState", "Could not begin the '"+ScoringState+"' state.")
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
		WriteLine(ToString(), "Exiting")
		If (SendPhase(self, ExitingState, Begun))
			Utility.Wait(TimeDelay)
			AwaitState(Deck, ExitingState)

			AwaitState(Human, ExitingState)
			AwaitState(Dealer, ExitingState)

			AwaitState(Setup, ExitingState)
		Else
			WriteUnexpected(ToString(), "Exiting.OnBeginState", "Could not begin the '"+ExitingState+"' state.")
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
