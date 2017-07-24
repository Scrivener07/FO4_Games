ScriptName Games:Shared:Tasks:Motion extends Games:Shared:Task
import Games:Shared:Common


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
	self.Await()
EndFunction


; Task
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
			WriteLine(self,  "No objects to translate.")
			self.AwaitEnd()
		EndIf
	EndEvent


	Event ObjectReference.OnTranslationComplete(ObjectReference akSender)
		Evaluate()
	EndEvent


	Event ObjectReference.OnTranslationFailed(ObjectReference akSender)
		WriteLine(self,  "Failed for reference '"+akSender+"' at index "+Index)
		Evaluate()
	EndEvent


	Function Evaluate()
		Index += 1
		int last = Objects.Length - 1

		If (Index >= last)
			self.AwaitEnd()
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
	EndFunction

	Function TranslateEach(ObjectReference[] aObjects, ObjectReference aDestination, float aSpeed = 100.0)
		{EMPTY}
	EndFunction
EndState


Event ObjectReference.OnTranslationComplete(ObjectReference akSender)
	{EMPTY}
EndEvent

Event ObjectReference.OnTranslationFailed(ObjectReference akSender)
	{EMPTY}
EndEvent

Function Evaluate()
	{EMPTY}
EndFunction
