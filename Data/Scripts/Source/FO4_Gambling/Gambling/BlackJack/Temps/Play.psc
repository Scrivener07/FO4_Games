Scriptname Gambling:BlackJack:Temps:Play extends ObjectReference Const
import Gambling

; Events
;---------------------------------------------

Event OnActivate(ObjectReference akActionRef)
	BlackJack.Play()
EndEvent


; Properties
;---------------------------------------------

Group Components
	BlackJack:Main Property BlackJack Auto Const Mandatory
EndGroup
