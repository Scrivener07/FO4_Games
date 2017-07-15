ScriptName Games:Blackjack:Players:Baxter extends Games:Blackjack:Player

;/ Personality
	Swatter
	Really likes to hit on their turn.
/;

; Personality
;---------------------------------------------

MarkerData Function GetMarkers()
	MarkerData marker = new MarkerData
	marker.Card01 = Games_Blackjack_P3C01
	marker.Card02 = Games_Blackjack_P3C02
	marker.Card03 = Games_Blackjack_P3C03
	marker.Card04 = Games_Blackjack_P3C04
	marker.Card05 = Games_Blackjack_P3C05
	marker.Card06 = Games_Blackjack_P3C06
	marker.Card07 = Games_Blackjack_P3C07
	marker.Card08 = Games_Blackjack_P3C08
	marker.Card09 = Games_Blackjack_P3C09
	marker.Card10 = Games_Blackjack_P3C10
	marker.Card11 = Games_Blackjack_P3C11
	return marker
EndFunction


int Function GetPlay()
	If (Score <= 18)
		return ChoiceHit
	Else
		return ChoiceStand
	EndIf
EndFunction


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
