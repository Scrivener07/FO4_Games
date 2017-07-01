ScriptName Games:Blackjack:Players:Human extends Games:Blackjack:Player
import Games:Shared:Common

Actor Player


; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
EndEvent


; Personality
;---------------------------------------------

MarkerData Function CreateMarkers()
	MarkerData marker = new MarkerData
	marker.Card01 = Gambling_Blackjack_P1C01
	marker.Card02 = Gambling_Blackjack_P1C02
	marker.Card03 = Gambling_Blackjack_P1C03
	marker.Card04 = Gambling_Blackjack_P1C04
	marker.Card05 = Gambling_Blackjack_P1C05
	marker.Card06 = Gambling_Blackjack_P1C06
	marker.Card07 = Gambling_Blackjack_P1C07
	marker.Card08 = Gambling_Blackjack_P1C08
	marker.Card09 = Gambling_Blackjack_P1C09
	marker.Card10 = Gambling_Blackjack_P1C10
	marker.Card11 = Gambling_Blackjack_P1C11
	return marker
EndFunction


int Function AskWager()
	return Blackjack.GUI.PromptWager(self)
EndFunction


int Function AskChoice()
	int selected = Invalid

	If (Turn == 1)
		; show last two drawn cards
		selected = Blackjack.GUI.ShowTurn(Hand[0].Rank, Hand[1].Rank, Score)
	ElseIf (Turn >= 2)
		; show last drawn card
		selected = Blackjack.GUI.ShowTurnDealt(Hand[Last].Rank, Score)
	EndIf

	return selected
EndFunction


; Properties
;---------------------------------------------

Group Human
	int Property Caps Hidden
		int Function Get()
			return Player.GetGoldAmount()
		EndFunction
	EndProperty

	bool Property HasCaps Hidden
		bool Function Get()
			return Caps > 0
		EndFunction
	EndProperty
EndGroup

Group Markers
	ObjectReference Property Gambling_Blackjack_P1C01 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P1C02 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P1C03 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P1C04 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P1C05 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P1C06 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P1C07 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P1C08 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P1C09 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P1C10 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_P1C11 Auto Const Mandatory
EndGroup
