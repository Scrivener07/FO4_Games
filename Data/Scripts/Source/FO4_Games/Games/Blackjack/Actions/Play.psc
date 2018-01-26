Scriptname Games:Blackjack:Actions:Play extends ObjectReference Default
import Games
import Games:Shared:Log

; Events
;---------------------------------------------

Event OnActivate(ObjectReference akActionRef)
    WriteLine(self, "OnActivate")
	Blackjack.PlayAsk(self)
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Blackjack:Game Property Blackjack Auto Const Mandatory
EndGroup
