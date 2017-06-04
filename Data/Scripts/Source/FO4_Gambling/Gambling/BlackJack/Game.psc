ScriptName Gambling:BlackJack:Main extends Quest
import Gambling
import Gambling:BlackJack
import Gambling:Common
import Gambling:Shared

CustomEvent OnPhase

Struct PhaseEventArgs
	string Name
	bool Change = true
EndStruct

int BlackJack = 21 const


; Methods
;---------------------------------------------

State Starting
	Event OnBeginState(string asOldState)
		SendPhase(StartingState, Begun)

		If (Players.Allocate())
			Cards.Allocate()
			Players.Startup()
			ChangeState(self, WageringState)
		Else
			WriteLine(self, "Aborting startup.")
			Exit()
		EndIf
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(StartingState, Ended)
	EndEvent
EndState


State Wagering
	Event OnBeginState(string asOldState)
		SendPhase(WageringState, Begun)

		Players.Wager()

		ChangeState(self, DealingState)
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(WageringState, Ended)
	EndEvent
EndState


State Dealing
	Event OnBeginState(string asOldState)
		SendPhase(DealingState, Begun)

		Cards.Shuffle()
		Players.Deal(Cards.Deck)

		ChangeState(self, PlayingState)
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(DealingState, Ended)
	EndEvent
EndState


State Playing
	Event OnBeginState(string asOldState)
		SendPhase(PlayingState, Begun)

		Players.Play()

		ChangeState(self, ScoringState)
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(PlayingState, Ended)
	EndEvent
EndState


State Scoring
	Event OnBeginState(string asOldState)
		SendPhase(ScoringState, Begun)
		Exit()
	EndEvent

	Event OnEndState(string asNewState)
		Cards.GoHome()
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


int Function GetScore(Deck:Card[] aCards, int aScore)
	int score = 0
	int index = 0
	While (index < aCards.Length)
		score += CardToScore(aCards[index], aScore)
		index += 1
	EndWhile
	return score
EndFunction


int Function CardToScore(Deck:Card aCard, int aScore)
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


Function SendPhase(string aName, bool aChange)
	string sState = self.GetState()
	If (sState == aName)
		PhaseEventArgs Phase = new PhaseEventArgs
		Phase.Name = aName
		Phase.Change = aChange

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

	bool Property HasHuman Hidden
		bool Function Get()
			return Players.Contains(Players.PlayerA)
		EndFunction
	EndProperty
EndGroup

Group States
	string Property EmptyState = "" AutoReadOnly
	string Property StartingState = "Starting" AutoReadOnly
	string Property WageringState = "Wagering" AutoReadOnly
	string Property DealingState = "Dealing" AutoReadOnly
	string Property PlayingState = "Playing" AutoReadOnly
	string Property ScoringState = "Scoring" AutoReadOnly
EndGroup

Group Changes
	bool Property Begun = false AutoReadOnly
	bool Property Ended = true AutoReadOnly
EndGroup
