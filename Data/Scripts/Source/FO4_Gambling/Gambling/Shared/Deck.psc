ScriptName Gambling:Shared:Deck extends ReferenceAlias
import Gambling:Shared:Common


Card[] Cards


; Methods
;---------------------------------------------

Card Function Draw()
	{Returns the next undrawn card from the deck, marking it as drawn.}
	If (Cards)
		int index = Cards.FindStruct("Drawn", false, 0)
		If (index > Invalid)
			Card value = Cards[index]
			value.Drawn = true
			WriteLine(self, "Drawing the '"+value.Rank+"' card from the deck.")
			return value
		Else
			WriteLine(self, "The deck has no cards left to draw.")
			return none
		EndIf
	Else
		WriteLine(self, "Cannot draw empty or none deck.")
		return none
	EndIf
EndFunction


bool Function Collect(Card value)
	{Collects the given card by marking it undrawn.}
	If (Cards)
		If (value)
			If (value.Drawn)
				value.Drawn = false
				return true
			Else
				WriteLine(self, "The card is already collected.")
				return false
			EndIf
		Else
			WriteLine(self, "Cannot collect none card.")
			return false
		EndIf
	Else
		WriteLine(self, "Cannot collect empty or none deck.")
		return false
	EndIf
EndFunction


bool Function Shuffle()
	{Shuffles all cards within the deck.}
	If (Cards)
		int count = Cards.Length
		int index = 0

		While (index < count)
			int random = index + Utility.RandomInt() % (count - index)
			Card value = Cards[index]
			Cards[index] = Cards[random]
			Cards[random] = value
			index += 1
		EndWhile

		WriteLine(self, "The deck has been shuffled.")
		return true
	Else
		WriteLine(self, "Cannot shuffle a none deck.")
		return false
	EndIf
EndFunction


