Scriptname Gambling:BlackJack:Temps:Move extends ObjectReference Const
import Gambling

; Events
;---------------------------------------------

Event OnActivate(ObjectReference akActionRef)
	BlackJack.Cards.Position()
EndEvent


; Properties
;---------------------------------------------

Group Components
	BlackJack:Main Property BlackJack Auto Const Mandatory
EndGroup
