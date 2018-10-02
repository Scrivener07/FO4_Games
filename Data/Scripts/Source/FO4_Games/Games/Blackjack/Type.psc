ScriptName Games:Blackjack:Type extends Games:Type Native Hidden
{The shared class among blackjack types.}
import Games
import Games:Shared:Log
import Games:Shared:Papyrus

; States
;---------------------------------------------

State Starting
	Event OnBeginState(string asOldState)
		RunOnce()
	EndEvent
	Event OnState()
		{Allocate data for new game session.}
		WriteNotImplemented(self, "Starting.OnState", "The member must be implemented on and extending script.")
	EndEvent
EndState

State Wagering
	Event OnBeginState(string asOldState)
		RunOnce()
	EndEvent
	Event OnState()
		{Wagering}
		WriteNotImplemented(self, "Wagering.OnState", "The member must be implemented on and extending script.")
	EndEvent
EndState

State Dealing
	Event OnBeginState(string asOldState)
		RunOnce()
	EndEvent
	Event OnState()
		{Dealing}
		WriteNotImplemented(self, "Dealing.OnState", "The member must be implemented on and extending script.")
	EndEvent
EndState

State Playing
	Event OnBeginState(string asOldState)
		RunOnce()
	EndEvent
	Event OnState()
		{Playing}
		WriteNotImplemented(self, "Playing.OnState", "The member must be implemented on and extending script.")
	EndEvent
EndState

State Scoring
	Event OnBeginState(string asOldState)
		RunOnce()
	EndEvent
	Event OnState()
		{Scoring}
		WriteNotImplemented(self, "Scoring.OnState", "The member must be implemented on and extending script.")
	EndEvent
EndState

State Exiting
	Event OnBeginState(string asOldState)
		RunOnce()
	EndEvent
	Event OnState()
		{Exiting}
		WriteNotImplemented(self, "Exiting.OnState", "The member must be implemented on and extending script.")
	EndEvent
EndState


; Events
;---------------------------------------------

Struct PhaseEventArgs
	string Name
	bool Change = true
EndStruct


bool Function SendPhase(Blackjack:Main sender, string name, bool change)
	If (sender.StateName == name)
		PhaseEventArgs phase = new PhaseEventArgs
		phase.Name = name
		phase.Change = change
		var[] arguments = new var[1]
		arguments[0] = phase
		sender.SendCustomEvent("PhaseEvent", arguments)
		return true
	Else
		WriteUnexpectedValue(sender, "SendPhase", "name", "Cannot not send the phase '"+name+"' while in the '"+sender.StateName+"' state.")
		return false
	EndIf
EndFunction


PhaseEventArgs Function GetPhaseEventArgs(var[] arguments)
	If (arguments)
		return arguments[0] as PhaseEventArgs
	Else
		return none
	EndIf
EndFunction


Event OnGamePhase(PhaseEventArgs e) Native
Event Games:Blackjack:Main.PhaseEvent(Blackjack:Main sender, var[] arguments)
	PhaseEventArgs e = GetPhaseEventArgs(arguments)
	If (e)
		self.OnGamePhase(e)
	Else
		WriteUnexpectedValue(self, "Games:Blackjack:Main.PhaseEvent", "e", "Cannot handle empty or none phase event arguments.")
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Properties
	bool Property Completed = true AutoReadOnly
	bool Property Incomplete = false AutoReadOnly
EndGroup

Group States
	string Property StartingState = "Starting" AutoReadOnly
	string Property WageringState = "Wagering" AutoReadOnly
	string Property DealingState = "Dealing" AutoReadOnly
	string Property PlayingState = "Playing" AutoReadOnly
	string Property ScoringState = "Scoring" AutoReadOnly
	string Property ExitingState = "Exiting" AutoReadOnly
EndGroup

Group PhaseChanges
	bool Property Begun = true AutoReadOnly
	bool Property Ended = false AutoReadOnly
EndGroup
