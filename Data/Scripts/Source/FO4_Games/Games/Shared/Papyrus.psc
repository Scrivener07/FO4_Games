Scriptname Games:Shared:Papyrus Const Native Hidden
import Games:Shared:Log

; States
;---------------------------------------------

bool Function NewState(ScriptObject this, int stateID) Global
	If (this)
		this.StartTimer(0.1, stateID)
		return true
	Else
		WriteUnexpectedValue("Games:Shared:Papyrus", "NewState", "this", "Cannot request state ID "+stateID+" on a none script.")
		return false
	EndIf
EndFunction


bool Function AwaitState(ScriptObject this, string statename) Global
	{Polling until the given script is in the "empty" state.}
	If (this)
		If (BeginState(this, statename))
			While (StateRunning(this))
				Utility.Wait(0.1)
				; WriteLine(this, "Waiting for '"+statename+"' state.")
			EndWhile
			return true
		Else
			WriteUnexpected(this, "AwaitState", "Could not await the '"+statename+"' state.")
			return false
		EndIf
	Else
		WriteUnexpectedValue("Games:Shared:Papyrus", "AwaitState", "this", "The script cannot be none.")
		return false
	EndIf
EndFunction


bool Function BeginState(ScriptObject this, string statename) Global
	{Begins the given state without waiting for it to end.}
	If (this)
		If (StateRunning(this))
			WriteUnexpected(this, "BeginState", "Cannot start the '"+statename+"' state while '"+this.GetState()+"' state is running.")
			return false
		Else
			If !(StringIsNoneOrEmpty(statename))
				If (ChangeState(this, statename))
					return true
				Else
					WriteUnexpected(this, "BeginState", "Start state cannot change state for the '"+statename+"' state.")
					return false
				EndIf
			Else
				WriteUnexpectedValue(this, "BeginState", "statename", "Cannot operate on a none or empty state.")
				return false
			EndIf
		EndIf
	Else
		WriteUnexpectedValue("Games:Shared:Papyrus", "BeginState", "this", "The script cannot be none.")
		return false
	EndIf
EndFunction


bool Function StateRunning(ScriptObject this) Global
	{Return true if the given script has any state other than the default empty state.}
	If (this)
		return this.GetState() != ""
	Else
		WriteUnexpectedValue("Games:Shared:Papyrus", "StateRunning", "this", "The script cannot be none.")
		return false
	EndIf
EndFunction


bool Function ClearState(ScriptObject this) Global
	{Ends any running state on the given script.}
	If (this)
		If (ChangeState(this, ""))
			return true
		Else
			WriteUnexpected(this, "ClearState", "Unable to change the scripts state to empty.")
			return false
		EndIf
	Else
		WriteUnexpectedValue("Games:Shared:Papyrus", "ClearState", "this", "The script cannot be none.")
		return false
	EndIf
EndFunction


bool Function ChangeState(ScriptObject this, string statename) Global
	{Changes the given scripts state only to a different state.}
	If (this)
		If(this.GetState() != statename)
			this.GoToState(statename)
			return true
		Else
			WriteUnexpectedValue(this, "ChangeState", "statename", "The script is already in the '"+statename+"' state.")
			return false
		EndIf
	Else
		WriteUnexpectedValue("Games:Shared:Papyrus", "ChangeState", "this", "The script cannot be none.")
		return false
	EndIf
EndFunction


; String
;---------------------------------------------

bool Function StringIsNoneOrEmpty(string value) Global
	{Indicates whether the specified string is none or an empty string.}
	return !(value) || value == ""
EndFunction


; Debug
;---------------------------------------------

bool Function IsDebug() Global DebugOnly
	{Returns true if papyrus is in debug mode.}
	return true
EndFunction