Card[] Function SetData(ReferenceData data)
	WriteLine(self, "Setting card reference data.")

	Cards = new Card[0]

	If (UseJoker)
		Card Joker01 = new Card
		Joker01.Suit = Invalid
		Joker01.Rank = Joker
		Joker01.Reference = data.JokerBlack
		Cards.Add(Joker01)

		Card Joker02 = new Card
		Joker02.Suit = Invalid
		Joker02.Rank = Joker
		Joker02.Reference = data.JokerRed
		Cards.Add(Joker02)
	EndIf

	Card Spade01 = new Card
	Spade01.Suit = Spade
	Spade01.Rank = Ace
	Spade01.Reference = data.Spade01
	Cards.Add(Spade01)

	Card Spade02 = new Card
	Spade02.Suit = Spade
	Spade02.Rank = Two
	Spade02.Reference = data.Spade02
	Cards.Add(Spade02)

	Card Spade03 = new Card
	Spade03.Suit = Spade
	Spade03.Rank = Three
	Spade03.Reference = data.Spade03
	Cards.Add(Spade03)

	Card Spade04 = new Card
	Spade04.Suit = Spade
	Spade04.Rank = Four
	Spade04.Reference = data.Spade04
	Cards.Add(Spade04)

	Card Spade05 = new Card
	Spade05.Suit = Spade
	Spade05.Rank = Five
	Spade05.Reference = data.Spade05
	Cards.Add(Spade05)

	Card Spade06 = new Card
	Spade06.Suit = Spade
	Spade06.Rank = Six
	Spade06.Reference = data.Spade06
	Cards.Add(Spade06)

	Card Spade07 = new Card
	Spade07.Suit = Spade
	Spade07.Rank = Seven
	Spade07.Reference = data.Spade07
	Cards.Add(Spade07)

	Card Spade08 = new Card
	Spade08.Suit = Spade
	Spade08.Rank = Eight
	Spade08.Reference = data.Spade08
	Cards.Add(Spade08)

	Card Spade09 = new Card
	Spade09.Suit = Spade
	Spade09.Rank = Nine
	Spade09.Reference = data.Spade09
	Cards.Add(Spade09)

	Card Spade10 = new Card
	Spade10.Suit = Spade
	Spade10.Rank = Ten
	Spade10.Reference = data.Spade10
	Cards.Add(Spade10)

	Card Spade11 = new Card
	Spade11.Suit = Spade
	Spade11.Rank = Jack
	Spade11.Reference = data.Spade11
	Cards.Add(Spade11)

	Card Spade12 = new Card
	Spade12.Suit = Spade
	Spade12.Rank = Queen
	Spade12.Reference = data.Spade12
	Cards.Add(Spade12)

	Card Spade13 = new Card
	Spade13.Suit = Spade
	Spade13.Rank = King
	Spade13.Reference = data.Spade13
	Cards.Add(Spade13)


	Card Diamond01 = new Card
	Diamond01.Suit = Diamond
	Diamond01.Rank = Ace
	Diamond01.Reference = data.Diamond01
	Cards.Add(Diamond01)

	Card Diamond02 = new Card
	Diamond02.Suit = Diamond
	Diamond02.Rank = Two
	Diamond02.Reference = data.Diamond02
	Cards.Add(Diamond02)

	Card Diamond03 = new Card
	Diamond03.Suit = Diamond
	Diamond03.Rank = Three
	Diamond03.Reference = data.Diamond03
	Cards.Add(Diamond03)

	Card Diamond04 = new Card
	Diamond04.Suit = Diamond
	Diamond04.Rank = Four
	Diamond04.Reference = data.Diamond04
	Cards.Add(Diamond04)

	Card Diamond05 = new Card
	Diamond05.Suit = Diamond
	Diamond05.Rank = Five
	Diamond05.Reference = data.Diamond05
	Cards.Add(Diamond05)

	Card Diamond06 = new Card
	Diamond06.Suit = Diamond
	Diamond06.Rank = Six
	Diamond06.Reference = data.Diamond06
	Cards.Add(Diamond06)

	Card Diamond07 = new Card
	Diamond07.Suit = Diamond
	Diamond07.Rank = Seven
	Diamond07.Reference = data.Diamond07
	Cards.Add(Diamond07)

	Card Diamond08 = new Card
	Diamond08.Suit = Diamond
	Diamond08.Rank = Eight
	Diamond08.Reference = data.Diamond08
	Cards.Add(Diamond08)

	Card Diamond09 = new Card
	Diamond09.Suit = Diamond
	Diamond09.Rank = Nine
	Diamond09.Reference = data.Diamond09
	Cards.Add(Diamond09)

	Card Diamond10 = new Card
	Diamond10.Suit = Diamond
	Diamond10.Rank = Ten
	Diamond10.Reference = data.Diamond10
	Cards.Add(Diamond10)

	Card Diamond11 = new Card
	Diamond11.Suit = Diamond
	Diamond11.Rank = Jack
	Diamond11.Reference = data.Diamond11
	Cards.Add(Diamond11)

	Card Diamond12 = new Card
	Diamond12.Suit = Diamond
	Diamond12.Rank = Queen
	Diamond12.Reference = data.Diamond12
	Cards.Add(Diamond12)

	Card Diamond13 = new Card
	Diamond13.Suit = Diamond
	Diamond13.Rank = King
	Diamond13.Reference = data.Diamond13
	Cards.Add(Diamond13)


	Card Club01 = new Card
	Club01.Suit = Club
	Club01.Rank = Ace
	Club01.Reference = data.Club01
	Cards.Add(Club01)

	Card Club02 = new Card
	Club02.Suit = Club
	Club02.Rank = Two
	Club02.Reference = data.Club02
	Cards.Add(Club02)

	Card Club03 = new Card
	Club03.Suit = Club
	Club03.Rank = Three
	Club03.Reference = data.Club03
	Cards.Add(Club03)

	Card Club04 = new Card
	Club04.Suit = Club
	Club04.Rank = Four
	Club04.Reference = data.Club04
	Cards.Add(Club04)

	Card Club05 = new Card
	Club05.Suit = Club
	Club05.Rank = Five
	Club05.Reference = data.Club05
	Cards.Add(Club05)

	Card Club06 = new Card
	Club06.Suit = Club
	Club06.Rank = Six
	Club06.Reference = data.Club06
	Cards.Add(Club06)

	Card Club07 = new Card
	Club07.Suit = Club
	Club07.Rank = Seven
	Club07.Reference = data.Club07
	Cards.Add(Club07)

	Card Club08 = new Card
	Club08.Suit = Club
	Club08.Rank = Eight
	Club08.Reference = data.Club08
	Cards.Add(Club08)

	Card Club09 = new Card
	Club09.Suit = Club
	Club09.Rank = Nine
	Club09.Reference = data.Club09
	Cards.Add(Club09)

	Card Club10 = new Card
	Club10.Suit = Club
	Club10.Rank = Ten
	Club10.Reference = data.Club10
	Cards.Add(Club10)

	Card Club11 = new Card
	Club11.Suit = Club
	Club11.Rank = Jack
	Club11.Reference = data.Club11
	Cards.Add(Club11)

	Card Club12 = new Card
	Club12.Suit = Club
	Club12.Rank = Queen
	Club12.Reference = data.Club12
	Cards.Add(Club12)

	Card Club13 = new Card
	Club13.Suit = Club
	Club13.Rank = King
	Club13.Reference = data.Club13
	Cards.Add(Club13)


	Card Heart01 = new Card
	Heart01.Suit = Heart
	Heart01.Rank = Ace
	Heart01.Reference = data.Heart01
	Cards.Add(Heart01)

	Card Heart02 = new Card
	Heart02.Suit = Heart
	Heart02.Rank = Two
	Heart02.Reference = data.Heart02
	Cards.Add(Heart02)

	Card Heart03 = new Card
	Heart03.Suit = Heart
	Heart03.Rank = Three
	Heart03.Reference = data.Heart03
	Cards.Add(Heart03)

	Card Heart04 = new Card
	Heart04.Suit = Heart
	Heart04.Rank = Four
	Heart04.Reference = data.Heart04
	Cards.Add(Heart04)

	Card Heart05 = new Card
	Heart05.Suit = Heart
	Heart05.Rank = Five
	Heart05.Reference = data.Heart05
	Cards.Add(Heart05)

	Card Heart06 = new Card
	Heart06.Suit = Heart
	Heart06.Rank = Six
	Heart06.Reference = data.Heart06
	Cards.Add(Heart06)

	Card Heart07 = new Card
	Heart07.Suit = Heart
	Heart07.Rank = Seven
	Heart07.Reference = data.Heart07
	Cards.Add(Heart07)

	Card Heart08 = new Card
	Heart08.Suit = Heart
	Heart08.Rank = Eight
	Heart08.Reference = data.Heart08
	Cards.Add(Heart08)

	Card Heart09 = new Card
	Heart09.Suit = Heart
	Heart09.Rank = Nine
	Heart09.Reference = data.Heart09
	Cards.Add(Heart09)

	Card Heart10 = new Card
	Heart10.Suit = Heart
	Heart10.Rank = Ten
	Heart10.Reference = data.Heart10
	Cards.Add(Heart10)

	Card Heart11 = new Card
	Heart11.Suit = Heart
	Heart11.Rank = Jack
	Heart11.Reference = data.Heart11
	Cards.Add(Heart11)

	Card Heart12 = new Card
	Heart12.Suit = Heart
	Heart12.Rank = Queen
	Heart12.Reference = data.Heart12
	Cards.Add(Heart12)

	Card Heart13 = new Card
	Heart13.Suit = Heart
	Heart13.Rank = King
	Heart13.Reference = data.Heart13
	Cards.Add(Heart13)

	return Cards
