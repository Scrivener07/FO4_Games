ScriptName Gambling:BlackJack:Component extends Gambling:BlackJack:Object Native Const Hidden
import Gambling
import Gambling:Shared:Common
;import Gambling:Shared:Deck


; Virtual ------------------------------------
;---------------------------------------------

Event OnAllocate()
	{When a game session begins.}
EndEvent


Event OnWager()
	{Virtual}
EndEvent


Event OnDeal()
	{Virtual}
EndEvent


Event OnPlay()
	{Virtual}
EndEvent


Event OnScore()
	{Virtual}
EndEvent


Event OnDeallocate()
	{When a game session ends.}
EndEvent


; Phase --------------------------------------
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
