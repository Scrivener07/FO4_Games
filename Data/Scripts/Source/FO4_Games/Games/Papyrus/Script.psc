Scriptname Games:Papyrus:Script Const Native Hidden
import Games:Papyrus:Log
import Games:Papyrus:StringType

; States
;---------------------------------------------

bool Function ChangeState(ScriptObject script, string newState) Global
	{Changes the given scripts state only to a different state.}
	If(script.GetState() != newState)
		script.GoToState(newState)
		return true
	Else
		WriteLine(script, "The script is already in the '"+newState+"' state.")
		return false
	EndIf
EndFunction


bool Function HasState(ScriptObject script) Global
	{Return true if the given script has any state other than the default empty state.}
	return script.GetState() != EmptyState()
EndFunction


string Function EmptyState() Global
	{The default papyrus script state is the empty state.}
	return ""
EndFunction


; Tasks
;---------------------------------------------
; Tasks are simply regular script states. These states can be run, awaited, or ended.

bool Function TaskAwait(ScriptObject script, string task = "Busy") Global
	{Waits for the configured task to complete.}
	If (script)
		If (TaskRun(script, task))
			While (TaskRunning(script))
				Utility.Wait(0.1)
			EndWhile
			return true
		Else
			WriteLine(script, "Task could not await the '"+task+"' task.")
			return false
		EndIf
	Else
		WriteLine(script, "Task cannot operate on a none script.")
		return false
	EndIf
EndFunction


bool Function TaskRun(ScriptObject script, string task = "Busy") Global
	{Runs the configured task without waiting for completion.}
	If (script)
		If (TaskRunning(script))
			WriteLine(script, "Cannot run the '"+task+"' task while '"+script.GetState()+"' task is running.")
			return false
		Else
			If !(StringIsNoneOrEmpty(task))
				If (ChangeState(script, task))
					return true
				Else
					WriteLine(script, "Task run cannot change state for the '"+task+"' task.")
					return false
				EndIf
			Else
				WriteLine(script, "Task run cannot operateon a none or empty state.")
				return false
			EndIf
		EndIf
	Else
		WriteLine(script, "Task run cannot operate on a none script.")
		return false
	EndIf
EndFunction


bool Function TaskEnd(ScriptObject script) Global
	{Ends any running task on the given script.}
	If (script)
		If (ChangeState(script, EmptyState()))
			return true
		Else
			WriteLine(script, "Task is unable to end right now.")
			return false
		EndIf
	Else
		WriteLine(script, "Task end cannot operate on a none script.")
		return false
	EndIf
EndFunction


bool Function TaskRunning(ScriptObject script) Global
	{Return true if the given script has any state other than the default empty state.}
	; TODO: Pretty much a duplicate of HasState(ScriptObject)
	If (script)
		return HasState(script)
	Else
		WriteLine(script, "Task running cannot operate on a none script.")
		return false
	EndIf
EndFunction


string Function TaskDefault() Global
	{The default task is the busy state.}
	return "Busy"
EndFunction
