ScriptName Gambling:BlackJack:Component extends Gambling:BlackJack:Object Hidden
import Gambling:Shared:Common


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

bool Function StartAndWait()
	If (IsBusy)
		WriteLine(self, "StartAndWait cannot be called while busy.")
		return Incomplete
	Else
		If (ChangeState(self, StartingPhase))
			If (LockThread())
				return Completed
			Else
				WriteLine(self, "StartAndWait was unable to lock a thread.")
				return Incomplete
			EndIf
		Else
			WriteLine(self, "StartAndWait was unable to start a thread.")
			return Incomplete
		EndIf
	EndIf
EndFunction


bool Function WagerAndWait()
	If (IsBusy)
		WriteLine(self, "WagerAndWait cannot be called while busy.")
		return Incomplete
	Else
		If (ChangeState(self, WageringPhase))
			If (LockThread())
				return Completed
			Else
				WriteLine(self, "WagerAndWait was unable to lock a thread.")
				return Incomplete
			EndIf
		Else
			WriteLine(self, "WagerAndWait was unable to start a thread.")
			return Incomplete
		EndIf
	EndIf
EndFunction


bool Function DealAndWait()
	If (IsBusy)
		WriteLine(self, "DealAndWait cannot be called while busy.")
		return Incomplete
	Else
		If (ChangeState(self, DealingPhase))
			If (LockThread())
				return Completed
			Else
				WriteLine(self, "DealAndWait was unable to lock a thread.")
				return Incomplete
			EndIf
		Else
			WriteLine(self, "DealAndWait was unable to start a thread.")
			return Incomplete
		EndIf
	EndIf
EndFunction


bool Function PlayAndWait()
	If (IsBusy)
		WriteLine(self, "PlayAndWait cannot be called while busy.")
		return Incomplete
	Else
		If (ChangeState(self, PlayingPhase))
			If (LockThread())
				return Completed
			Else
				WriteLine(self, "PlayAndWait was unable to lock a thread.")
				return Incomplete
			EndIf
		Else
			WriteLine(self, "PlayAndWait was unable to start a thread.")
			return Incomplete
		EndIf
	EndIf
EndFunction


bool Function ScoreAndWait()
	If (IsBusy)
		WriteLine(self, "ScoreAndWait cannot be called while busy.")
		return Incomplete
	Else
		If (ChangeState(self, ScoringPhase))
			If (LockThread())
				return Completed
			Else
				WriteLine(self, "ScoreAndWait was unable to lock a thread.")
				return Incomplete
			EndIf
		Else
			WriteLine(self, "ScoreAndWait was unable to start a thread.")
			return Incomplete
		EndIf
	EndIf
EndFunction


bool Function ExitAndWait()
	If (IsBusy)
		WriteLine(self, "ExitAndWait cannot be called while busy.")
		return Incomplete
	Else
		If (ChangeState(self, ExitingPhase))
			If (LockThread())
				return Completed
			Else
				WriteLine(self, "ExitAndWait was unable to lock a thread.")
				return Incomplete
			EndIf
		Else
			WriteLine(self, "ExitAndWait was unable to start a thread.")
			return Incomplete
		EndIf
	EndIf
EndFunction


; Functions
;---------------------------------------------

bool Function LockThread()
	While (IsBusy)
		Utility.Wait(0.1)
	EndWhile
	return Completed
EndFunction


bool Function ReleaseThread()
	return ChangeState(self, IdlePhase)
EndFunction