EndFunction


; Functions
;---------------------------------------------

bool Function IsFaceCard(Card value)
	return value.Rank > Ten
EndFunction


ObjectReference[] Function ToReferences(Deck:Card[] values) Global
	ObjectReference[] array = new ObjectReference[0]
	If (values)
		int index = 0
		While (index < values.Length)
			array.Add(values[index].Reference)
			index += 1
		EndWhile
	EndIf
	return array
EndFunction


; Properties
;---------------------------------------------

Group Properties
	bool Property UseJoker = false Auto
	int Property Invalid = -1 AutoReadOnly
EndGroup

Group Suits
	int Property Club = 0 AutoReadOnly
	int Property Diamond = 1 AutoReadOnly
	int Property Heart = 2 AutoReadOnly
	int Property Spade = 3 AutoReadOnly
EndGroup

Group Ranks
	int Property Joker = 0 AutoReadOnly
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
EndGroup

Struct Card
	int Suit = -1
	int Rank = -1
	bool Drawn = false
	ObjectReference Reference
EndStruct

Struct ReferenceData
	ObjectReference JokerBlack
	ObjectReference JokerRed
	ObjectReference Spade01
	ObjectReference Spade02
	ObjectReference Spade03
	ObjectReference Spade04
	ObjectReference Spade05
	ObjectReference Spade06
	ObjectReference Spade07
	ObjectReference Spade08
	ObjectReference Spade09
	ObjectReference Spade10
	ObjectReference Spade11
	ObjectReference Spade12
	ObjectReference Spade13
	ObjectReference Diamond01
	ObjectReference Diamond02
	ObjectReference Diamond03
	ObjectReference Diamond04
	ObjectReference Diamond05
	ObjectReference Diamond06
	ObjectReference Diamond07
	ObjectReference Diamond08
	ObjectReference Diamond09
	ObjectReference Diamond10
	ObjectReference Diamond11
	ObjectReference Diamond12
	ObjectReference Diamond13
	ObjectReference Club01
	ObjectReference Club02
	ObjectReference Club03
	ObjectReference Club04
	ObjectReference Club05
	ObjectReference Club06
	ObjectReference Club07
	ObjectReference Club08
	ObjectReference Club09
	ObjectReference Club10
	ObjectReference Club11
	ObjectReference Club12
	ObjectReference Club13
	ObjectReference Heart01
	ObjectReference Heart02
	ObjectReference Heart03
	ObjectReference Heart04
	ObjectReference Heart05
	ObjectReference Heart06
	ObjectReference Heart07
	ObjectReference Heart08
	ObjectReference Heart09
	ObjectReference Heart10
	ObjectReference Heart11
	ObjectReference Heart12
	ObjectReference Heart13
EndStruct
