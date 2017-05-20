ScriptName Gambling:BlackJack:Temps:Item extends Quest
import Gambling:Common

Actor Player


; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
	RegisterForRemoteEvent(Player, "OnItemEquipped")
	Player.AddItem(Gambling_CardsDefault_Token, 10, true)
EndEvent


Event Actor.OnItemEquipped(Actor akSender, Form akBaseObject, ObjectReference akReference)
	If (akBaseObject == Gambling_CardsDefault_Token)
		If (Utility.IsInMenuMode())
			Utility.Wait(0.5)
		EndIf
		Player.AddItem(Gambling_CardsDefault_Token, 1, true)
		Player.MoveTo(Gambling_CellMarker)
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Potion Property Gambling_CardsDefault_Token Auto Const Mandatory
	ObjectReference Property Gambling_CellMarker Auto Const Mandatory
EndGroup
