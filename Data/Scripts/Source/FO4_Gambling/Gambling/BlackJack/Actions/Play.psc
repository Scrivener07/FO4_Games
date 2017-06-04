Scriptname Gambling:BlackJack:Actions:Play extends ObjectReference
import Gambling


; Events
;---------------------------------------------

Event OnActivate(ObjectReference akActionRef)
	BlackJack.Play(self)
EndEvent

; Properties
;---------------------------------------------

Group Properties
	BlackJack:Game Property BlackJack Auto Const Mandatory
EndGroup
