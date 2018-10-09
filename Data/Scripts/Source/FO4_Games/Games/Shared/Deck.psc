ScriptName Games:Shared:Deck extends Games:Type
{Provies a common base class for collections that represent a deck of playing cards.}
import Games:Shared:Log

Card[] Array

Struct Card
	int Suit = -1
	int Rank = -1
	bool Drawn = true
	ObjectReference Reference
EndStruct


; Methods
;---------------------------------------------

; @Virtual
Card[] Function Seed()
	{Seeds the collection by providing an initial set of data. The default data is empty.}
	return new Card[0]
EndFunction


bool Function Create(Card[] values)
	{Initializes the deck with a new array of card values.}
	If (values)
		Array = values
		Restore()
		WriteLine(ToString(), "Created a deck of "+values.Length+" cards.")
		return true
	Else
		WriteUnexpectedValue(ToString(), "Create", "values", "Cannot create none or empty card values.")
		return false
	EndIf
EndFunction


bool Function Restore()
	{Will restore the drawn state of each card in the deck. This is called when the deck is created.}
	If (Array)
		int index = 0
		While (index < Array.Length)
			WriteLine(ToString(), "Restoring the drawn value for the "+Array[index]+" card.")
			Array[index].Drawn = false
			index += 1
		EndWhile
		return true
	Else
		WriteUnexpectedValue(ToString(), "Restore", "Array", "Cannot restore a none or empty card array.")
		return false
	EndIf
EndFunction


Card Function Draw()
	{Returns the next undrawn card from the deck, marking it as drawn.}
	If (Array)
		int found = Array.FindStruct("Drawn", false)
		If (found > Invalid)
			Card value = Array[found]
			value.Drawn = true
			WriteLine(ToString(), "Drawing the '"+value.Reference.GetDisplayName()+"' card from the deck.")
			return value
		Else
			WriteUnexpectedValue(ToString(), "Draw", "found", "No undrawn card could be found within the deck.")
			return none
		EndIf
	Else
		WriteUnexpectedValue(ToString(), "Draw", "Array", "The card array cannot be empty or none.")
		return none
	EndIf
EndFunction


bool Function Undraw(Card value)
	{Undraws the given card by marking its drawn member as false.}
	If (Array)
		If (value)
			If (Array.Find(value) > Invalid)
				value.Drawn = false
				WriteLine(ToString(), "The '"+value.Reference.GetDisplayName()+"' card has been undrawn.")
				return true
			Else
				WriteUnexpectedValue(ToString(), "Undraw", "value", "The card could not be found within the deck. "+value)
				return false
			EndIf
		Else
			WriteUnexpectedValue(ToString(), "Undraw", "value", "Cannot undraw a none card.")
			return false
		EndIf
	Else
		WriteUnexpectedValue(ToString(), "Undraw", "Array", "The card array cannot be empty or none.")
		return false
	EndIf
EndFunction


bool Function Shuffle()
	{Shuffles all cards within the deck.}
	If (Array)
		int count = Array.Length
		int index = 0
		While (index < count)
			int random = index + Utility.RandomInt() % (count - index)
			Card value = Array[index]
			Array[index] = Array[random]
			Array[random] = value
			index += 1
		EndWhile
		WriteLine(ToString(), "The deck has been shuffled.")
		return true
	Else
		WriteUnexpectedValue(ToString(), "Shuffle", "Array", "The card array cannot be empty or none.")
		return false
	EndIf
EndFunction


ObjectReference[] Function GetReferences()
	{Returns an array of object references for each card in the deck.}
	return ToReferences(Array)
EndFunction


; Functions
;---------------------------------------------

bool Function IsFaceCard(Card this)
	{Returns true if this card's rank is greater than ten. This includes the Jack, Queen, King, or Joker.}
	return this.Rank > Ten
EndFunction


int Function GetCardFamily(Card this)
	{Return the family for this card's suit. Odd suited card's are black, even are red.}
	If (this.Suit % 2)
		return Black
	Else
		return Red
	EndIf
EndFunction


bool Function CardEquals(Card this, Card other)
	{Returns true if this card is equal to the other card.}
	return this.Rank == other.Rank
EndFunction


ObjectReference[] Function ToReferences(Card[] values)
	{Returns a new array of each card's object reference.}
	If (values)
		ObjectReference[] references = new ObjectReference[0]
		int index = 0
		While (index < values.Length)
			references.Add(values[index].Reference)
			index += 1
		EndWhile
		return references
	Else
		return none
	EndIf
EndFunction


; @Override
string Function ToString()
	{The string representation of this script.}
	return parent.ToString()+"[Count:"+Cards.Length+"]"
EndFunction


; Properties
;---------------------------------------------

Group Properties
	Card[] Property Cards Hidden
		Card[] Function Get()
			return Array
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
