Scriptname Gambling:BlackJack:Temps:Unalloc extends ObjectReference Const
import Gambling:Shared


; Events
;---------------------------------------------

Event OnActivate(ObjectReference akActionRef)
	Shoe.Unallocate()
EndEvent


; Properties
;---------------------------------------------

Group Components
	Cards:Shoe Property Shoe Auto Const Mandatory
EndGroup
