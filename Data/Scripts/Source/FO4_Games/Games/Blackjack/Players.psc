ScriptName Games:Blackjack:Players extends Games:Blackjack:Type
import Games
import Games:Blackjack
import Games:Shared
import Games:Shared:Log
import Games:Shared:Papyrus

Players:Seat[] Seats
Players:Seat Seat0
Players:Seat Seat1
Players:Seat Seat2
Players:Seat Seat3
Players:Seat Seat4
Players:Seat Seat5

Struct Seat
	Blackjack:Player Player
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


; Events
;---------------------------------------------

Event OnInit()
	Seats = new Players:Seat[0]

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

	Seat1 = new Players:Seat
	Seat1.Card01 = Games_Blackjack_P1C01
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

	Seat2 = new Players:Seat
	Seat2.Card01 = Games_Blackjack_P1C01
	Seat2.Card02 = Games_Blackjack_P1C02
	Seat2.Card03 = Games_Blackjack_P1C03
	Seat2.Card04 = Games_Blackjack_P1C04
	Seat2.Card05 = Games_Blackjack_P1C05
	Seat2.Card06 = Games_Blackjack_P1C06
	Seat2.Card07 = Games_Blackjack_P1C07
	Seat2.Card08 = Games_Blackjack_P1C08
	Seat2.Card09 = Games_Blackjack_P1C09
	Seat2.Card10 = Games_Blackjack_P1C10
	Seat2.Card11 = Games_Blackjack_P1C11

	Seat3 = new Players:Seat
	Seat3.Card01 = Games_Blackjack_P1C01
	Seat3.Card02 = Games_Blackjack_P1C02
	Seat3.Card03 = Games_Blackjack_P1C03
	Seat3.Card04 = Games_Blackjack_P1C04
	Seat3.Card05 = Games_Blackjack_P1C05
	Seat3.Card06 = Games_Blackjack_P1C06
	Seat3.Card07 = Games_Blackjack_P1C07
	Seat3.Card08 = Games_Blackjack_P1C08
	Seat3.Card09 = Games_Blackjack_P1C09
	Seat3.Card10 = Games_Blackjack_P1C10
	Seat3.Card11 = Games_Blackjack_P1C11

	Seat4 = new Players:Seat
	Seat4.Card01 = Games_Blackjack_P1C01
	Seat4.Card02 = Games_Blackjack_P1C02
	Seat4.Card03 = Games_Blackjack_P1C03
	Seat4.Card04 = Games_Blackjack_P1C04
	Seat4.Card05 = Games_Blackjack_P1C05
	Seat4.Card06 = Games_Blackjack_P1C06
	Seat4.Card07 = Games_Blackjack_P1C07
	Seat4.Card08 = Games_Blackjack_P1C08
	Seat4.Card09 = Games_Blackjack_P1C09
	Seat4.Card10 = Games_Blackjack_P1C10
	Seat4.Card11 = Games_Blackjack_P1C11

	Seat5 = new Players:Seat
	Seat5.Card01 = Games_Blackjack_P1C01
	Seat5.Card02 = Games_Blackjack_P1C02
	Seat5.Card03 = Games_Blackjack_P1C03
	Seat5.Card04 = Games_Blackjack_P1C04
	Seat5.Card05 = Games_Blackjack_P1C05
	Seat5.Card06 = Games_Blackjack_P1C06
	Seat5.Card07 = Games_Blackjack_P1C07
	Seat5.Card08 = Games_Blackjack_P1C08
	Seat5.Card09 = Games_Blackjack_P1C09
	Seat5.Card10 = Games_Blackjack_P1C10
	Seat5.Card11 = Games_Blackjack_P1C11
EndEvent


; Methods
;---------------------------------------------

bool Function Sit(Blackjack:Player player, Players:Seat seat)
	{TODO}
	seat.Player = player
	Add(seat)
EndFunction


