ScriptName Games:Papyrus:Log Const Native Hidden DebugOnly
import Games:Papyrus:StringType

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


; Exceptions
;---------------------------------------------
; Writes "exceptional" messages as lines in a log file.

bool Function NotImplementedException(var script, string member, string text = "") Global DebugOnly
	{The exception that is thrown when a requested method or operation is not implemented.}
	; The exception is thrown when a particular method, get accessor, or set accessor is present as a member of a type but is not implemented.
	return WriteLine(script, member+": The member '"+member+"' was not implemented. "+text)
EndFunction


bool Function InvalidOperationException(var script, string member, string text = "") Global DebugOnly
	{The exception that is thrown when a method call is invalid for the object's current state.}
	; The exception is used in cases when the failure to invoke a method is caused by reasons other than invalid arguments.
	return WriteLine(script, member+": The member '"+member+"' had an invalid operation. "+text)
EndFunction


bool Function ArgumentException(var script, string member, string argument, string text = "") Global DebugOnly
	{The exception that is thrown when one of the arguments provided to a method is not valid.}
	; The exception is thrown when a method is invoked and at least one of the passed arguments does not meet the parameter specification of the called method.
	; The 'argument' parameter identifies the invalid argument.
	return WriteLine(script, member+"."+argument+": The member '"+member+"' parameter '"+argument+"' was invalid. "+text)
EndFunction


bool Function ArgumentNoneException(var script, string member, string argument, string text = "") Global DebugOnly
	{The exception that is thrown when a none reference is passed to a method that does not accept it as a valid argument.}
	; The exception is thrown when a method is invoked and at least one of the passed arguments is none but should never be none.
	return WriteLine(script, member+"."+argument+": The member '"+member+"' parameter '"+argument+"' cannot be none. "+text)
EndFunction
