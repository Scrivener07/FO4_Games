Scriptname Gambling:BlackJack:Actions:Play extends ObjectReference
import Gambling


Actor Player


; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
EndEvent


Event OnActivate(ObjectReference akActionRef)
	Player.MoveTo(Gambling_CellMarker)
	RegisterForRemoteEvent(Gambling_BlackJack_SeatA, "OnActivate")
EndEvent


Event ObjectReference.OnActivate(ObjectReference akSender, ObjectReference akActionRef)
	Utility.Wait(5)
	BlackJack.Play()
EndEvent


; Properties
;---------------------------------------------

Group Properties
	BlackJack:Main Property BlackJack Auto Const Mandatory
	ObjectReference Property Gambling_CellMarker Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_SeatA Auto Const Mandatory
EndGroup


