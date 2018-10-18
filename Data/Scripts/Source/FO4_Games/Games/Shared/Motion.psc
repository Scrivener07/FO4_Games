ScriptName Games:Shared:Motion extends Games:Type Default
import Games
import Games:Shared:Log
import Games:Shared:Papyrus

MotionData Motion
ObjectReference[] References
CustomEvent TranslationEvent

; Constants
string TranslatingState = "Translating" const
int Motion_Keyframed = 2 const

Struct MotionData
	int Index = 0
	ObjectReference Destination
	float Speed = 100.0
EndStruct


; Methods
;---------------------------------------------

Function Translate(ObjectReference from, ObjectReference to, float speed = 100.0)
	ObjectReference[] values = new ObjectReference[1]
	values[0] = from
	TranslateEach(values, to, speed)
EndFunction


Function TranslateEach(ObjectReference[] values, ObjectReference to, float speed = 100.0)
	References = values
	Motion = new MotionData
	Motion.Destination = to
	Motion.Speed = speed
	AwaitState(self, TranslatingState)
EndFunction


string Function ToString()
	{The string representation of this script.}
	return parent.ToString()+"[Count:"+References.Length+"][Motion:"+Motion+"]"
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
		WriteLine(ToString(), "SendTranslationEvent :: EventArg:"+e+", Motion:"+Motion)
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
		WriteUnexpectedValue(ToString(), "RegisterForTranslationEvent", "script", "Cannot register a none script for an event.")
		return false
	EndIf
EndFunction


bool Function UnregisterForTranslationEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "TranslationEvent")
		return true
	Else
		WriteUnexpectedValue(ToString(), "UnregisterForTranslationEvent", "script", "Cannot unregister a none script for an event.")
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
		If (References)
			int index = 0
			While (index < References.Length)
				ObjectReference reference = References[index]
				reference.SetMotionType(Motion_Keyframed)
				RegisterForRemoteEvent(reference, "OnTranslationComplete")
				RegisterForRemoteEvent(reference, "OnTranslationFailed")
				reference.TranslateToRef(Motion.Destination, Motion.Speed)
				SendTranslationEvent(self, reference, Motion.Destination, TranslationStarted)
				index += 1
			EndWhile
		Else
			WriteUnexpectedValue(ToString(), "Translating.OnBeginState", "References", "Cannot translate empty or none reference values.")
			ClearState(self)
		EndIf
	EndEvent


	Event ObjectReference.OnTranslationComplete(ObjectReference sender)
		SendTranslationEvent(self, sender, Motion.Destination, TranslationCompleted)
		If (MoveNext() == false)
			SendTranslationEvent(self, sender, Motion.Destination, TranslationFinished)
			ClearState(self)
		EndIf
	EndEvent


	Event ObjectReference.OnTranslationFailed(ObjectReference sender)
		WriteUnexpectedValue(ToString(), "Translating.ObjectReference.OnTranslationFailed", "sender", "Failed for reference '"+sender+"' at index "+Motion.Index)
		SendTranslationEvent(self, sender, Motion.Destination, TranslationFailed)
		If (MoveNext() == false)
			SendTranslationEvent(self, sender, Motion.Destination, TranslationFinished)
			ClearState(self)
		EndIf
	EndEvent


	bool Function MoveNext()
		Motion.Index += 1
		return Motion.Index < References.Length
	EndFunction


	Event OnEndState(string newState)
		UnregisterForAllRemoteEvents()
		References = none
	EndEvent


	Function Translate(ObjectReference from, ObjectReference to, float speed = 100.0)
		{EMPTY}
		WriteNotImplemented(ToString(), "Translating.Translate", "The member is not implemented in the '"+StateName+"' state.")
	EndFunction

	Function TranslateEach(ObjectReference[] values, ObjectReference to, float speed = 100.0)
		{EMPTY}
		WriteNotImplemented(ToString(), "Translating.TranslateEach", "The member is not implemented in the '"+StateName+"' state.")
	EndFunction
EndState


Event ObjectReference.OnTranslationComplete(ObjectReference sender)
	{EMPTY}
	WriteNotImplemented(ToString(), "ObjectReference.OnTranslationComplete", "The member is not implemented in the empty state.")
EndEvent

Event ObjectReference.OnTranslationFailed(ObjectReference sender)
	{EMPTY}
	WriteNotImplemented(ToString(), "ObjectReference.OnTranslationFailed", "The member is not implemented in the empty state.")
EndEvent

bool Function MoveNext()
	{EMPTY}
	WriteNotImplemented(ToString(), "MoveNext", "The member is not implemented in the empty state.")
	return false
EndFunction
