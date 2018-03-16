ScriptName Games:Shared:Motion extends Games:Type Default
import Games
import Games:Shared:Log
import Games:Shared:Papyrus

MotionData Motion
ObjectReference[] Objects
CustomEvent TranslationEvent

; Constants
string TranslatingState = "Translating" const
int Motion_Keyframed = 2 const

Struct MotionData
	int Index = 0
	ObjectReference Destination
	float Speed = -1.0
EndStruct


; Methods
;---------------------------------------------

Function Translate(ObjectReference from, ObjectReference to, float speed = 100.0)
	ObjectReference[] array = new ObjectReference[1]
	array[0] = from
	TranslateEach(array, to, speed)
EndFunction


Function TranslateEach(ObjectReference[] array, ObjectReference to, float speed = 100.0)
	Objects = array
	Motion = new MotionData
	Motion.Speed = speed
	Motion.Destination = to
	AwaitState(self, TranslatingState)
EndFunction


; OnTranslation
;---------------------------------------------

Struct TranslationEventArgs
	ObjectReference From
	ObjectReference To
	int Translation = -1
EndStruct

Group Translation
	int Property TranslationFinished = 0 AutoReadOnly
	int Property TranslationStarted = 1 AutoReadOnly
	int Property TranslationCompleted = 2 AutoReadOnly
	int Property TranslationFailed = 3 AutoReadOnly
EndGroup

bool Function SendTranslationEvent(Shared:Motion sender, ObjectReference from, ObjectReference to, int translation)
	If (sender.StateName == TranslatingState)
		TranslationEventArgs e = new TranslationEventArgs
		e.From = from
		e.To = to
		e.Translation = translation
		var[] arguments = new var[1]
		arguments[0] = e
		sender.SendCustomEvent("TranslationEvent", arguments)
		WriteLine(self, "SendTranslationEvent :: EventArg:"+e+", Motion:"+Motion)
		return true
	Else
		WriteUnexpectedValue(sender, "SendTranslationEvent", "StateName", "A translation event must happen while inside the '"+TranslatingState+"' state.")
		return false
	EndIf
EndFunction


bool Function RegisterForTranslationEvent(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "TranslationEvent")
		return true
	Else
		WriteUnexpectedValue(self, "RegisterForTranslationEvent", "script", "Cannot register a none script for an event.")
		return false
	EndIf
EndFunction


bool Function UnregisterForTranslationEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "TranslationEvent")
		return true
	Else
		WriteUnexpectedValue(self, "UnregisterForTranslationEvent", "script", "Cannot unregister a none script for an event.")
		return false
	EndIf
EndFunction


TranslationEventArgs Function GetTranslationEventArgs(var[] arguments)
	If (arguments)
		return arguments[0] as TranslationEventArgs
	Else
		return none
	EndIf
EndFunction


; States
;---------------------------------------------

State Translating
	Event OnBeginState(string oldState)
		If (Objects)
			WriteLine(self, "Translating.OnBeginState :: Starting translation for "+Objects.Length+" objects.")
			int index = 0
			While (index < Objects.Length)
				ObjectReference object = Objects[index]
				object.SetMotionType(Motion_Keyframed)
				RegisterForRemoteEvent(object, "OnTranslationComplete")
				RegisterForRemoteEvent(object, "OnTranslationFailed")
				object.TranslateToRef(Motion.Destination, Motion.Speed)
				SendTranslationEvent(self, object, Motion.Destination, TranslationStarted)
				index += 1
				WriteLine(self, "Translating.OnBeginState :: Started translation @"+index+", object:"+object)
			EndWhile
		Else
			WriteUnexpectedValue(self, "Translating.OnBeginState", "Objects", "Cannot translate empty or none object array.")
			ClearState(self)
		EndIf
	EndEvent


	Event ObjectReference.OnTranslationComplete(ObjectReference sender)
		SendTranslationEvent(self, sender, Motion.Destination, TranslationCompleted)

		If (MoveNext())
			WriteLine(self, "Translating.ObjectReference.OnTranslationComplete :: MoveNext")
		Else
			WriteLine(self, "Translating.ObjectReference.OnTranslationComplete :: TranslationFinished")
			SendTranslationEvent(self, sender, Motion.Destination, TranslationFinished)
			ClearState(self)
		EndIf
	EndEvent


	Event ObjectReference.OnTranslationFailed(ObjectReference sender)
		WriteUnexpectedValue(self, "Translating.ObjectReference.OnTranslationFailed", "sender", "Failed for reference '"+sender+"' at index "+Motion.Index)
		SendTranslationEvent(self, sender, Motion.Destination, TranslationFailed)

		If (MoveNext())
			WriteLine(self, "Translating.ObjectReference.OnTranslationFailed :: MoveNext")
		Else
			WriteLine(self, "Translating.ObjectReference.OnTranslationFailed :: TranslationFinished")
			SendTranslationEvent(self, sender, Motion.Destination, TranslationFinished)
			ClearState(self)
		EndIf
	EndEvent


	bool Function MoveNext()
		WriteLine(self, "Translating.MoveNext @"+Motion.Index+", to index "+(Motion.Index + 1)+" of length "+Objects.Length)
		Motion.Index += 1
		return Motion.Index < Objects.Length
	EndFunction


	Event OnEndState(string newState)
		UnregisterForAllRemoteEvents()
		Objects = none
		WriteLine(self, "Translating.OnEndState")
	EndEvent


	Function Translate(ObjectReference from, ObjectReference to, float speed = 100.0)
		{EMPTY}
		WriteNotImplemented(self, "Translating.Translate", "The member is not implemented in the '"+StateName+"' state.")
	EndFunction

	Function TranslateEach(ObjectReference[] array, ObjectReference to, float speed = 100.0)
		{EMPTY}
		WriteNotImplemented(self, "Translating.TranslateEach", "The member is not implemented in the '"+StateName+"' state.")
	EndFunction
EndState


Event ObjectReference.OnTranslationComplete(ObjectReference sender)
	{EMPTY}
	WriteNotImplemented(self, "ObjectReference.OnTranslationComplete", "The member is not implemented in the empty state.")
EndEvent

Event ObjectReference.OnTranslationFailed(ObjectReference sender)
	{EMPTY}
	WriteNotImplemented(self, "ObjectReference.OnTranslationFailed", "The member is not implemented in the empty state.")
EndEvent

bool Function MoveNext()
	{EMPTY}
	WriteNotImplemented(self, "MoveNext", "The member is not implemented in the empty state.")
	return false
EndFunction
