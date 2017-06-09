ScriptName Gambling:BlackJack:Players:Human extends Gambling:BlackJack:Player
import Gambling
import Gambling:Shared
import Gambling:Shared:Common


; Player
;---------------------------------------------

int Function BehaviorWager()
	return BlackJack.GUI.PromptWager()
EndFunction


int Function BehaviorTurn() ; hit or stand
	If (Turn == 1)
		int Card1 = Hand[0].Rank
		int Card2 = Hand[1].Rank
		int selected = BlackJack.GUI.ShowDealt(Card1, Card2, Score)
		return selected
	ElseIf (Turn >= 2)
		Deck:Card card = Hand[Turn]
		int selected = BlackJack.GUI.ShowTurn(card.Rank, Score)
		return selected
	EndIf
EndFunction
