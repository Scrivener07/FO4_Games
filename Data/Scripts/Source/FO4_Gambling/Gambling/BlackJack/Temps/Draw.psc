Scriptname Gambling:BlackJack:Temps:Draw extends ObjectReference Const
import Gambling:Shared
import Gambling:Common


; Events
;---------------------------------------------

Event OnActivate(ObjectReference akActionRef)
	Shoe.Draw()
EndEvent


; Properties
;---------------------------------------------

Group Components
	Cards:Shoe Property Shoe Auto Const Mandatory
EndGroup
