ScriptName Gambling:BlackJack:GameComponent extends Gambling:BlackJack:GameType Hidden
import Gambling
import Gambling:Common


; Events
;---------------------------------------------

Event OnInit()
	RegisterForCustomEvent(BlackJack, "PhaseEvent")
	self.OnInitialize()
EndEvent


Event Gambling:BlackJack:Game.PhaseEvent(BlackJack:Game sender, var[] arguments)
	PhaseEventArgs e = Gambling:BlackJack:GameType.GetPhaseEventArgs(arguments)
	If (e)
		self.OnGamePhase(e)
	Else
		WriteLine(self, "Invalid phase event arguments.")
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Game
	BlackJack:Game Property BlackJack Auto Const Mandatory
EndGroup
