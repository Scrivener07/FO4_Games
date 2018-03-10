Scriptname Games:Blackjack:Actions:TopicInfoPlay extends TopicInfo Default
{Begin playing Blackjack after this topic info has ended.}

; Events
;---------------------------------------------

Event OnEnd(ObjectReference akSpeakerRef, bool abHasBeenSaid)
	Games:Shared:Log.WriteLine(self, "OnEnd is starting Blackjack with "+akSpeakerRef+" speaker.")
	Blackjack.Play(akSpeakerRef)
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Games:Blackjack:Main Property Blackjack Auto Const Mandatory
EndGroup
