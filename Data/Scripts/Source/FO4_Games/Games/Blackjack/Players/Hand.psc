ScriptName Games:Blackjack:Players:Hand extends Games:Blackjack:Type
{A custom collection for a players hand of cards.}
import Games
import Games:Shared
import Games:Shared:Log

int Score_ = 0
Deck:Card[] Array

Struct Marker
	float Delay = 0.5
	ObjectReference Transition
	ObjectReference Card01
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

int Win = 21 const


; Events
;---------------------------------------------

Event OnQuestInit()
	{Initialize the array so that the object's properties are valid.}
	Create()
EndEvent


; Methods
;---------------------------------------------

Function Create()
	{Creates a new internal hand array.}
	Score_ = 0
	Array = new Deck:Card[0]
	WriteLine(ToString(), "Created a new empty hand.")
EndFunction


bool Function Draw(bool reveal = true)
	{Adds a card to this hand if drawing from the deck was successful.}
	If (CanDraw)
		Deck:Card card = Deck.Draw()
		If (card)
			If (card.Reference)
				ObjectReference destination = GetMarker()
				If (destination)
					Cards.Add(card)
					Score_ = GetScore()
					If (reveal)
						Player.Motion.Translate(card.Reference, Markers.Transition)
						Utility.Wait(Markers.Delay)
					EndIf
					Player.Motion.Translate(card.Reference, destination)
					return true
				Else
					Deck.Undraw(card)
					WriteUnexpectedValue(ToString(), "Draw", "destination", "The card marker reference cannot be none.")
					return false
				EndIf
			Else
				Deck.Undraw(card)
				WriteUnexpectedValue(ToString(), "Draw", "card.Reference", "Cannot draw card with a none card reference.")
				return false
			EndIf
		Else
			WriteUnexpectedValue(ToString(), "Draw", "card", "The draw card cannot be none.")
			return false
		EndIf
	Else
		WriteUnexpectedValue(ToString(), "Draw", "CanDraw", "Cannot draw another card right now.")
		return false
	EndIf
EndFunction


Function Collect()
	{Collects all of this hands cards into the deck.}
	WriteLine(ToString(), "Collecting the cards for this hand.")
	Deck.Collect(Cards)
	ObjectReference[] references = Deck.ToReferences(Cards)
	Player.Motion.TranslateEach(references, Deck.GamesBlackjack_DeckMarker)
	Create()
EndFunction


; Functions
;---------------------------------------------

int Function GetScore()
	{Calculates the score of the all the cards in this hand.}
	int value = 0
	int index = 0
	While (index < Count)
		Deck:Card card = Cards[index]

		If (card.Rank == Deck.Ace)
			value += 11
		ElseIf (Deck.IsFaceCard(card))
			value += 10
		Else
			value += card.Rank
		EndIf
		index += 1
	EndWhile
	index = 0
	While (index < Count)
		Deck:Card card = Cards[index]
		If (card.Rank == Deck.Ace)
			; If score exceeds 21, then make the Ace soft.
			If (value > Win)
				value -= 10
			EndIf
		EndIf
		index += 1
	EndWhile
	return value
EndFunction


ObjectReference Function GetMarker()
	{Returns the destination reference for the current card index.}
	If (Current == Invalid)
		return Markers.Card01
	ElseIf (Current == 0)
		return Markers.Card02
	ElseIf (Current == 1)
		return Markers.Card03
	ElseIf (Current == 2)
		return Markers.Card04
	ElseIf (Current == 3)
		return Markers.Card05
	ElseIf (Current == 4)
		return Markers.Card06
	ElseIf (Current == 5)
		return Markers.Card07
	ElseIf (Current == 6)
		return Markers.Card08
	ElseIf (Current == 7)
		return Markers.Card09
	ElseIf (Current == 8)
		return Markers.Card10
	ElseIf (Current == 9)
		return Markers.Card11
	Else
		WriteUnexpectedValue(ToString(), "GetMarker", "Current", "The marker "+Current+" is out of range.")
		return none
	EndIf
EndFunction


string Function ToString()
	{The string representation of this script.}
	return parent.ToString()+" Name:"+Player.Name+", Score:"+Score+", Count:"+Count
EndFunction


; Properties
;---------------------------------------------

Group Properties
	Blackjack:Deck Property Deck Auto Const Mandatory
	Blackjack:Players:Object Property Player Auto Const Mandatory
EndGroup

Group Cards
	Marker Property Markers Auto Hidden
	{Data containing destination references for cards.}

	Deck:Card[] Property Cards Hidden
		{A collection of cards that belong to this hand.}
		Deck:Card[] Function Get()
			return Array
		EndFunction
	EndProperty

	Deck:Card Property Drawn Hidden
		{The last card to be drawn from the deck.}
		Deck:Card Function Get()
			return Array[Current]
		EndFunction
	EndProperty

	int Property Count Hidden
		{The amount of cards in this hand.}
		int Function Get()
			return Array.Length
		EndFunction
	EndProperty

	int Property Current Hidden
		{The index of the last card to be drawn from the deck.}
		int Function Get()
			return Array.Length - 1
		EndFunction
	EndProperty

	bool Property CanDraw Hidden
		{Returns true is this hand is able to draw a card.}
		bool Function Get()
			return IsInPlay
		EndFunction
	EndProperty
EndGroup

Group Score
	int Property Score Hidden
		{The total score of each card in this hand.}
		int Function Get()
			return Score_
		EndFunction
	EndProperty

	bool Property IsInPlay Hidden
		{Returns true if the hands score is still in play.}
		bool Function Get()
			return Score < Win
		EndFunction
	EndProperty

	bool Property IsWin Hidden
		{Returns true if the hands score is 21.}
		bool Function Get()
			return Score == Win
		EndFunction
	EndProperty

	bool Property IsBlackjack Hidden
		{Returns true if the hand score is 21 and the hand only contains two cards.}
		bool Function Get()
			return IsWin && Count == 2
		EndFunction
	EndProperty

	bool Property IsBust Hidden
		{Returns true if the hands score has exceeded 21.}
		bool Function Get()
			return Score > Win
		EndFunction
	EndProperty
EndGroup
