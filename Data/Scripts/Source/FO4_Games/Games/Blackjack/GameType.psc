ScriptName Games:Blackjack:GameType extends Quest Native Hidden
import Games
import Games:Papyrus:Log
import Games:Papyrus:Script


; FSM - Finite State Machine
;---------------------------------------------

State Starting
	Event OnBeginState(string asOldState)
		Starting()
		TaskEnd(self)
	EndEvent
EndState

State Wagering
	Event OnBeginState(string asOldState)
		Wagering()
		TaskEnd(self)
	EndEvent
EndState

State Dealing
	Event OnBeginState(string asOldState)
		Dealing()
		TaskEnd(self)
	EndEvent
EndState

State Playing
	Event OnBeginState(string asOldState)
		Playing()
		TaskEnd(self)
	EndEvent
EndState

State Scoring
	Event OnBeginState(string asOldState)
		Scoring()
		TaskEnd(self)
	EndEvent
EndState

State Exiting
	Event OnBeginState(string asOldState)
		Exiting()
		TaskEnd(self)
	EndEvent
EndState


; Abstract
;---------------------------------------------

Event Starting() Native
Event Wagering() Native
Event Dealing() Native
Event Playing() Native
Event Scoring() Native
Event Exiting() Native


; Events
;---------------------------------------------

Struct PhaseEventArgs
	string Name
	bool Change = true
EndStruct


bool Function SendPhase(Blackjack:Game sender, string name, bool change)
	If (sender.StateName == name)
		PhaseEventArgs phase = new PhaseEventArgs
		phase.Name = name
		phase.Change = change
		var[] arguments = new var[1]
		arguments[0] = phase
		sender.SendCustomEvent("PhaseEvent", arguments)
		return true
	Else
		WriteLine(sender, "Cannot not send the phase '"+name+"' while in the '"+sender.StateName+"' state.")
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
Event Games:Blackjack:Game.PhaseEvent(Blackjack:Game sender, var[] arguments)
	PhaseEventArgs e = GetPhaseEventArgs(arguments)
	If (e)
		self.OnGamePhase(e)
	Else
		WriteLine(self, "Invalid phase event arguments.")
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Properties
	int Property Invalid = -1 AutoReadOnly
	bool Property Completed = true AutoReadOnly
	bool Property Incomplete = false AutoReadOnly
EndGroup

Group Tasks
	string Property NoTask = "" AutoReadOnly
	string Property StartingTask = "Starting" AutoReadOnly
	string Property WageringTask = "Wagering" AutoReadOnly
	string Property DealingTask = "Dealing" AutoReadOnly
	string Property PlayingTask = "Playing" AutoReadOnly
	string Property ScoringTask = "Scoring" AutoReadOnly
	string Property ExitingTask = "Exiting" AutoReadOnly

	string Property EmptyState = "" AutoReadOnly
	string Property BusyState = "Busy" AutoReadOnly

	string Property StateName Hidden
		string Function Get()
			return GetState()
		EndFunction
	EndProperty

	bool Property Idling Hidden
		bool Function Get()
			return GetState() == NoTask
		EndFunction
	EndProperty

	bool Property IsBusy Hidden
		bool Function Get()
			return TaskRunning(self)
		EndFunction
	EndProperty
EndGroup

Group PhaseChanges
	bool Property Begun = true AutoReadOnly
	bool Property Ended = false AutoReadOnly
EndGroup
