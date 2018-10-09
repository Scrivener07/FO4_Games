ScriptName Games:Blackjack:Type extends Games:Type Native Hidden
{The shared class among blackjack types.}
import Games
import Games:Shared:Log
import Games:Shared:Papyrus

; Events
;---------------------------------------------

Struct PhaseEventArgs
	; A data structure for a strongly typed event argument.
	string Name = ""
	bool Change = true
EndStruct

; @Abstract
Event OnGamePhase(PhaseEventArgs e) Native
Event Games:Blackjack:Main.PhaseEvent(Blackjack:Main sender, var[] arguments)
	{Handles this event delegate for the custom event.}
	PhaseEventArgs e = GetPhaseEventArgs(arguments)
	If (e)
		self.OnGamePhase(e)
	Else
		WriteUnexpectedValue(ToString(), "Games:Blackjack:Main.PhaseEvent", "e", "Cannot handle empty or none event arguments.")
	EndIf
EndEvent


bool Function SendPhase(Blackjack:Main sender, string name, bool change)
	{Sends the custom event with the given arguments.}
	If (sender.StateName == name)
		PhaseEventArgs phase = new PhaseEventArgs
		phase.Name = name
		phase.Change = change
		var[] arguments = new var[1]
		arguments[0] = phase
		sender.SendCustomEvent("PhaseEvent", arguments)
		return true
	Else
		WriteUnexpectedValue(sender.ToString(), "SendPhase", "name", "Cannot not send the phase '"+name+"' while in the '"+sender.StateName+"' state.")
		return false
	EndIf
EndFunction


PhaseEventArgs Function GetPhaseEventArgs(var[] arguments)
	{Converts generic event arguments into a strongly typed event argument.}
	If (arguments)
		return arguments[0] as PhaseEventArgs
	Else
		return none
	EndIf
EndFunction


; Properties
;---------------------------------------------

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