bool Function Leave(Blackjack:Player player)
	{TODO}
	; TODO: Ensure that the players cards are collected back into the deck.

	If (ClearState(player))
		int index = FindBy(player)
		If (index > Invalid)
			Players:Seat seat = Seats[index]
			If (Remove(seat))
				return AwaitState(player, ExitingState)
			Else
				WriteUnexpected(self, "Leave", player+" failed to leave.")
				return false
			EndIf
		Else
			WriteUnexpected(self, "Leave", player+" seems to have already left.")
			return false
		EndIf
	Else
		WriteUnexpected(self, "Leave", player+" could not clear state.")
		return false
	EndIf
EndFunction


ObjectReference Function GetMarkerFor(Blackjack:Player player, int next)
	If (player)
		Players:Seat seat = Seats[FindBy(player)]
		If (seat)
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
		Else
			WriteUnexpectedValue(self, "NextMarker", "seat", "Could not find a seat for the '"+player+"' player in the array.")
			return none
		EndIf
	Else
		WriteUnexpectedValue(self, "NextMarker", "player", "The player cannot be none.")
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


; Functions
;---------------------------------------------

int Function IndexOf(Players:Seat seat)
	{Determines the index of the given seat in the collection.}
	If (seat)
		return Seats.Find(seat)
	Else
		return Invalid
	EndIf
EndFunction


Players:Seat Function GetAt(int index)
	{Gets the value at the given index in the collection.}
	return Seats[index]
EndFunction


bool Function Contains(Players:Seat seat)
	{Determines whether the given seat is contained in the collection.}
	return IndexOf(seat) > Invalid
EndFunction


int Function FindBy(Blackjack:Player player)
	{Determines the index of the seat for the given player in the collection.}
	If (player)
		return Seats.FindStruct("Player", player)
	Else
		WriteUnexpectedValue(self, "FindBy", "player", "Cannot find a none player in array.")
		return Invalid
	EndIf
EndFunction


bool Function Add(Players:Seat seat)
	{Adds the given seat to the collection.}
	If (seat)
		If (Contains(seat) == false) ; does not contain the seat
			If (seat.Player)
				int found = FindBy(seat.Player)
				If (found == Invalid)
					Seats.Add(seat)
					return true
				Else
					WriteUnexpectedValue(self, "Add", "seat.Player", "The array already contains the '"+seat.Player+"' player.")
					return false
				EndIf
			Else
				WriteUnexpectedValue(self, "Add", "seat.Player", "Cannot add seat with a none player to array.")
				return false
			EndIf
		Else
			WriteUnexpectedValue(self, "Add", "seat", "The array already contains the '"+seat+"' seat.")
			return false
		EndIf
	Else
		WriteUnexpectedValue(self, "Add", "seat", "Cannot add a none seat to array.")
		return false
	EndIf
EndFunction


bool Function Remove(Players:Seat seat)
	{Removes the first occurrence of the given seat from the collection.}
	If (seat)
		int index = IndexOf(seat)
		return RemoveAt(index)
	Else
		WriteUnexpectedValue(self, "Remove", "seat", "Cannot remove a none value from seat array.")
		return false
	EndIf
EndFunction


bool Function RemoveAt(int index)
	{Removes the seat at the given index from the collection.}
	If (index > Invalid)
		Seats[index].Player = none
		Seats.Remove(index)
		return true
	Else
		WriteUnexpectedValue(self, "RemoveAt", "index", "The array index "+index+" is invalid.")
		return false
	EndIf
EndFunction


bool Function Clear()
	{Removes all seats from the collection.}
	If (Seats)
		int index = 0
		While (index < Seats.Length)
			Seats[index].Player = none
			index += 1
		EndWhile
		Seats.Clear()
		return true
	Else
		WriteUnexpectedValue(self, "Clear", "Seats", "Cannot clear empty or none array.")
		return false
	EndIf
EndFunction


bool Function For(Players:Seat[] array)
	If (array)
		int index = 0
		While (index < array.Length)
			Each(array[index])
			index += 1
		EndWhile
		return true
	Else
		WriteUnexpectedValue(self, "For", "array", "Cannot iterate an empty or none array.")
		return false
	EndIf
