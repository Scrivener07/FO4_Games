Scriptname Gambling:Blackjack:Actions:Play extends Form Default
import Gambling
import Gambling:Shared:Common

; Events
;---------------------------------------------

Event OnInit()
	ScriptObject object = self as ScriptObject

	If (object is ObjectReference)
		ObjectReference script = object as ObjectReference
		RegisterForRemoteEvent(script, "OnActivate")

	ElseIf (object is TopicInfo)
		TopicInfo script = object as TopicInfo

		If (UseBegin)
			RegisterForRemoteEvent(script, "OnBegin")
		Else
			RegisterForRemoteEvent(script, "OnEnd")
		EndIf
	Else
		WriteLine(self, "The script type is unhandled.")
	EndIf
EndEvent


; Remotes
;---------------------------------------------

Event ObjectReference.OnActivate(ObjectReference akSender, ObjectReference akActionRef)
	WriteLine(self, "ObjectReference.OnActivate")

	If (Blackjack.GUI.PromptPlay())
		Blackjack.Play(akSender)
	EndIf
EndEvent


Event TopicInfo.OnBegin(TopicInfo akSender, ObjectReference akSpeakerRef, bool abHasBeenSaid)
	WriteLine(self, "TopicInfo.OnBegin")
	Blackjack.Play(akSpeakerRef)
EndEvent


Event TopicInfo.OnEnd(TopicInfo akSender, ObjectReference akSpeakerRef, bool abHasBeenSaid)
	WriteLine(self, "TopicInfo.OnBegin")
	Blackjack.Play(akSpeakerRef)
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Blackjack:Game Property Blackjack Auto Const Mandatory
EndGroup

Group Optional
	bool Property UseBegin = false Auto Const
EndGroup
