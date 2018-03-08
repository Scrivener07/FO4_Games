ScriptName Games:Shared:Motion extends Quest Default
import Games:Shared:Log
import Games:Shared:Papyrus

int Index = -1

ObjectReference[] Objects
ObjectReference Destination
float Speed = -1.0

int Motion_Keyframed = 2 const


; Methods
;---------------------------------------------

Function Translate(ObjectReference aObject, ObjectReference aDestination, float aSpeed = 100.0)
	ObjectReference[] array = new ObjectReference[1]
	array[0] = aObject
	TranslateEach(array, aDestination, aSpeed)
EndFunction


Function TranslateEach(ObjectReference[] aObjects, ObjectReference aDestination, float aSpeed = 100.0)
	Objects = aObjects
	Destination = aDestination
	Speed = aSpeed
	AwaitState(self)
EndFunction


; States
;---------------------------------------------

State Busy
	Event OnBeginState(string asOldState)
		If (Objects)
			int idx = 0
			While (idx < Objects.Length)
				ObjectReference object = Objects[idx]
				object.SetMotionType(Motion_Keyframed)
				RegisterForRemoteEvent(object, "OnTranslationComplete")
				RegisterForRemoteEvent(object, "OnTranslationFailed")
				object.TranslateToRef(Destination, Speed)
				idx += 1
			EndWhile
		Else
			WriteUnexpectedValue(self, "Busy.OnBeginState", "Objects", "Cannot translate empty or none object array.")
			ClearState(self)
		EndIf
	EndEvent


	Event ObjectReference.OnTranslationComplete(ObjectReference akSender)
		Evaluate()
	EndEvent


	Event ObjectReference.OnTranslationFailed(ObjectReference akSender)
		WriteUnexpectedValue(self, "Busy.ObjectReference.OnTranslationFailed", "akSender", "Failed for reference '"+akSender+"' at index "+Index)
		Evaluate()
	EndEvent


	Function Evaluate()
		Index += 1
		int last = Objects.Length - 1

		If (Index >= last)
			ClearState(self)
		EndIf
	EndFunction


	Event OnEndState(string asNewState)
		UnregisterForAllRemoteEvents()
		Index = -1
		Objects = none
		Destination = none
		Speed = -1.0
	EndEvent

	Function Translate(ObjectReference aObject, ObjectReference aDestination, float aSpeed = 100.0)
		{EMPTY}
		WriteNotImplemented(self, "Busy.Translate", "The member is not implemented in the '"+GetState()+"' state.")
	EndFunction

	Function TranslateEach(ObjectReference[] aObjects, ObjectReference aDestination, float aSpeed = 100.0)
		{EMPTY}
		WriteNotImplemented(self, "Busy.TranslateEach", "The member is not implemented in the '"+GetState()+"' state.")
	EndFunction
EndState


Event ObjectReference.OnTranslationComplete(ObjectReference akSender)
	{EMPTY}
	WriteNotImplemented(self, "ObjectReference.OnTranslationComplete", "The member is not implemented in the empty state.")
EndEvent

Event ObjectReference.OnTranslationFailed(ObjectReference akSender)
	{EMPTY}
	WriteNotImplemented(self, "ObjectReference.OnTranslationFailed", "The member is not implemented in the empty state.")
EndEvent

Function Evaluate()
	{EMPTY}
	WriteNotImplemented(self, "Evaluate", "The member is not implemented in the empty state.")
EndFunction
