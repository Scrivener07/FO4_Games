ScriptName Games:Blackjack:Players:Dealer extends Games:Blackjack:Player
import Games:Shared:Deck
import Games:Shared:Log

; States
;---------------------------------------------

State Wagering
	int Function IWager()
		WriteLine(self, "A dealer does not wager a bet.")
		return Invalid
	EndFunction
EndState


State Dealing
	Event OnDrawn(Card drawn, ObjectReference marker)
		parent.OnDrawn(drawn, marker)
		Utility.Wait(0.25)
	EndEvent
EndState


State Playing
	Event OnTurn(int number)
		If (number == 1)
			; reveal the face down card
			Motion.Translate(Hand[0].Reference, Seating.Card01Reveal)
		EndIf
	EndEvent

	Event OnDrawn(Card drawn, ObjectReference marker)
		parent.OnDrawn(drawn, marker)
		Utility.Wait(0.25)
	EndEvent

	int Function IChoice()
		If (Score <= 17)
			return ChoiceHit
		Else
			return ChoiceStand
		EndIf
	EndFunction
EndState


; Requests
;---------------------------------------------

int Function IWager()
	; Required for type-check return because function is not on object.
	return parent.IWager()
EndFunction

int Function IChoice()
	; Required for type-check return because function is not on object.
	return parent.IChoice()
EndFunction
