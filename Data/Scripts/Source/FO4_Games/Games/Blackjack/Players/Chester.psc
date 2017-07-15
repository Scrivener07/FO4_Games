ScriptName Games:Blackjack:Players:Chester extends Games:Blackjack:Player

;/ Personality
	none, simple AI
/;

; Personality
;---------------------------------------------

MarkerData Function GetMarkers()
	MarkerData marker = new MarkerData
	marker.Card01 = Games_Blackjack_P4C01
	marker.Card02 = Games_Blackjack_P4C02
	marker.Card03 = Games_Blackjack_P4C03
	marker.Card04 = Games_Blackjack_P4C04
	marker.Card05 = Games_Blackjack_P4C05
	marker.Card06 = Games_Blackjack_P4C06
	marker.Card07 = Games_Blackjack_P4C07
	marker.Card08 = Games_Blackjack_P4C08
	marker.Card09 = Games_Blackjack_P4C09
	marker.Card10 = Games_Blackjack_P4C10
	marker.Card11 = Games_Blackjack_P4C11
	return marker
EndFunction


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
