ScriptName Gambling:BlackJack:GameComponent extends Gambling:BlackJack:GameType Hidden
import Gambling
import Gambling:BlackJack:GameType
import Gambling:Common


; Events
;---------------------------------------------

Event OnInit()
	RegisterForCustomEvent(BlackJack, "OnPhase")
	self.OnInitialize()
EndEvent


Event Gambling:BlackJack:Game.OnPhase(BlackJack:Game akSender, var[] arguments)
	PhaseEventArgs e = Gambling:BlackJack:GameType.GetPhaseEventArgs(arguments)
	If (e)
		self.OnGameEvent(akSender, e)
	Else
		WriteLine(self, "Invalid phase event arguments.")
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Properties
	BlackJack:Game Property BlackJack Auto Const Mandatory
EndGroup
