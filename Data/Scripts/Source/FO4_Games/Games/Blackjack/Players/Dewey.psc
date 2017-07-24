ScriptName Games:Blackjack:Players:Dewey extends Games:Blackjack:Player

;/ Personality
	none, simple AI
/;

; Tasks
;---------------------------------------------

State Starting
	Event SetMarkers(MarkerValue set)
		set.Card01 = Games_Blackjack_P5C01
		set.Card02 = Games_Blackjack_P5C02
		set.Card03 = Games_Blackjack_P5C03
		set.Card04 = Games_Blackjack_P5C04
		set.Card05 = Games_Blackjack_P5C05
		set.Card06 = Games_Blackjack_P5C06
		set.Card07 = Games_Blackjack_P5C07
		set.Card08 = Games_Blackjack_P5C08
		set.Card09 = Games_Blackjack_P5C09
		set.Card10 = Games_Blackjack_P5C10
		set.Card11 = Games_Blackjack_P5C11
	EndEvent
EndState


; Properties
;---------------------------------------------

Group Markers
	ObjectReference Property Games_Blackjack_P5C01 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P5C02 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P5C03 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P5C04 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P5C05 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P5C06 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P5C07 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P5C08 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P5C09 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P5C10 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P5C11 Auto Const Mandatory
EndGroup
