Scriptname Gambling:BlackJack:Temps:Move extends ObjectReference Const
import Gambling

; Events
;---------------------------------------------

Event OnActivate(ObjectReference akActionRef)
	BlackJack.Cards.Position(TableReference)
EndEvent


; Properties
;---------------------------------------------

Group Properties
	BlackJack:Main Property BlackJack Auto Const Mandatory
	ObjectReference Property TableReference Auto Const Mandatory
EndGroup
