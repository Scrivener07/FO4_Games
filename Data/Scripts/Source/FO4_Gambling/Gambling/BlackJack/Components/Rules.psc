ScriptName Gambling:BlackJack:Components:Rules extends Gambling:BlackJack:Component
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
	If (aCard.Rank == BlackJack.Cards.Deck.Ace)
		If (aScore + 11 > Win)
			return 1
		Else
			return 11
		EndIf
	ElseIf (BlackJack.Cards.Deck.IsFaceCard(aCard))
		return 10
	Else
		return aCard.Rank
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Game
	BlackJack:Game Property BlackJack Auto Const Mandatory
EndGroup

Group ReadOnly
	int Property Win = 21 AutoReadOnly
EndGroup
