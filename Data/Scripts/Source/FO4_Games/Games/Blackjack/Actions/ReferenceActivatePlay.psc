Scriptname Games:Blackjack:Actions:ReferenceActivatePlay extends ObjectReference Default
{Begin playing Blackjack after this object reference has been activated.}

; Events
;---------------------------------------------

Event OnActivate(ObjectReference akActionRef)
	Games:Shared:Log.WriteLine(self, "OnActivate is starting Blackjack.")
	Blackjack.PlayAsk(self)
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Games:Blackjack:Game Property Blackjack Auto Const Mandatory
EndGroup