EndFunction


Function Each(Players:Seat seat)
	{EMPTY}
	WriteNotImplemented(self, "Each", "The member is not implemented in the empty state.")
EndFunction


; States
;---------------------------------------------

State Starting
	Event OnState()
		{Starting}
		Sit(Dealer, Seat0)
		Sit(Human, Seat1)
		For(Seats)
	EndEvent

	Function Each(Players:Seat seat)
		StartState(seat.Player, StartingState)
	EndFunction
EndState


State Wagering
	Event OnState()
		{Wagering}
		For(Seats)
	EndEvent

	Function Each(Players:Seat seat)
		StartState(seat.Player, WageringState)
	EndFunction
EndState


State Dealing
	Event OnState()
		{Dealing}
		For(Seats)
	EndEvent

	bool Function For(Players:Seat[] array)
		; TODO: Should I draw two cards in the player's dealing task instead?
		If (array)
			int index = 0
			While (index < array.Length)
				Each(array[index])
				index += 1
			EndWhile

			index = 0
			While (index < array.Length)
				Each(array[index])
				index += 1
			EndWhile
			return true
		Else
			WriteUnexpectedValue(self, "For", "array", "The array cannot be empty or none.")
			return false
		EndIf
	EndFunction


	Function Each(Players:Seat seat)
		AwaitState(seat.Player, DealingState)
	EndFunction
EndState


State Playing
	Event OnState()
		{Playing}
		For(Seats)
	EndEvent

	Function Each(Players:Seat seat)
		AwaitState(seat.Player, PlayingState)
	EndFunction
EndState


State Scoring
	Event OnState()
		{Scoring}
		For(Seats)
	EndEvent

	Function Each(Players:Seat seat)
		AwaitState(seat.Player, ScoringState)
		Cards.CollectFrom(seat.Player)
	EndFunction
EndState


State Exiting
	Event OnState()
		{Exiting}
		For(Seats)
		Clear()
	EndEvent

	Function Each(Players:Seat seat)
		AwaitState(seat.Player, ExitingState)
	EndFunction
EndState


; Properties
;---------------------------------------------

Group Scripts
	Shared:Deck Property Deck Auto Const Mandatory
	Blackjack:Cards Property Cards Auto Const Mandatory
	Blackjack:Players:Human Property Human Auto Const Mandatory
	Blackjack:Players:Dealer Property Dealer Auto Const Mandatory
EndGroup

Group Properties
	int Property Count Hidden
		int Function Get()
			return Seats.Length
		EndFunction
	EndProperty

	bool Property HasDealer Hidden
		bool Function Get()
			return FindBy(Dealer) > Invalid
		EndFunction
	EndProperty

	bool Property HasHuman Hidden
		bool Function Get()
			return FindBy(Human) > Invalid
		EndFunction
	EndProperty
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

Group Seat2
	ObjectReference Property Games_Blackjack_P2C01 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C02 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C03 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C04 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C05 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C06 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C07 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C08 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C09 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C10 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C11 Auto Const Mandatory
EndGroup

Group Seat3
	ObjectReference Property Games_Blackjack_P3C01 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P3C02 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P3C03 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P3C04 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P3C05 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P3C06 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P3C07 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P3C08 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P3C09 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P3C10 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P3C11 Auto Const Mandatory
EndGroup

Group Seat4
	ObjectReference Property Games_Blackjack_P4C01 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P4C02 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P4C03 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P4C04 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P4C05 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P4C06 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P4C07 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P4C08 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P4C09 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P4C10 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P4C11 Auto Const Mandatory
EndGroup

Group Seat5
	ObjectReference Property Games_Blackjack_P5C01 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P5C02 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P5C03 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P5C04 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P5C05 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P5C06 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P5C07 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P5C08 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P5C09 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P5C10 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P5C11 Auto Const Mandatory
EndGroup
