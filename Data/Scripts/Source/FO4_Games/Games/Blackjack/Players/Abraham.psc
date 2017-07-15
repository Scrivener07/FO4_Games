ScriptName Games:Blackjack:Players:Abraham extends Games:Blackjack:Player

;/ Personality
	High Roller (Whale)
	Be the highest betting player at the table.
	TODO: expose the highest bet among players
/;

; Personality
;---------------------------------------------

MarkerData Function GetMarkers()
	MarkerData marker = new MarkerData
	marker.Card01 = Games_Blackjack_P2C01
	marker.Card02 = Games_Blackjack_P2C02
	marker.Card03 = Games_Blackjack_P2C03
	marker.Card04 = Games_Blackjack_P2C04
	marker.Card05 = Games_Blackjack_P2C05
	marker.Card06 = Games_Blackjack_P2C06
	marker.Card07 = Games_Blackjack_P2C07
	marker.Card08 = Games_Blackjack_P2C08
	marker.Card09 = Games_Blackjack_P2C09
	marker.Card10 = Games_Blackjack_P2C10
	marker.Card11 = Games_Blackjack_P2C11
	return marker
EndFunction


int Function GetWager()
	return (Blackjack.Human.Wager * 3) + 50
EndFunction


; Properties
;---------------------------------------------

Group Markers
	ObjectReference Property Games_Blackjack_P2C01 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C02 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C03 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C04 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C05 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C06 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C07 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C08 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C09 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C10 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C11 Auto Const Mandatory
EndGroup
