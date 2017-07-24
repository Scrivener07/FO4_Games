Scriptname Games:Shared:Task extends Quest Native Hidden
{Waits for the configured task to complete.}
import Games:Shared:Common


; Task
;---------------------------------------------

State Busy
	Event OnBeginState(string asOldState)
		WriteLine(self, "Task is now busy, call Complete to end the task.")
	EndEvent
EndState


bool Function Await(string thread = "Busy")
	If (IsBusy)
		WriteLine(self, "Task cannot await the '"+thread+"' thread while busy.")
		return Incomplete
	Else
		If !(StringIsNoneOrEmpty(thread))
			If (ChangeState(self, thread))
				While (IsBusy)
					Utility.Wait(0.1)
				EndWhile
				; WriteLine(self, "Task has completed the '"+thread+"' thread.")
				return Completed
			Else
				WriteLine(self, "Task cannot change state for the '"+thread+"' thread.")
				return Incomplete
			EndIf
		Else
			WriteLine(self, "Task cannot await thread for a none or empty state.")
			return Incomplete
		EndIf
	EndIf
EndFunction


bool Function AwaitEnd()
	If (ChangeState(self, EmptyState))
		return Completed
	Else
		WriteLine(self, "Task is unable to complete right now.")
		return Incomplete
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Task
	bool Property Completed = true AutoReadOnly
	bool Property Incomplete = false AutoReadOnly

	string Property EmptyState = "" AutoReadOnly
	string Property BusyState = "Busy" AutoReadOnly

	string Property StateName Hidden
		string Function Get()
			return GetState()
		EndFunction
	EndProperty

	bool Property IsBusy Hidden
		bool Function Get()
			return StateName != EmptyState
		EndFunction
	EndProperty
EndGroup
