ScriptName Gambling:BlackJack:Game extends Gambling:BlackJack:GameType
import Gambling
import Gambling:BlackJack
import Gambling:Common
import Gambling:Shared

CustomEvent PhaseEvent


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


Function Exit()
	If (Idling == false)
		ChangeState(self, ExitingPhase)
	Else
		WriteLine(self, "The game has already exited.")
	EndIf
EndFunction


; Phases -------------------------------------

State Starting
	Event OnBeginState(string asOldState)
		Gambling:BlackJack:GameType.SendPhase(self, StartingPhase, Begun)

		If (GUI.PromptPlay())
			Table.Enable()

			If (Players.Allocate())
				Cards.Allocate()
				ChangeState(self, WageringPhase)
			Else
				WriteLine(self, "Aborting startup.")
				Exit()
			EndIf
		EndIf
	EndEvent

	Event OnEndState(string asNewState)
		If (asNewState == WageringPhase)
			Players.Startup()
		EndIf
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
		ChangeState(self, ExitingPhase)
	EndEvent

	Event OnEndState(string asNewState)
		Cards.CollectAll()
		Players.Deallocate()
		Table.Disable()
		Gambling:BlackJack:GameType.SendPhase(self, ScoringPhase, Ended)
	EndEvent
EndState


State Exiting
	Event OnBeginState(string asOldState)
		Gambling:BlackJack:GameType.SendPhase(self, ExitingPhase, Begun)
		ChangeState(self, IdlePhase)
	EndEvent

	Event OnEndState(string asNewState)
		; final clean up
		Gambling:BlackJack:GameType.SendPhase(self, ExitingPhase, Ended)
	EndEvent
EndState


; Functions
;---------------------------------------------

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

Group Game
	Components:Table Property Table Auto Const Mandatory
	Components:Cards Property Cards Auto Const Mandatory
	Components:Players Property Players Auto Const Mandatory
	Components:GUI Property GUI Auto Const Mandatory

	bool Property Idling Hidden
		bool Function Get()
			return self.GetState() == IdlePhase
		EndFunction
	EndProperty

	bool Property HasHuman Hidden
		bool Function Get()
			return Players.Contains(Players.Human)
		EndFunction
	EndProperty

	string Property BlackJack = 21 AutoReadOnly
EndGroup
