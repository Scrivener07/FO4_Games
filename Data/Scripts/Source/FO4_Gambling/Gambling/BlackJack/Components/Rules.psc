ScriptName Gambling:Blackjack:Components:Rules extends Gambling:Blackjack:Component
import Gambling
import Gambling:Shared:Deck


; Functions
;---------------------------------------------

bool Function IsWin(int aScore)
	return aScore == Win
EndFunction


bool Function IsInPlay(int aScore)
	return aScore < Win
EndFunction


bool Function IsBust(int aScore)
	return aScore > Win
EndFunction


int Function GetScore(Card[] aCards, int aScore)
	int score = 0
	int index = 0
	While (index < aCards.Length)
		score += ToScore(aCards[index], aScore)
		index += 1
	EndWhile
	return score
EndFunction


int Function ToScore(Card aCard, int aScore)
	If (aCard.Rank == Blackjack.Cards.Deck.Ace)
		If (aScore + 11 > Win)
			return 1
		Else
			return 11
		EndIf
	ElseIf (Blackjack.Cards.Deck.IsFaceCard(aCard))
		return 10
	Else
		return aCard.Rank
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Game
	Blackjack:Game Property Blackjack Auto Const Mandatory
EndGroup

Group ReadOnly
	int Property Win = 21 AutoReadOnly
EndGroup
