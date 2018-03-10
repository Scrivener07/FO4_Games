ScriptName Games:Blackjack:Players extends Games:Blackjack:Type
import Games
import Games:Blackjack
import Games:Shared
import Games:Shared:Log
import Games:Shared:Papyrus

Players:Seat Seat0
Players:Seat Seat1

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
		Seat0.Card01 = Games_Blackjack_D1C01
		Seat0.Card01Reveal = Games_Blackjack_D1C01B
		Seat0.Card02 = Games_Blackjack_D1C02
		Seat0.Card03 = Games_Blackjack_D1C03
		Seat0.Card04 = Games_Blackjack_D1C04
		Seat0.Card05 = Games_Blackjack_D1C05
		Seat0.Card06 = Games_Blackjack_D1C06
		Seat0.Card07 = Games_Blackjack_D1C07
		Seat0.Card08 = Games_Blackjack_D1C08
		Seat0.Card09 = Games_Blackjack_D1C09
		Seat0.Card10 = Games_Blackjack_D1C10
		Seat0.Card11 = Games_Blackjack_D1C11
		Dealer.Seating = Seat0

		Seat1 = new Players:Seat
		Seat1.Card01 = Games_Blackjack_P1C01
		Seat1.Card01Reveal = Games_Blackjack_P1C01
		Seat1.Card02 = Games_Blackjack_P1C02
		Seat1.Card03 = Games_Blackjack_P1C03
		Seat1.Card04 = Games_Blackjack_P1C04
		Seat1.Card05 = Games_Blackjack_P1C05
		Seat1.Card06 = Games_Blackjack_P1C06
		Seat1.Card07 = Games_Blackjack_P1C07
		Seat1.Card08 = Games_Blackjack_P1C08
		Seat1.Card09 = Games_Blackjack_P1C09
		Seat1.Card10 = Games_Blackjack_P1C10
		Seat1.Card11 = Games_Blackjack_P1C11
		Human.Seating = Seat1

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
		Cards.CollectFrom(Human)

		AwaitState(Dealer, ScoringState)
		Cards.CollectFrom(Dealer)
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

Group Seat0
	ObjectReference Property Games_Blackjack_D1C01 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_D1C01B Auto Const Mandatory
	ObjectReference Property Games_Blackjack_D1C02 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_D1C03 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_D1C04 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_D1C05 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_D1C06 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_D1C07 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_D1C08 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_D1C09 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_D1C10 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_D1C11 Auto Const Mandatory
EndGroup

Group Seat1
	ObjectReference Property Games_Blackjack_P1C01 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P1C02 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P1C03 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P1C04 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P1C05 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P1C06 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P1C07 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P1C08 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P1C09 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P1C10 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P1C11 Auto Const Mandatory
EndGroup
