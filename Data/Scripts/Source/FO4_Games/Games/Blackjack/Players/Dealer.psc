ScriptName Games:Blackjack:Players:Dealer extends Games:Blackjack:Player
import Games:Papyrus:Log


; FSM - Finite State Machine
;---------------------------------------------

State Starting
	Event SetMarkers(MarkerValue set)
		set.Card01 = Games_Blackjack_D1C01
		set.Card02 = Games_Blackjack_D1C02
		set.Card03 = Games_Blackjack_D1C03
		set.Card04 = Games_Blackjack_D1C04
		set.Card05 = Games_Blackjack_D1C05
		set.Card06 = Games_Blackjack_D1C06
		set.Card07 = Games_Blackjack_D1C07
		set.Card08 = Games_Blackjack_D1C08
		set.Card09 = Games_Blackjack_D1C09
		set.Card10 = Games_Blackjack_D1C10
		set.Card11 = Games_Blackjack_D1C11
	EndEvent
EndState


State Wagering
	Event SetWager(WagerValue set)
		set.Bet = Invalid
		WriteLine(self, "Skipping, a dealer does not wager a bet.")
	EndEvent
EndState


State Playing
	Event PlayTurn(int aTurn)
		If (aTurn == 1)
			; reveal the face down card
			Motion.Translate(Hand[0].Reference, Games_Blackjack_D1C01B)
		EndIf
	EndEvent

	Event SetChoice(ChoiceValue set)
		If (Score <= 17)
			set.Selected = ChoiceHit
		Else
			set.Selected = ChoiceStand
		EndIf
	EndEvent
EndState


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
