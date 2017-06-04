ScriptName Gambling:BlackJack:Players:Player extends Gambling:BlackJack:Players:PlayerType Hidden
import Gambling
import Gambling:BlackJack:GameType
import Gambling:Common
import Gambling:Shared


; Events
;---------------------------------------------

Event OnInit()
	RegisterForCustomEvent(BlackJack, "PhaseEvent")
	self.OnInitialize()
EndEvent


Event Gambling:BlackJack:Game.PhaseEvent(BlackJack:Game sender, var[] arguments)
	PhaseEventArgs e = GetPhaseEventArgs(arguments)
	If (e)
		If (e.Name == sender.ScoringPhase && e.Change == sender.Ended)
			If (Hand)
				sender.Cards.Collect(self)
			Else
				WriteLine(self, "Player '"+ID+"' has no hand to cleanup.")
			EndIf
		EndIf
	Else
		WriteLine(self, "Player '"+ID+"' has invalid phase event arguments.")
	EndIf
EndEvent


; Methods
;---------------------------------------------

Function Startup()
	self.OnStartup()
	WriteLine(self, "Player '"+ID+"' has started up.")
EndFunction


Function Wager()
	self.OnWager()
	WriteLine(self, "Player '"+ID+"' has wagered '"+Wager+"'.")
EndFunction


Function Deal(Deck:Card card)
	Hand.Add(card)
	Score = BlackJack.GetScore(Hand, Score)
	int index = Hand.Length - 1
	self.OnDeal(card, index)
	WriteLine(self, "Player '"+ID+"' has been dealt the '"+card+"' card for '"+Score+"' score.")
EndFunction


Function Play()
	self.OnPlay()
	WriteLine(self, "Player '"+ID+"' has played their turn.")
EndFunction


Function Shutdown()
	UnregisterForCustomEvent(BlackJack, "PhaseEvent")
	self.OnShutdown()
	WriteLine(self, "Player '"+ID+"' has shutdown.")
EndFunction


; Properties
;---------------------------------------------

Group Components
	BlackJack:Game Property BlackJack Auto Const Mandatory
	Shared:Motion:Controller Property Controller Auto Const Mandatory
EndGroup

Group Properties
	ObjectReference Property Gambling_BlackJack_DeckMarker Auto Const Mandatory
EndGroup


Group Data
	int Property ID = -1 Auto Hidden
	int Property Score Auto Hidden
	int Property Wager Auto Hidden
	int Property Winnings Auto Hidden
	bool Property Abort = false Auto Hidden
	Deck:Card[] Property Hand Auto Hidden
EndGroup


Group ReadOnly
	int Property Turn Hidden
		int Function Get()
			return Hand.Length - 1
		EndFunction
	EndProperty
EndGroup

Group Options
	int Property OptionHit = 0 AutoReadOnly
	int Property OptionStand = 1 AutoReadOnly
EndGroup
