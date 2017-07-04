ScriptName Games:Blackjack:Component extends Games:Blackjack:Object Hidden
import Games:Shared:Common


; Component
;---------------------------------------------

State Starting
	Event OnBeginState(string asOldState)
		WriteLine(self, "No starting has been implemented for state.")
		ReleaseThread()
	EndEvent
EndState

State Wagering
	Event OnBeginState(string asOldState)
		WriteLine(self, "No Wagering has been implemented for state.")
		ReleaseThread()
	EndEvent
EndState

State Dealing
	Event OnBeginState(string asOldState)
		WriteLine(self, "No Dealing has been implemented for state.")
		ReleaseThread()
	EndEvent
EndState

State Playing
	Event OnBeginState(string asOldState)
		WriteLine(self, "No Playing has been implemented for state.")
		ReleaseThread()
	EndEvent
EndState

State Scoring
	Event OnBeginState(string asOldState)
		WriteLine(self, "No Scoring has been implemented for state.")
		ReleaseThread()
	EndEvent
EndState

State Exiting
	Event OnBeginState(string asOldState)
		WriteLine(self, "No Exiting has been implemented for state.")
		ReleaseThread()
	EndEvent
EndState


; Methods
;---------------------------------------------

bool Function CallAndWait(string thread)
	If (IsBusy)
		WriteLine(self, "Cannot start the '"+thread+"'' thread while busy.")
		return Incomplete
	Else
		If (ChangeState(self, thread))
			If (LockThread())
				; WriteLine(self, "The '"+thread+"'' thread has completed.")
				return Completed
			Else
				WriteLine(self, "Unable to lock the '"+thread+"'' thread.")
				return Incomplete
			EndIf
		Else
			WriteLine(self, "Cannot change state for the '"+thread+"'' thread.")
			return Incomplete
		EndIf
	EndIf
EndFunction


bool Function LockThread()
	While (IsBusy)
		Utility.Wait(0.1)
	EndWhile
	return Completed
EndFunction


bool Function ReleaseThread()
	return ChangeState(self, IdlePhase)
EndFunction


; Properties
;---------------------------------------------

Group Properties
	bool Property Completed = true AutoReadOnly
	bool Property Incomplete = false AutoReadOnly
EndGroup
