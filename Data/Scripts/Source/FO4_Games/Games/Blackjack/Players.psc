ScriptName Games:Blackjack:Players extends Games:Blackjack:Type
import Games
import Games:Blackjack
import Games:Shared
import Games:Shared:Deck
import Games:Shared:Log
import Games:Shared:Papyrus

Players:Seat Seat0
Players:Seat Seat1

; Players:Seat SeatSplitA
; Players:Seat SeatSplitB


Struct Seat
	ObjectReference Card01
	ObjectReference Card01Reveal
	ObjectReference Card02
	ObjectReference Card03
	ObjectReference Card04
	ObjectReference Card05
	ObjectReference Card06
	ObjectReference Card07
	ObjectReference Card08
	ObjectReference Card09
	ObjectReference Card10
	ObjectReference Card11
EndStruct


; States
;---------------------------------------------

State Starting
	Event OnState()
		{Starting}
		Seat0 = new Players:Seat
		Seat0.Card01 = Cards.GamesBlackjack_DealerCard01
		Seat0.Card01Reveal = Cards.GamesBlackjack_DealerCard01Reveal
		Seat0.Card02 = Cards.GamesBlackjack_DealerCard02
		Seat0.Card03 = Cards.GamesBlackjack_DealerCard03
		Seat0.Card04 = Cards.GamesBlackjack_DealerCard04
		Seat0.Card05 = Cards.GamesBlackjack_DealerCard05
		Seat0.Card06 = Cards.GamesBlackjack_DealerCard06
		Seat0.Card07 = Cards.GamesBlackjack_DealerCard07
		Seat0.Card08 = Cards.GamesBlackjack_DealerCard08
		Seat0.Card09 = Cards.GamesBlackjack_DealerCard09
		Seat0.Card10 = Cards.GamesBlackjack_DealerCard10
		Seat0.Card11 = Cards.GamesBlackjack_DealerCard11
		Dealer.Seating = Seat0


		Seat1 = new Players:Seat
		Seat1.Card01 = Cards.GamesBlackjack_PlayerCard01
		Seat1.Card01Reveal = Cards.GamesBlackjack_PlayerCard01
		Seat1.Card02 = Cards.GamesBlackjack_PlayerCard02
		Seat1.Card03 = Cards.GamesBlackjack_PlayerCard03
		Seat1.Card04 = Cards.GamesBlackjack_PlayerCard04
		Seat1.Card05 = Cards.GamesBlackjack_PlayerCard05
		Seat1.Card06 = Cards.GamesBlackjack_PlayerCard06
		Seat1.Card07 = Cards.GamesBlackjack_PlayerCard07
		Seat1.Card08 = Cards.GamesBlackjack_PlayerCard08
		Seat1.Card09 = Cards.GamesBlackjack_PlayerCard09
		Seat1.Card10 = Cards.GamesBlackjack_PlayerCard10
		Seat1.Card11 = Cards.GamesBlackjack_PlayerCard11
		Human.Seating = Seat1

		; SeatSplitA = new Players:Seat
		; SeatSplitA.Card01 = Cards.GamesBlackjack_PlayerCardSplitA01
		; SeatSplitA.Card02 = Cards.GamesBlackjack_PlayerCardSplitA02
		; SeatSplitA.Card03 = Cards.GamesBlackjack_PlayerCardSplitA03
		; SeatSplitA.Card04 = Cards.GamesBlackjack_PlayerCardSplitA04
		; SeatSplitA.Card05 = Cards.GamesBlackjack_PlayerCardSplitA05
		; SeatSplitA.Card06 = Cards.GamesBlackjack_PlayerCardSplitA06
		; SeatSplitA.Card07 = Cards.GamesBlackjack_PlayerCardSplitA07
		; SeatSplitA.Card08 = Cards.GamesBlackjack_PlayerCardSplitA08
		; SeatSplitA.Card09 = Cards.GamesBlackjack_PlayerCardSplitA09
		; SeatSplitA.Card10 = Cards.GamesBlackjack_PlayerCardSplitA10
		; SeatSplitA.Card11 = Cards.GamesBlackjack_PlayerCardSplitA11
		; Human.SeatingSplitA = SeatSplitA

		; SeatSplitB = new Players:Seat
		; SeatSplitB.Card01 = Cards.GamesBlackjack_PlayerCardSplitB01
		; SeatSplitB.Card02 = Cards.GamesBlackjack_PlayerCardSplitB02
		; SeatSplitB.Card03 = Cards.GamesBlackjack_PlayerCardSplitB03
		; SeatSplitB.Card04 = Cards.GamesBlackjack_PlayerCardSplitB04
		; SeatSplitB.Card05 = Cards.GamesBlackjack_PlayerCardSplitB05
		; SeatSplitB.Card06 = Cards.GamesBlackjack_PlayerCardSplitB06
		; SeatSplitB.Card07 = Cards.GamesBlackjack_PlayerCardSplitB07
		; SeatSplitB.Card08 = Cards.GamesBlackjack_PlayerCardSplitB08
		; SeatSplitB.Card09 = Cards.GamesBlackjack_PlayerCardSplitB09
		; SeatSplitB.Card10 = Cards.GamesBlackjack_PlayerCardSplitB10
		; SeatSplitB.Card11 = Cards.GamesBlackjack_PlayerCardSplitB11
		; Human.SeatingSplitB = SeatSplitB


		BeginState(Dealer, StartingState)
		BeginState(Human, StartingState)
	EndEvent
