ScriptName Gambling:BlackJack:Competitors:Seat extends Gambling:BlackJack:Competitors:SeatType Hidden
import Gambling
import Gambling:BlackJack:Main
import Gambling:Common
import Gambling:Shared


; Events
;---------------------------------------------

Event Gambling:BlackJack:Main.OnPhase(BlackJack:Main akSender, var[] arguments)
	PhaseEventArgs e = GetPhaseEventArgs(arguments)
	If (e)
		If (e.Name == akSender.ScoringState && e.Change == akSender.Ended)
			If (Hand)
				ObjectReference[] references = Gambling:Shared:Deck.GetReferences(Hand)
				Controller.TranslateEach(references, Gambling_Card)
			Else
				WriteLine(self, "Seat '"+ID+"' has no hand to cleanup.")
			EndIf
		EndIf
	Else
		WriteLine(self, "Seat '"+ID+"' has invalid phase event arguments.")
	EndIf
EndEvent


; Methods
;---------------------------------------------

Function Startup()
	RegisterForCustomEvent(BlackJack, "OnPhase")
	self.OnStartup()
	WriteLine(self, "Seat '"+ID+"' has started up.")
EndFunction


Function Wager()
	self.OnWager()
	WriteLine(self, "Seat '"+ID+"' has wagered '"+Wager+"'.")
EndFunction


Function Deal(Deck:Card card)
	Hand.Add(card)
	Score = BlackJack.GetScore(Hand, Score)
	int index = Hand.Length - 1
	self.OnDeal(card, index)
	WriteLine(self, "Seat '"+ID+"' has been dealt the '"+card+"' card for '"+Score+"' score.")
EndFunction


Function Play()
	self.OnPlay()
	WriteLine(self, "Seat '"+ID+"' has played their turn.")
EndFunction


Function Shutdown()
	UnregisterForCustomEvent(BlackJack, "OnPhase")
	self.OnShutdown()
	WriteLine(self, "Seat '"+ID+"' has shutdown.")
EndFunction


; Properties
;---------------------------------------------

Group Components
	BlackJack:Main Property BlackJack Auto Const Mandatory
	Shared:Motion:Controller Property Controller Auto Const Mandatory
EndGroup

Group Properties
	ObjectReference Property Gambling_Card Auto Const Mandatory
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
