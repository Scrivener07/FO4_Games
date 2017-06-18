Scriptname Gambling:Blackjack:Actions:Play extends ObjectReference
import Gambling


; Events
;---------------------------------------------

Event OnActivate(ObjectReference akActionRef)
	Blackjack.Play(self)
EndEvent

; Properties
;---------------------------------------------

Group Properties
	Blackjack:Game Property Blackjack Auto Const Mandatory
EndGroup
