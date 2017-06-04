ScriptName Gambling:BlackJack:Game extends Gambling:BlackJack:GameType
import Gambling
import Gambling:Common
import Gambling:Shared


CustomEvent PhaseEvent


; Methods
;---------------------------------------------

State Starting
	Event OnBeginState(string asOldState)
		Gambling:BlackJack:GameType.SendPhase(self, StartingPhase, Begun)

		If (Players.Allocate() && HasHuman)
			Cards.Allocate()
			Players.Startup()
			ChangeState(self, WageringPhase)
		Else
			WriteLine(self, "Aborting startup.")
			Exit()
		EndIf
	EndEvent

	Event OnEndState(string asNewState)
		Gambling:BlackJack:GameType.SendPhase(self, StartingPhase, Ended)
	EndEvent
EndState


State Wagering
	Event OnBeginState(string asOldState)
		Gambling:BlackJack:GameType.SendPhase(self, WageringPhase, Begun)

		Players.Wager()

		ChangeState(self, DealingPhase)
	EndEvent

	Event OnEndState(string asNewState)
		Gambling:BlackJack:GameType.SendPhase(self, WageringPhase, Ended)
	EndEvent
EndState


State Dealing
	Event OnBeginState(string asOldState)
		Gambling:BlackJack:GameType.SendPhase(self, DealingPhase, Begun)

		Cards.Shuffle()
		Players.Deal(Cards.Deck)

		ChangeState(self, PlayingPhase)
	EndEvent

	Event OnEndState(string asNewState)
		Gambling:BlackJack:GameType.SendPhase(self, DealingPhase, Ended)
	EndEvent
EndState


State Playing
	Event OnBeginState(string asOldState)
		Gambling:BlackJack:GameType.SendPhase(self, PlayingPhase, Begun)

		Players.Play()

		ChangeState(self, ScoringPhase)
	EndEvent

	Event OnEndState(string asNewState)
		Gambling:BlackJack:GameType.SendPhase(self, PlayingPhase, Ended)
	EndEvent
EndState


State Scoring
	Event OnBeginState(string asOldState)
		Gambling:BlackJack:GameType.SendPhase(self, ScoringPhase, Begun)
		Exit()
	EndEvent

	Event OnEndState(string asNewState)
		Cards.GoHome()
		Players.Deallocate()
		Gambling:BlackJack:GameType.SendPhase(self, ScoringPhase, Ended)
	EndEvent
EndState


; Functions
;---------------------------------------------

bool Function Play()
	If (Exited)
		return ChangeState(self, StartingPhase)
	Else
		WriteLine(self, "The game is not ready to play right now.")
		return false
	EndIf
EndFunction


Function Exit()
	If !(Exited)
		ChangeState(self, ReadyPhase)
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


; Properties
;---------------------------------------------

Group Properties
	Components:View Property View Auto Const Mandatory
	Components:Players Property Players Auto Const Mandatory
	Components:Cards Property Cards Auto Const Mandatory
EndGroup


Group ReadOnly
	bool Property Exited Hidden
		bool Function Get()
			return self.GetState() == ReadyPhase
		EndFunction
	EndProperty

	bool Property HasHuman Hidden
		bool Function Get()
			return Players.Contains(Players.Human)
		EndFunction
	EndProperty
EndGroup


Group Rules
	string Property BlackJack = 21 AutoReadOnly
EndGroup
