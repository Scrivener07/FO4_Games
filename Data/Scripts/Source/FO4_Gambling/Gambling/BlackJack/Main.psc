ScriptName Gambling:BlackJack:Main extends Quest
import Gambling
import Gambling:BlackJack
import Gambling:Common
import Gambling:Shared


CustomEvent OnPhase

Struct PhaseEventArgs
	string Name
	bool Begun = true
EndStruct

int BlackJack = 21 const
bool Begun = false const
bool Ended = true const


; Methods
;---------------------------------------------

State Starting
	Event OnBeginState(string asOldState)
		WriteLine(self, "Beginning the starting phase.")

		If (Players.Allocate())
			Cards.Restore()
			ChangeState(self, WageringState)
		Else
			WriteLine(self, "Aborting startup.")
			Exit()
		EndIf

		SendPhase(StartingState, Begun)
	EndEvent

	Event OnEndState(string asNewState)
		WriteLine(self, "Ending the starting phase.")
		SendPhase(StartingState, Ended)
	EndEvent
EndState


State Wagering
	Event OnBeginState(string asOldState)
		WriteLine(self, "Beginning the wagering phase.")
		Players.Wager()
		SendPhase(WageringState, Begun)
		ChangeState(self, DealingState)
	EndEvent

	Event OnEndState(string asNewState)
		WriteLine(self, "Ending the wagering phase.")
		SendPhase(WageringState, Ended)
	EndEvent
EndState


State Dealing
	Event OnBeginState(string asOldState)
		WriteLine(self, "Beginning the dealing phase.")
		Cards.Shuffle()
		Players.Deal(Cards.Deck)
		SendPhase(DealingState, Begun)
		ChangeState(self, PlayingState)
	EndEvent

	Event OnEndState(string asNewState)
		WriteLine(self, "Ending the dealing phase.")
		SendPhase(DealingState, Ended)
	EndEvent
EndState


State Playing
	Event OnBeginState(string asOldState)
		WriteLine(self, "Beginning the playing phase.")
		Players.Play()
		SendPhase(PlayingState, Begun)
		ChangeState(self, ScoringState)
	EndEvent

	Event OnEndState(string asNewState)
		WriteLine(self, "Ending the playing phase.")
		SendPhase(PlayingState, Ended)
	EndEvent
EndState


State Scoring
	Event OnBeginState(string asOldState)
		WriteLine(self, "Beginning the scoring phase.")
		Exit()
		SendPhase(ScoringState, Begun)
	EndEvent

	Event OnEndState(string asNewState)
		WriteLine(self, "Ending the scoring phase.")
		Players.Deallocate()
		SendPhase(ScoringState, Ended)
	EndEvent
EndState


; Functions
;---------------------------------------------

bool Function Play()
	If (Exited)
		return ChangeState(self, StartingState)
	Else
		WriteLine(self, "The game is not ready to play right now.")
		return false
	EndIf
EndFunction


Function Exit()
	If !(Exited)
		ChangeState(self, EmptyState)
	Else
		WriteLine(self, "The game is already exited.")
	EndIf
EndFunction


int Function GetScore(CardDeck:Card[] aCards, int aScore)
	int score = 0
	int index = 0
	While (index < aCards.Length)
		score += CardToScore(aCards[index], aScore)
		index += 1
	EndWhile
	return score
EndFunction


int Function CardToScore(CardDeck:Card aCard, int aScore)
	If (aCard.Rank == Cards.Deck.Ace)
		If (aScore + 11 > BlackJack)
			return 1
		Else
			return 11
		EndIf
	ElseIf (Cards.Deck.IsFaceCard(aCard))
		return 10
	Else
		return aCard.Rank
	EndIf
EndFunction


bool Function IsWin(int aScore)
	return aScore == BlackJack
EndFunction


bool Function IsInPlay(int aScore)
	return aScore < BlackJack
EndFunction


bool Function IsBust(int aScore)
	return aScore > BlackJack
EndFunction


Function SendPhase(string aName, bool aBegun)
	string sState = self.GetState()
	If (sState == aName)
		PhaseEventArgs Phase = new PhaseEventArgs
		Phase.Name = aName
		Phase.Begun = aBegun

		var[] arguments = new var[1]
		arguments[0] = Phase

		WriteLine(self, "Sending phase event:"+Phase)
		SendCustomEvent("OnPhase", arguments)
	Else
		WriteLine(self, "Cannot not send the phase '"+aName+"' while in the '"+sState+"' state.")
	EndIf
EndFunction


PhaseEventArgs Function GetPhaseEventArgs(var[] arguments) Global
	If (arguments)
		return arguments[0] as PhaseEventArgs
	Else
		return none
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	BlackJack:Players Property Players Auto Const Mandatory
	BlackJack:Cards Property Cards Auto Const Mandatory
EndGroup

Group ReadOnly
	bool Property Exited Hidden
		bool Function Get()
			return self.GetState() == EmptyState
		EndFunction
	EndProperty

	string Property EmptyState = "" AutoReadOnly
	string Property StartingState = "Starting" AutoReadOnly
	string Property WageringState = "Wagering" AutoReadOnly
	string Property DealingState = "Dealing" AutoReadOnly
	string Property PlayingState = "Playing" AutoReadOnly
	string Property ScoringState = "Scoring" AutoReadOnly
EndGroup
