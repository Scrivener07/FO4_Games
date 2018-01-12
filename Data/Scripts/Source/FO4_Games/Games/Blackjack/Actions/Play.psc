Scriptname Games:Blackjack:Actions:Play extends ObjectReference Default
import Games
import Games:Papyrus:Log

; Events
;---------------------------------------------

Event OnActivate(ObjectReference akActionRef)
    WriteLine(self, "OnActivate")
	If (Blackjack.Dialog.PlayGame())
		Blackjack.Play(self)
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Blackjack:Game Property Blackjack Auto Const Mandatory
EndGroup
