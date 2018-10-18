ScriptName Games:Blackjack:Dealer extends Games:Blackjack:Players:Object
import Games:Blackjack:Players:Hand
import Games:Shared
import Games:Shared:Log
import Games:Shared:Papyrus

; Events
;---------------------------------------------

Event OnQuestInit()
	parent.OnQuestInit()
	Hand.Markers = new Marker
	Hand.Markers.Delay = 0.25
	Hand.Markers.Transition = GamesBlackjack_DeckMarkerC
	Hand.Markers.Card01 = GamesBlackjack_DealerCard01
	Hand.Markers.Card02 = GamesBlackjack_DealerCard02
	Hand.Markers.Card03 = GamesBlackjack_DealerCard03
	Hand.Markers.Card04 = GamesBlackjack_DealerCard04
	Hand.Markers.Card05 = GamesBlackjack_DealerCard05
	Hand.Markers.Card06 = GamesBlackjack_DealerCard06
	Hand.Markers.Card07 = GamesBlackjack_DealerCard07
	Hand.Markers.Card08 = GamesBlackjack_DealerCard08
	Hand.Markers.Card09 = GamesBlackjack_DealerCard09
	Hand.Markers.Card10 = GamesBlackjack_DealerCard10
	Hand.Markers.Card11 = GamesBlackjack_DealerCard11
EndEvent


; States
;---------------------------------------------

State Wagering
	Function WagerSet(IntegerValue setter)
		{The dealer does not wager any bets.}
		setter.Value = 0
		WriteLine(ToString(), "A dealer does not wager a bet. The bet equals zero.")
	EndFunction
EndState


State Dealing
	Event OnState()
		{The dealer does not reveal their hole card.}
		bool reveal = Hand.Count > 1
		If (Hand.Draw(reveal))
			Utility.Wait(Hand.Markers.Delay)
			WriteLine(ToString(), "Dealt a card." + Hand.Drawn)
		EndIf
	EndEvent
EndState


State Playing
	Event OnTurn(BooleanValue continue)
		{The dealer reveals their hole card.}
		If (Turn == 1)
			Deck:Card card = Hand.Cards[0]
			Motion.Translate(card.Reference, Hand.Markers.Transition)
			Motion.Translate(card.Reference, GamesBlackjack_DealerCard01Reveal)
		EndIf
		parent.OnTurn(continue)
	EndEvent

	Function ChoiceSet(IntegerValue setter)
		{The dealer will hit when their score is less than 17.}
		If (Score < 17)
			setter.Value = ChoiceHit
		Else
			setter.Value = ChoiceStand
		EndIf
	EndFunction
EndState


State Scoring
	Event OnState()
		{A dealer does not need to be scored.}
	EndEvent
EndState


; Methods
;---------------------------------------------

bool Function Reveal()
	If (Hand.Count == 2)
		Motion.Translate(Hand.Cards[0].Reference, GamesBlackjack_DealerCardRevealA)
		Motion.Translate(Hand.Cards[1].Reference, GamesBlackjack_DealerCardRevealB)
		Utility.Wait(1.5)
		Motion.Translate(Hand.Cards[0].Reference, GamesBlackjack_DealerCard01Reveal)
		Motion.Translate(Hand.Cards[1].Reference, GamesBlackjack_DealerCard02)
		return true
	Else
		WriteUnexpectedValue(ToString(), "Reveal", "The hand must have exactly two cards.")
		return false
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Marker
	ObjectReference Property GamesBlackjack_DeckMarkerC Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard01 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard01Reveal Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCardRevealA Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCardRevealB Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard02 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard03 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard04 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard05 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard06 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard07 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard08 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard09 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard10 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard11 Auto Const Mandatory
EndGroup
