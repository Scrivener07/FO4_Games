ScriptName Gambling:BlackJack:GameType extends Quest Native Const Hidden
import Gambling
import Gambling:BlackJack:Game
import Gambling:Common


; Events
;---------------------------------------------

Event OnInitialize()
	{Virtual}
EndEvent


; Game Event
;---------------------------------------------

Struct PhaseEventArgs
	string Name
	bool Change = true
EndStruct


Event OnGameEvent(BlackJack:Game akSender, PhaseEventArgs e)
	{Virtual}
EndEvent


Function SendPhase(BlackJack:Game akSender, string aName, bool aChange) Global
	string sState = akSender.GetState()
	If (sState == aName)
		PhaseEventArgs phase = new PhaseEventArgs
		phase.Name = aName
		phase.Change = aChange

		var[] arguments = new var[1]
		arguments[0] = phase

		WriteLine(akSender, "Sending phase event:" + phase)
		akSender.SendCustomEvent("OnPhase", arguments)
	Else
		WriteLine(akSender, "Cannot not send the phase '"+aName+"' while in the '"+sState+"' state.")
	EndIf
EndFunction


PhaseEventArgs Function GetPhaseEventArgs(var[] arguments) Global
	If (arguments)
		return arguments[0] as PhaseEventArgs
	Else
		return none
	EndIf
EndFunction
