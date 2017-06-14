ScriptName Gambling:BlackJack:Players:Dealer extends Gambling:BlackJack:Player
import Gambling:Shared:Common


; Personality
;---------------------------------------------

MarkerData Function CreateMarkers()
	MarkerData marker = new MarkerData
	marker.Card01 = Gambling_BlackJack_D1C01
	marker.Card02 = Gambling_BlackJack_D1C02
	marker.Card03 = Gambling_BlackJack_D1C03
	marker.Card04 = Gambling_BlackJack_D1C04
	marker.Card05 = Gambling_BlackJack_D1C05
	marker.Card06 = Gambling_BlackJack_D1C06
	marker.Card07 = Gambling_BlackJack_D1C07
	marker.Card08 = Gambling_BlackJack_D1C08
	marker.Card09 = Gambling_BlackJack_D1C09
	marker.Card10 = Gambling_BlackJack_D1C10
	marker.Card11 = Gambling_BlackJack_D1C11
	return marker
EndFunction


int Function AskWager()
	WriteLine(self, "Skipping, a dealer does not wager a bet.")
	return Invalid
EndFunction


bool Function PlayNext()
	PlayDefault()

	If (Turn == 1)
		; reveal the face down card
		Motion.Translate(Hand[0].Reference, Gambling_BlackJack_D1C01B)
	EndIf

	return PlayProcess()
EndFunction


; Properties
;---------------------------------------------

Group Markers
	ObjectReference Property Gambling_BlackJack_D1C01 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_D1C01B Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_D1C02 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_D1C03 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_D1C04 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_D1C05 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_D1C06 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_D1C07 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_D1C08 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_D1C09 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_D1C10 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_D1C11 Auto Const Mandatory
EndGroup
