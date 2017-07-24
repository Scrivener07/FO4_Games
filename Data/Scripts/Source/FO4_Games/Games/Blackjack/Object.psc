ScriptName Games:Blackjack:Object extends Games:Shared:Task Native Hidden
import Games
import Games:Shared:Common


; Tasks
;---------------------------------------------

State Starting
	Event OnBeginState(string asOldState)
		Starting()
		AwaitEnd()
	EndEvent
EndState
Event Starting() Native


State Wagering
	Event OnBeginState(string asOldState)
		Wagering()
		AwaitEnd()
	EndEvent
EndState
Event Wagering() Native


State Dealing
	Event OnBeginState(string asOldState)
		Dealing()
		AwaitEnd()
	EndEvent
EndState
Event Dealing() Native


State Playing
	Event OnBeginState(string asOldState)
		Playing()
		AwaitEnd()
	EndEvent
EndState
Event Playing() Native


State Scoring
	Event OnBeginState(string asOldState)
		Scoring()
		AwaitEnd()
	EndEvent
EndState
Event Scoring() Native


State Exiting
	Event OnBeginState(string asOldState)
		Exiting()
		AwaitEnd()
	EndEvent
EndState
Event Exiting() Native


; Phase Event
;---------------------------------------------

Struct PhaseEventArgs
	string Name
	bool Change = true
EndStruct


Group StateNames
	string Property IdlePhase = "" AutoReadOnly
	string Property StartingPhase = "Starting" AutoReadOnly
	string Property WageringPhase = "Wagering" AutoReadOnly
	string Property DealingPhase = "Dealing" AutoReadOnly
	string Property PlayingPhase = "Playing" AutoReadOnly
	string Property ScoringPhase = "Scoring" AutoReadOnly
	string Property ExitingPhase = "Exiting" AutoReadOnly
EndGroup


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
EndGroup

Group Game
	bool Property Idling Hidden
		bool Function Get()
			return StateName == IdlePhase
		EndFunction
	EndProperty
EndGroup
