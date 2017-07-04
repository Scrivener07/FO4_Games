Scriptname Games:Shared:Controller extends Form Native Hidden
import Games:Shared:Common


; Controller
;---------------------------------------------

State Busy
	Event OnBeginState(string asOldState)
		WriteLine(self,  "The Busy state is not implemented, ending now!")
		self.WaitEnd()
	EndEvent
EndState


Function WaitFor(string aStateName)
	ChangeState(self, aStateName)
	While (IsBusy)
		Utility.Wait(0.1)
	EndWhile
EndFunction


Function WaitEnd()
	ChangeState(self, EmptyState)
EndFunction


; Properties
;---------------------------------------------

Group Controller
	string Property EmptyState = "" AutoReadOnly
	string Property BusyState = "Busy" AutoReadOnly

	bool Property IsBusy Hidden
		bool Function Get()
			return GetState() != EmptyState
		EndFunction
	EndProperty
EndGroup
