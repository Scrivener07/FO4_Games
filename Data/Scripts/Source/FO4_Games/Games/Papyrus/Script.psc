Scriptname Games:Papyrus:Script Const Native Hidden
import Games:Papyrus:Log
import Games:Papyrus:StringType

; States
;---------------------------------------------

bool Function ChangeState(ScriptObject this, string newState) Global
	{Changes the given scripts state only to a different state.}
	If (this)
		If(this.GetState() != newState)
			this.GoToState(newState)
			return true
		Else
			InvalidOperationException(this, "ChangeState", "The script is already in the '"+newState+"' state.")
			return false
		EndIf
	Else
		ArgumentNoneException("Games:Papyrus:Script", "ChangeState", "this")
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

bool Function TaskAwait(ScriptObject this, string task = "Busy") Global
	{Waits for the configured task to complete.}
	If (this)
		If (TaskRun(this, task))
			While (TaskRunning(this))
				Utility.Wait(0.1)
			EndWhile
			WriteLine(this, "Task await has completed awaiting the '"+task+"' task.")
			return true
		Else
			InvalidOperationException(this, "TaskAwait", "Task could not await the '"+task+"' task.")
			return false
		EndIf
	Else
		ArgumentNoneException("Games:Papyrus:Script", "TaskAwait", "this")
		return false
	EndIf
EndFunction


bool Function TaskRun(ScriptObject this, string task = "Busy") Global
	{Runs the configured task without waiting for completion.}
	If (this)
		If (TaskRunning(this))
			InvalidOperationException(this, "TaskRun", "Cannot run the '"+task+"' task while '"+this.GetState()+"' task is running.")
			return false
		Else
			If !(StringIsNoneOrEmpty(task))
				If (ChangeState(this, task))
					WriteLine(this, "Run task has begun the '"+task+"' task.")
					return true
				Else
					InvalidOperationException(this, "TaskRun", "Run task cannot change state for the '"+task+"' task.")
					return false
				EndIf
			Else
				ArgumentException(this, "TaskRun", "task", "Cannot operate on a none or empty task.")
				return false
			EndIf
		EndIf
	Else
		ArgumentNoneException("Games:Papyrus:Script", "TaskRun", "this")
		return false
	EndIf
EndFunction


bool Function TaskEnd(ScriptObject this) Global
	{Ends any running task on the given script.}
	If (this)
		If (ChangeState(this, EmptyState()))
			WriteLine(this, "End task has completed.")
			return true
		Else
			InvalidOperationException(this, "TaskEnd", "Unable to change the scripts state to empty.")
			return false
		EndIf
	Else
		ArgumentNoneException("Games:Papyrus:Script", "TaskEnd", "this")
		return false
	EndIf
EndFunction


bool Function TaskRunning(ScriptObject this) Global
	{Return true if the given script has any state other than the default empty state.}
	; TODO: Pretty much a duplicate of HasState(ScriptObject)
	If (this)
		return HasState(this)
	Else
		ArgumentNoneException("Games:Papyrus:Script", "TaskRunning", "this")
		return false
	EndIf
EndFunction


string Function TaskDefault() Global
	{The default task is the busy state.}
	return "Busy"
EndFunction
