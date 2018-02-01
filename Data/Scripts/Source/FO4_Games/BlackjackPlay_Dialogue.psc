Scriptname BlackjackPlay_Dialogue extends TopicInfo
{Attaches to NPC dialogue.}

Event OnEnd(ObjectReference akSpeakerRef, bool abHasBeenSaid)
	Blackjack.Play(akSpeakerRef)
EndEvent

Games:Blackjack:Game Property Blackjack Auto Const Mandatory