EndState



State Wagering
	Event OnState()
		{Wagering}
		BeginState(Dealer, WageringState)
		BeginState(Human, WageringState)
	EndEvent
EndState


State Dealing
	Event OnState()
		{Dealing}
		AwaitState(Dealer, DealingState)
		AwaitState(Human, DealingState)

		AwaitState(Dealer, DealingState)
		AwaitState(Human, DealingState)
	EndEvent
EndState


State Playing
	Event OnState()
		{Playing}
		AwaitState(Human, PlayingState)
		AwaitState(Dealer, PlayingState)
	EndEvent
EndState


State Scoring
	Event OnState()
		{Scoring}
		AwaitState(Human, ScoringState)
		CollectFrom(Human)

		AwaitState(Dealer, ScoringState)
		CollectFrom(Dealer)
	EndEvent
EndState


State Exiting
	Event OnState()
		{Exiting}
		AwaitState(Human, ExitingState)
		AwaitState(Dealer, ExitingState)
	EndEvent
EndState


; Methods
;---------------------------------------------

Card Function DrawFor(Blackjack:Player player) ; pass the seating into here for splitting.
	If (player.CanDraw)
		Card drawn = Cards.Draw()

		If (drawn)
			If (drawn.Reference)
				ObjectReference marker = GetMarkerFor(player.Seating, player.HandLast)
				If (marker)
					player.Hand.Add(drawn)
					int newScore = Score(player)
					player.SetScore(newScore)
					player.OnDrawn(drawn, marker)
					return drawn
				Else
					Cards.Deck.Collect(drawn)
					WriteUnexpectedValue(self, "DrawFor", "marker", "The turn card marker cannot be none.")
					return none
				EndIf
			Else
				Cards.Deck.Collect(drawn)
				WriteUnexpectedValue(self, "DrawFor", "drawn.Reference", "Cannot draw card with a none Card.Reference.")
				return none
			EndIf
		Else
			WriteUnexpectedValue(self, "DrawFor", "drawn", "The draw card cannot be none.")
			return none
		EndIf
	Else
		WriteUnexpectedValue(self, "DrawFor", "CanDraw", "Cannot draw another card right now.")
		return none
	EndIf
EndFunction


Function CollectFrom(Blackjack:Player player)
	If (player)
		Cards.CollectEach(player.Hand)
		player.Motion.TranslateEach(Deck.ToReferences(player.Hand), Cards.GamesBlackjack_DeckMarker)
	Else
		WriteUnexpectedValue(self, "CollectFrom", "player", "Cannot collect cards from a none player.")
	EndIf
EndFunction


ObjectReference Function GetMarkerFor(Players:Seat seat, int next)
	If (next == Invalid)
		return seat.Card01
	ElseIf (next == 0)
		return seat.Card02
	ElseIf (next == 1)
		return seat.Card03
	ElseIf (next == 2)
		return seat.Card04
	ElseIf (next == 3)
		return seat.Card05
	ElseIf (next == 4)
		return seat.Card06
	ElseIf (next == 5)
		return seat.Card07
	ElseIf (next == 6)
		return seat.Card08
	ElseIf (next == 7)
		return seat.Card09
	ElseIf (next == 8)
		return seat.Card10
	ElseIf (next == 9)
		return seat.Card11
	Else
		WriteUnexpectedValue(self, "NextMarker", "next", "The next marker "+next+" is out of range.")
		return none
	EndIf
EndFunction


int Function Score(Blackjack:Player player)
	int score = 0
	int index = 0
	While (index < player.Hand.Length)
		Deck:Card card = player.Hand[index]

		If (card.Rank == Deck.Ace)
			score += 11
		ElseIf (Deck.IsFaceCard(card))
			score += 10
		Else
			score += card.Rank
		EndIf

		index += 1
	EndWhile

	index = 0
	While (index < player.Hand.Length)
		Deck:Card card = player.Hand[index]

		If (card.Rank == Deck.Ace)
			If (player.IsBust(score))
				score -= 10
			EndIf
		EndIf

		index += 1
	EndWhile

	return score
EndFunction


; Properties
;---------------------------------------------

Group Scripts
	Shared:Deck Property Deck Auto Const Mandatory
	Blackjack:Cards Property Cards Auto Const Mandatory
	Blackjack:Players:Human Property Human Auto Const Mandatory
	Blackjack:Players:Dealer Property Dealer Auto Const Mandatory
EndGroup
