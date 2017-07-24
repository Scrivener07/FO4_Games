ScriptName Games:Blackjack:Players:Baxter extends Games:Blackjack:Player

;/ Personality
	Swatter
	Really likes to hit on their turn.
/;

; Tasks
;---------------------------------------------

State Starting
	Event SetMarkers(MarkerValue set)
		set.Card01 = Games_Blackjack_P3C01
		set.Card02 = Games_Blackjack_P3C02
		set.Card03 = Games_Blackjack_P3C03
		set.Card04 = Games_Blackjack_P3C04
		set.Card05 = Games_Blackjack_P3C05
		set.Card06 = Games_Blackjack_P3C06
		set.Card07 = Games_Blackjack_P3C07
		set.Card08 = Games_Blackjack_P3C08
		set.Card09 = Games_Blackjack_P3C09
		set.Card10 = Games_Blackjack_P3C10
		set.Card11 = Games_Blackjack_P3C11
	EndEvent
EndState


State Playing
	Event SetChoice(ChoiceValue set)
		If (Score <= 18)
			set.Selected = ChoiceHit
		Else
			set.Selected = ChoiceStand
		EndIf
	EndEvent
EndState


; Properties
;---------------------------------------------

Group Markers
	ObjectReference Property Games_Blackjack_P3C01 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P3C02 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P3C03 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P3C04 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P3C05 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P3C06 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P3C07 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P3C08 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P3C09 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P3C10 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P3C11 Auto Const Mandatory
EndGroup
