Scriptname Games:Shared:Papyrus Const Native Hidden
import Games:Shared:Log

; States and Tasks
;---------------------------------------------
; Tasks are simply regular script states. These states can be run, awaited, or ended.

bool Function TaskAwait(ScriptObject this, string task = "Busy") Global
	{Waits for the configured task to end.}
	If (this)
		If (TaskRun(this, task))

			int loops = 0
			While (TaskRunning(this)) ; Polling until script is in the "empty" state.
				loops += 1
				Utility.Wait(0.1)
				WriteLine(this, "Awaiting the '"+task+"' task. Attempt:"+loops+", Called from stack: " + Utility.GetCurrentStackID())
			EndWhile

			WriteLine(this, "Completed awaiting the '"+task+"' task. Called from stack: " + Utility.GetCurrentStackID())
			return true
		Else
			WriteUnexpected(this, "TaskAwait", "Task could not await the '"+task+"' task.")
			return false
		EndIf
	Else
		WriteUnexpectedValue("Games:Shared:Papyrus", "TaskAwait", "this", "The script cannot be none.")
		return false
	EndIf
EndFunction


bool Function TaskRun(ScriptObject this, string task = "Busy") Global
	{Runs the configured task without waiting for it to end.}
	If (this)
		If (TaskRunning(this))
			WriteUnexpected(this, "TaskRun", "Cannot run the '"+task+"' task while '"+this.GetState()+"' task is running.")
			return false
		Else
			If !(StringIsNoneOrEmpty(task))
				If (ChangeState(this, task))
					WriteLine(this, "Run task has begun the '"+task+"' task. Called from stack: " + Utility.GetCurrentStackID())
					return true
				Else
					WriteUnexpected(this, "TaskRun", "Run task cannot change state for the '"+task+"' task.")
					return false
				EndIf
			Else
				WriteUnexpectedValue(this, "TaskRun", "task", "Cannot operate on a none or empty task.")
				return false
			EndIf
		EndIf
	Else
		WriteUnexpectedValue("Games:Shared:Papyrus", "TaskRun", "this", "The script cannot be none.")
		return false
	EndIf
EndFunction


bool Function TaskRunning(ScriptObject this) Global
	{Return true if the given script has any state other than the default empty state.}
	If (this)
		return this.GetState() != ""
	Else
		WriteUnexpectedValue("Games:Shared:Papyrus", "TaskRunning", "this", "The script cannot be none.")
		return false
	EndIf
EndFunction


bool Function TaskEnd(ScriptObject this) Global
	{Ends any running task on the given script.}
	If (this)
		If (ChangeState(this, "")) ; empty state
			WriteLine(this, "End task has completed. Called from stack: " + Utility.GetCurrentStackID())
			return true
		Else
			WriteUnexpected(this, "TaskEnd", "Unable to change the scripts state to empty.")
			return false
		EndIf
	Else
		WriteUnexpectedValue("Games:Shared:Papyrus", "TaskEnd", "this", "The script cannot be none.")
		return false
	EndIf
EndFunction


bool Function ChangeState(ScriptObject this, string newState) Global
	{Changes the given scripts state only to a different state.}
	If (this)
		If(this.GetState() != newState)
			this.GoToState(newState)
			return true
		Else
			WriteUnexpectedValue(this, "ChangeState", "newState", "The script is already in the '"+newState+"' state.")
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
