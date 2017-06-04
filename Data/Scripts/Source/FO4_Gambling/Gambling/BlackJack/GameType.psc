ScriptName Gambling:BlackJack:GameType extends Quest Native Const Hidden
import Gambling
import Gambling:BlackJack:Game
import Gambling:Common


; Events
;---------------------------------------------

Event OnInitialize()
	{Virtual}
EndEvent


; Phase Events
;---------------------------------------------

Struct PhaseEventArgs
	string Name
	bool Change = true
EndStruct

Group PhaseNames
	string Property ReadyPhase = "" AutoReadOnly
	string Property StartingPhase = "Starting" AutoReadOnly
	string Property WageringPhase = "Wagering" AutoReadOnly
	string Property DealingPhase = "Dealing" AutoReadOnly
	string Property PlayingPhase = "Playing" AutoReadOnly
	string Property ScoringPhase = "Scoring" AutoReadOnly
EndGroup

Group PhaseChanges
	bool Property Begun = true AutoReadOnly
	bool Property Ended = false AutoReadOnly
EndGroup


Function SendPhase(BlackJack:Game sender, string name, bool change) Global
	string stateName = sender.GetState()
	If (stateName == name)
		PhaseEventArgs phase = new PhaseEventArgs
		phase.Name = name
		phase.Change = change

		var[] arguments = new var[1]
		arguments[0] = phase

		WriteLine(sender, "Sending phase event:" + phase)
		sender.SendCustomEvent("PhaseEvent", arguments)
	Else
		WriteLine(sender, "Cannot not send the phase '"+name+"' while in the '"+stateName+"' state.")
	EndIf
EndFunction


PhaseEventArgs Function GetPhaseEventArgs(var[] arguments) Global
	If (arguments)
		return arguments[0] as PhaseEventArgs
	Else
		return none
	EndIf
EndFunction


Event OnGamePhase(PhaseEventArgs e)
	{Virtual}
EndEvent
