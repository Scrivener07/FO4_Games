ScriptName Games:Blackjack:Players:Dewey extends Games:Blackjack:Player

;/ Personality
	none, simple AI
/;

; Personality
;---------------------------------------------

MarkerData Function CreateMarkers()
	MarkerData marker = new MarkerData
	marker.Card01 = Gambling_Blackjack_P5C01
	marker.Card02 = Gambling_Blackjack_P5C02
	marker.Card03 = Gambling_Blackjack_P5C03
	marker.Card04 = Gambling_Blackjack_P5C04
	marker.Card05 = Gambling_Blackjack_P5C05
	marker.Card06 = Gambling_Blackjack_P5C06
	marker.Card07 = Gambling_Blackjack_P5C07
	marker.Card08 = Gambling_Blackjack_P5C08
	marker.Card09 = Gambling_Blackjack_P5C09
	marker.Card10 = Gambling_Blackjack_P5C10
	marker.Card11 = Gambling_Blackjack_P5C11
	return marker
EndFunction


; Properties
;---------------------------------------------

Group Markers
	ObjectReference Property Gambling_Blackjack_P5C01 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P5C02 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P5C03 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P5C04 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P5C05 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P5C06 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P5C07 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P5C08 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P5C09 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P5C10 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P5C11 Auto Const Mandatory
EndGroup
