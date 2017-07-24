ScriptName Games:Blackjack:Players:Chester extends Games:Blackjack:Player

;/ Personality
	none, simple AI
/;

; Tasks
;---------------------------------------------

State Starting
	Event SetMarkers(MarkerValue set)
		set.Card01 = Games_Blackjack_P4C01
		set.Card02 = Games_Blackjack_P4C02
		set.Card03 = Games_Blackjack_P4C03
		set.Card04 = Games_Blackjack_P4C04
		set.Card05 = Games_Blackjack_P4C05
		set.Card06 = Games_Blackjack_P4C06
		set.Card07 = Games_Blackjack_P4C07
		set.Card08 = Games_Blackjack_P4C08
		set.Card09 = Games_Blackjack_P4C09
		set.Card10 = Games_Blackjack_P4C10
		set.Card11 = Games_Blackjack_P4C11
	EndEvent
EndState


; Properties
;---------------------------------------------

Group Markers
	ObjectReference Property Games_Blackjack_P4C01 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P4C02 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P4C03 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P4C04 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P4C05 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P4C06 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P4C07 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P4C08 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P4C09 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P4C10 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P4C11 Auto Const Mandatory
EndGroup
