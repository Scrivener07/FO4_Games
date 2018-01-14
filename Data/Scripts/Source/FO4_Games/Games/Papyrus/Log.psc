ScriptName Games:Papyrus:Log Const Native Hidden DebugOnly
import Games:Papyrus:StringType


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


bool Function WriteErrorNotImplemented(ScriptObject script, string member, string text = "") Global DebugOnly
	return WriteMessage(script, "Error", "The function or event '"+member+"' was not implemented. "+text)
EndFunction
