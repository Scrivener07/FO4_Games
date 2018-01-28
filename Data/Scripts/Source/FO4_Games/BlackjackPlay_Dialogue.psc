Scriptname BlackjackPlay_Dialogue extends TopicInfo

Event OnEnd(ObjectReference akSpeakerRef, bool abHasBeenSaid)
  
Blackjack.Play(akSpeakerRef)

endEvent

Games:Blackjack:Game Property Blackjack Auto Const Mandatory