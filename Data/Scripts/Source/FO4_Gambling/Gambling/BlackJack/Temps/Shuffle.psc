Scriptname Gambling:BlackJack:Temps:Shuffle extends ObjectReference Const
import Gambling:Shared


; Events
;---------------------------------------------

Event OnActivate(ObjectReference akActionRef)
	Shoe.Shuffle()
EndEvent


; Properties
;---------------------------------------------

Group Components
	Cards:Shoe Property Shoe Auto Const Mandatory
EndGroup
