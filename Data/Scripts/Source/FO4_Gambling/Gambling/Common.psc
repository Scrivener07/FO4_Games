ScriptName Gambling:Common Hidden


; Logging
;---------------------------------------------

bool Function WriteLine(string prefix, string text) Global DebugOnly
	string filename = "Gambling" const
	text = prefix + " " + text
	If(Debug.TraceUser(filename, text))
		return true
	Else
		Debug.OpenUserLog(filename)
		return Debug.TraceUser(filename, text)
	EndIf
EndFunction


bool Function WriteNotification(string prefix, string text) Global DebugOnly
	Debug.Notification(text)
	return WriteLine(prefix, text)
EndFunction


bool Function WriteMessage(string prefix, string text) Global DebugOnly
	Debug.MessageBox(text)
	return WriteLine(prefix, text)
EndFunction


; Scripts
;---------------------------------------------

bool Function ChangeState(ScriptObject script, string newState) Global
	string stateName = script.GetState()

	If(stateName != newState)
		script.GoToState(newState)
		return true
	Else
		return false
	EndIf
EndFunction


bool Function HasState(ScriptObject script) Global
	return script.GetState() != ""
EndFunction
