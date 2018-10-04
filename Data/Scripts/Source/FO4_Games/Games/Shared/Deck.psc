ScriptName Games:Shared:Deck extends Games:Type
import Games:Shared:Log

Card[] Values

Struct Card
	int Suit = -1
	int Rank = -1
	bool Drawn = false
	ObjectReference Reference
EndStruct


; Methods
;---------------------------------------------

bool Function Create(Card[] array)
	If (array)
		Values = array
		WriteLine(ToString(), "Created a deck of "+array.Length+" cards.")
		return true
	Else
		WriteUnexpectedValue(ToString(), "Create", "array", "The card array cannot be empty or none.")
		return false
	EndIf
EndFunction


Card Function Draw()
	{Returns the next undrawn card from the deck, marking it as drawn.}
	If (Values)
		int index = Values.FindStruct("Drawn", false, 0)
		If (index > Invalid)
			Card value = Values[index]
			value.Drawn = true
			WriteLine(ToString(), "Drawing the '"+value.Reference.GetDisplayName()+"' card from the deck.")
			return value
		Else
			WriteLine(ToString(), "The deck has no cards left to draw.")
			return none
		EndIf
	Else
		WriteUnexpectedValue(ToString(), "Draw", "Values", "The card array cannot be empty or none.")
		return none
	EndIf
EndFunction


bool Function Collect(Card value)
	{Collects the given card by marking it undrawn.}
	If (Values)
		If (value)
			value.Drawn = false
			return true
		Else
			WriteLine(ToString(), "Cannot collect a none card.")
			return false
		EndIf
	Else
		WriteUnexpectedValue(ToString(), "Collect", "Values", "The card array cannot be empty or none.")
		return false
	EndIf
EndFunction


bool Function Shuffle()
	{Shuffles all cards within the deck.}
	If (Values)
		int count = Values.Length
		int index = 0

		While (index < count)
			int random = index + Utility.RandomInt() % (count - index)
			Card value = Values[index]
			Values[index] = Values[random]
			Values[random] = value
			index += 1
		EndWhile

		WriteLine(ToString(), "The deck has been shuffled.")
		return true
	Else
		WriteUnexpectedValue(ToString(), "Shuffle", "Values", "The card array cannot be empty or none.")
		return false
	EndIf
EndFunction


ObjectReference[] Function GetReferences()
	{Returns an array of object references for each card in the deck.}
	return ToReferences(Values)
EndFunction


; Functions
;---------------------------------------------

bool Function IsFaceCard(Card this)
	return this.Rank > Ten
EndFunction


int Function GetCardFamily(Card this)
	{Odd suited cards are black, even are red.}
	If (this.Suit % 2)
		return Black
	Else
		return Red
	EndIf
EndFunction


bool Function CardEquals(Card this, Card value)
	return this.Rank == value.Rank
EndFunction


ObjectReference[] Function ToReferences(Card[] array)
	{Returns a new array of each card's object reference.}
	If (array)
		ObjectReference[] references = new ObjectReference[0]
		int index = 0
		While (index < array.Length)
			references.Add(array[index].Reference)
			index += 1
		EndWhile
		return references
	Else
		return none
	EndIf
EndFunction


string Function ToString()
	{The string representation of this script.}
	return parent.ToString()+"[Count:"+Cards.Length+"]"
EndFunction


; Properties
;---------------------------------------------

Group Properties
	Card[] Property Cards Hidden
		Card[] Function Get()
			return Values
		EndFunction
	EndProperty
EndGroup

Group Suits
	int Property Spade = 1 AutoReadOnly
	int Property Heart = 2 AutoReadOnly
	int Property Club = 3 AutoReadOnly
	int Property Diamond = 4 AutoReadOnly
EndGroup

Group Family
	int Property Black = 1 AutoReadOnly
	int Property Red = 2 AutoReadOnly
EndGroup

Group Ranks
	int Property Ace = 1 AutoReadOnly
	int Property Two = 2 AutoReadOnly
	int Property Three = 3 AutoReadOnly
	int Property Four = 4 AutoReadOnly
	int Property Five = 5 AutoReadOnly
	int Property Six = 6 AutoReadOnly
	int Property Seven = 7 AutoReadOnly
	int Property Eight = 8 AutoReadOnly
	int Property Nine = 9 AutoReadOnly
	int Property Ten = 10 AutoReadOnly
	int Property Jack = 11 AutoReadOnly
	int Property Queen = 12 AutoReadOnly
	int Property King = 13 AutoReadOnly
	int Property Joker = 14 AutoReadOnly
EndGroup
