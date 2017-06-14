ScriptName Gambling:BlackJack:Object extends Quest Native Const Hidden
import Gambling
import Gambling:Shared:Common


; Phase Event
;---------------------------------------------

Struct PhaseEventArgs
	string Name
	bool Change = true
EndStruct


Group PhaseNames
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


Event OnGamePhase(PhaseEventArgs e)
	{Virtual}
	WriteLine(self, "A phase event has been registered for but not implemented.")
EndEvent


Event Gambling:BlackJack:Game.PhaseEvent(BlackJack:Game sender, var[] arguments)
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


Function RegisterForPhaseEvent(BlackJack:Game sender)
	self.RegisterForCustomEvent(sender, "PhaseEvent")
EndFunction


Function UnregisterForPhaseEvent(BlackJack:Game sender)
	self.UnregisterForCustomEvent(sender, "PhaseEvent")
EndFunction


; Properties
;---------------------------------------------

Group Properties
	int Property Invalid = -1 AutoReadOnly
	bool Property Completed = true AutoReadOnly
	bool Property Incomplete = false AutoReadOnly
	bool Property Success = true AutoReadOnly
	bool Property Failure = false AutoReadOnly
EndGroup

Group Game
	bool Property Idling Hidden
		bool Function Get()
			return self.GetState() == IdlePhase
		EndFunction
	EndProperty

	bool Property IsBusy Hidden
		bool Function Get()
			return GetState() != IdlePhase
		EndFunction
	EndProperty
EndGroup
