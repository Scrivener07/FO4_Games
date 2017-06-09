ScriptName Gambling:BlackJack:Component extends Gambling:BlackJack:Object Native Const Hidden
import Gambling
import Gambling:Shared:Common


; Component
;---------------------------------------------

Function GameBegin() Native
Function GameWager() Native
Function GameDeal() Native
Function GamePlay() Native
Function GameScore() Native
Function GameEnd() Native


; Phase Event --------------------------------
;---------------------------------------------

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
