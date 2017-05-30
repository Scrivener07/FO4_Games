Scriptname Gambling:BlackJack:Temps:Alloc extends ObjectReference Const
import Gambling:Shared


; Events
;---------------------------------------------

Event OnActivate(ObjectReference akActionRef)
	Shoe.Allocate()
EndEvent


; Properties
;---------------------------------------------

Group Components
	Cards:Shoe Property Shoe Auto Const Mandatory
EndGroup
