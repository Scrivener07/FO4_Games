ScriptName Games:Shared:Log Const Native Hidden DebugOnly
import Games:Shared:Papyrus

; Logging
;---------------------------------------------
; Writes messages as lines in a log file.

bool Function WriteLine(string prefix, string text) Global DebugOnly
	string filename = "Games" const
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


bool Function WriteMessage(string prefix, string title, string text = "") Global DebugOnly
	string value
	If !(StringIsNoneOrEmpty(text))
		value = title+"\n"+text
	EndIf
	Debug.MessageBox(value)
	return WriteLine(prefix, title+" "+text)
EndFunction


; Debug
;---------------------------------------------
; Writes script messages as lines in a log file.

bool Function WriteUnexpected(var script, string member, string text = "") Global DebugOnly
	return WriteLine(script+"["+member+"]", "The member '"+member+"' had an unexpected operation. "+text)
EndFunction


bool Function WriteUnexpectedValue(var script, string member, string variable, string text = "") Global DebugOnly
	return WriteLine(script+"["+member+"."+variable+"]", "The member '"+member+"' with variable '"+variable+"' had an unexpected operation. "+text)
EndFunction


bool Function WriteNotImplemented(var script, string member, string text = "") Global DebugOnly
	{The exception that is thrown when a requested method or operation is not implemented.}
	; The exception is thrown when a particular method, get accessor, or set accessor is present as a member of a type but is not implemented.
	return WriteLine(script, member+": The member '"+member+"' was not implemented. "+text)
EndFunction

