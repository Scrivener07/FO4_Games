ScriptName Games:Blackjack:Players:Dealer extends Games:Blackjack:Player
import Games:Shared:Log

; States
;---------------------------------------------

State Starting
	MarkerValue Function IMarkers()
		MarkerValue marker = new MarkerValue
		marker.Card01 = Games_Blackjack_D1C01
		marker.Card02 = Games_Blackjack_D1C02
		marker.Card03 = Games_Blackjack_D1C03
		marker.Card04 = Games_Blackjack_D1C04
		marker.Card05 = Games_Blackjack_D1C05
		marker.Card06 = Games_Blackjack_D1C06
		marker.Card07 = Games_Blackjack_D1C07
		marker.Card08 = Games_Blackjack_D1C08
		marker.Card09 = Games_Blackjack_D1C09
		marker.Card10 = Games_Blackjack_D1C10
		marker.Card11 = Games_Blackjack_D1C11
		return marker
	EndFunction
EndState


State Wagering
	int Function IWager()
		WriteLine(self, "A dealer does not wager a bet.")
		return Invalid
	EndFunction
EndState


State Playing
	Event OnTurn(int aTurn)
		If (aTurn == 1)
			; reveal the face down card
			Motion.Translate(Hand[0].Reference, Games_Blackjack_D1C01B)
		EndIf
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

MarkerValue Function IMarkers()
	; Required for type-check return because function is not on object.
	return parent.IMarkers()
EndFunction

int Function IWager()
	; Required for type-check return because function is not on object.
	return parent.IWager()
EndFunction

int Function IChoice()
	; Required for type-check return because function is not on object.
	return parent.IChoice()
EndFunction


; Properties
;---------------------------------------------

Group Markers
	ObjectReference Property Games_Blackjack_D1C01 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_D1C01B Auto Const Mandatory
	ObjectReference Property Games_Blackjack_D1C02 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_D1C03 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_D1C04 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_D1C05 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_D1C06 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_D1C07 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_D1C08 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_D1C09 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_D1C10 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_D1C11 Auto Const Mandatory
EndGroup
