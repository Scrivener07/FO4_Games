ScriptName Gambling:BlackJack:Player extends Gambling:BlackJack:Component Hidden
import Gambling
import Gambling:BlackJack
import Gambling:Shared
import Gambling:Shared:Common


; Events
;---------------------------------------------

Event OnInit()
	SeatID = -1
	Winnings = 0
	Hand = new Deck:Card[0]
EndEvent


Event OnAllocate()
	Abort = false
	Score = 0
	Wager = 0
	Winnings = 0
EndEvent


Event OnDeal()
	Hand.Add(BlackJack.Cards.Draw())
	Hand.Add(BlackJack.Cards.Draw())
EndEvent


Event OnDeallocate()
	SeatID = -1
	Hand.Clear() ; use collect?
EndEvent



; Methods
;---------------------------------------------

; Function Deal(Card card)
; 	Hand.Add(card)
; 	Score = BlackJack.Rules.GetScore(Hand, Score)
; 	self.OnDeal(card)
; 	WriteLine(self, "Player '"+SeatID+"' has been dealt the '"+card+"' card for '"+Score+"' score.")
; EndFunction


; Properties
;---------------------------------------------

int Property SeatID = -1 Auto Hidden
int Property Score Auto Hidden
int Property Wager Auto Hidden
int Property Winnings Auto Hidden
bool Property Abort = false Auto Hidden

Card[] Property Hand Auto Hidden


Group Game
	BlackJack:Game Property BlackJack Auto Const Mandatory
	Shared:Motion:Controller Property Controller Auto Const Mandatory
EndGroup

Group Properties
	ObjectReference Property Gambling_BlackJack_DeckMarker Auto Const Mandatory
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
