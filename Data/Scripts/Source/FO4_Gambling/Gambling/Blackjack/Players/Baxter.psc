ScriptName Gambling:Blackjack:Players:Baxter extends Gambling:Blackjack:Player
import Gambling:Shared:Common

;/ Personality
	Swatter
	Really likes to hit on their turn.
/;

; Personality
;---------------------------------------------

MarkerData Function CreateMarkers()
	MarkerData marker = new MarkerData
	marker.Card01 = Gambling_Blackjack_P3C01
	marker.Card02 = Gambling_Blackjack_P3C02
	marker.Card03 = Gambling_Blackjack_P3C03
	marker.Card04 = Gambling_Blackjack_P3C04
	marker.Card05 = Gambling_Blackjack_P3C05
	marker.Card06 = Gambling_Blackjack_P3C06
	marker.Card07 = Gambling_Blackjack_P3C07
	marker.Card08 = Gambling_Blackjack_P3C08
	marker.Card09 = Gambling_Blackjack_P3C09
	marker.Card10 = Gambling_Blackjack_P3C10
	marker.Card11 = Gambling_Blackjack_P3C11
	return marker
EndFunction


int Function AskChoice()
	If (Score <= 18)
		return ChoiceHit
	Else
		return ChoiceStand
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Markers
	ObjectReference Property Gambling_Blackjack_P3C01 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P3C02 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P3C03 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P3C04 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P3C05 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P3C06 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P3C07 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P3C08 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P3C09 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P3C10 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P3C11 Auto Const Mandatory
EndGroup
