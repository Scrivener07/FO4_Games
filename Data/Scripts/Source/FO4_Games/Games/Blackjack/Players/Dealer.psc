ScriptName Games:Blackjack:Players:Dealer extends Games:Blackjack:Player
import Games:Shared:Deck
import Games:Shared:Log

; Events
;---------------------------------------------

Event OnQuestInit()
	parent.OnQuestInit()
	Seating = new Seat
	Seating.Card01 = GamesBlackjack_DealerCard01
	Seating.Card01Reveal = GamesBlackjack_DealerCard01Reveal
	Seating.Card02 = GamesBlackjack_DealerCard02
	Seating.Card03 = GamesBlackjack_DealerCard03
	Seating.Card04 = GamesBlackjack_DealerCard04
	Seating.Card05 = GamesBlackjack_DealerCard05
	Seating.Card06 = GamesBlackjack_DealerCard06
	Seating.Card07 = GamesBlackjack_DealerCard07
	Seating.Card08 = GamesBlackjack_DealerCard08
	Seating.Card09 = GamesBlackjack_DealerCard09
	Seating.Card10 = GamesBlackjack_DealerCard10
	Seating.Card11 = GamesBlackjack_DealerCard11
EndEvent


; States
;---------------------------------------------

State Wagering
	int Function IWager()
		WriteLine(self, "A dealer does not wager a bet.")
		return Invalid
	EndFunction
EndState


State Dealing
	Event OnDrawn(Card drawn, ObjectReference marker)
		If (HandSize > 1)
			Motion.Translate(drawn.Reference, Blackjack.Deck.GamesBlackjack_DeckMarkerC)
		EndIf
		parent.OnDrawn(drawn, marker)
		Utility.Wait(0.25)
	EndEvent
EndState


State Playing
	Event OnTurn(int number)
		If (number == 1)
			; reveal the face down card
			Motion.Translate(Hand[0].Reference, Blackjack.Deck.GamesBlackjack_DeckMarkerC)
			Motion.Translate(Hand[0].Reference, Seating.Card01Reveal)
		EndIf
	EndEvent

	Event OnDrawn(Card drawn, ObjectReference marker)
		Motion.Translate(drawn.Reference, Blackjack.Deck.GamesBlackjack_DeckMarkerC)
		parent.OnDrawn(drawn, marker)
		Utility.Wait(0.25)
	EndEvent

	int Function IChoice()
		If (Score <= 17)
			return ChoiceHit
		Else
			return ChoiceStand
		EndIf
	EndFunction
EndState


; Requests
;---------------------------------------------

int Function IWager()
	; Required for type-check return because function is not on object.
	return parent.IWager()
EndFunction

int Function IChoice()
	; Required for type-check return because function is not on object.
	return parent.IChoice()
EndFunction


; Properties
;---------------------------------------------

Group Seat
	ObjectReference Property GamesBlackjack_DealerCard01 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard01Reveal Auto Const Mandatory
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
