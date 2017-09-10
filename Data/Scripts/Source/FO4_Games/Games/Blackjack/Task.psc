ScriptName Games:Blackjack:Task extends Quest Native Hidden
import Games
import Games:Papyrus:Log
import Games:Papyrus:Script


; Tasks
;---------------------------------------------

Group Tasks
	string Property IdlePhase = "" AutoReadOnly
	string Property StartingPhase = "Starting" AutoReadOnly
	string Property WageringPhase = "Wagering" AutoReadOnly
	string Property DealingPhase = "Dealing" AutoReadOnly
	string Property PlayingPhase = "Playing" AutoReadOnly
	string Property ScoringPhase = "Scoring" AutoReadOnly
	string Property ExitingPhase = "Exiting" AutoReadOnly
EndGroup


State Starting
	Event OnBeginState(string asOldState)
		Starting()
		TaskEnd(self)
	EndEvent
EndState
Event Starting() Native


State Wagering
	Event OnBeginState(string asOldState)
		Wagering()
		TaskEnd(self)
	EndEvent
EndState
Event Wagering() Native


State Dealing
	Event OnBeginState(string asOldState)
		Dealing()
		TaskEnd(self)
	EndEvent
EndState
Event Dealing() Native


State Playing
	Event OnBeginState(string asOldState)
		Playing()
		TaskEnd(self)
	EndEvent
EndState
Event Playing() Native


State Scoring
	Event OnBeginState(string asOldState)
		Scoring()
		TaskEnd(self)
	EndEvent
EndState
Event Scoring() Native


State Exiting
	Event OnBeginState(string asOldState)
		Exiting()
		TaskEnd(self)
	EndEvent
EndState
Event Exiting() Native


; Phase Event
;---------------------------------------------

Struct PhaseEventArgs
	string Name
	bool Change = true
EndStruct


Group PhaseChanges
	bool Property Begun = true AutoReadOnly
	bool Property Ended = false AutoReadOnly
EndGroup


Event OnGamePhase(PhaseEventArgs e) Native
Event Games:Blackjack:Game.PhaseEvent(Blackjack:Game sender, var[] arguments)
	PhaseEventArgs e = GetPhaseEventArgs(arguments)
	If (e)
		self.OnGamePhase(e)
	Else
		WriteLine(self, "Invalid phase event arguments.")
	EndIf
EndEvent


PhaseEventArgs Function GetPhaseEventArgs(var[] arguments)
	If (arguments)
		return arguments[0] as PhaseEventArgs
	Else
		return none
	EndIf
EndFunction


Function RegisterForPhaseEvent(Blackjack:Game sender)
	self.RegisterForCustomEvent(sender, "PhaseEvent")
EndFunction


Function UnregisterForPhaseEvent(Blackjack:Game sender)
	self.UnregisterForCustomEvent(sender, "PhaseEvent")
EndFunction


; Properties
;---------------------------------------------

Group Properties
	int Property Invalid = -1 AutoReadOnly
	bool Property Completed = true AutoReadOnly
	bool Property Incomplete = false AutoReadOnly
EndGroup

Group Game
	string Property EmptyState = "" AutoReadOnly
	string Property BusyState = "Busy" AutoReadOnly

	string Property StateName Hidden
		string Function Get()
			return GetState()
		EndFunction
	EndProperty

	bool Property Idling Hidden
		bool Function Get()
			return GetState() == IdlePhase
		EndFunction
	EndProperty

	bool Property IsBusy Hidden
		bool Function Get()
			return TaskRunning(self)
		EndFunction
	EndProperty
EndGroup
