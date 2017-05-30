ScriptName Gambling:Shared:CardDeck extends Activator
import Gambling:Common
import Gambling:Shared


CardDeck:Card[] Cards


Struct Card
	int Suit = -1
	int Rank = -1
	bool Drawn = false
	ObjectReference Reference
EndStruct

Group Properties
	bool Property UseJoker = false Auto
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


; Methods
;---------------------------------------------

CardDeck:Card Function Draw()
	{Returns the next undrawn card from the deck.}
	int index = 0
	While (index < Cards.Length)
		index = Cards.FindStruct("Drawn", false, index)
		If (index > -1)
			CardDeck:Card element = Cards[index]
			element.Drawn = true
			WriteLine(self, "Drawing the '"+element.Rank+"' card from the deck.")
			return element
		Else
			WriteLine(self, "No available card to draw was found.")
			return none
		EndIf
		index += 1
	EndWhile
EndFunction


bool Function Shuffle()
	If (Cards)
		int count = Cards.Length
		int index = 0

		While (index < count)
			int random = index + Utility.RandomInt() % (count - index)
			CardDeck:Card temp = Cards[index]
			Cards[index] = Cards[random]
			Cards[random] = temp
			index += 1
		EndWhile

		WriteLine(self, "The deck has been shuffled.")
		return true
	Else
		WriteLine(self, "Cannot shuffle a none deck.")
		return false
	EndIf
EndFunction


; Functions
;---------------------------------------------

bool Function IsFaceCard(CardDeck:Card aCard)
	return aCard.Rank > Ten
EndFunction


CardDeck:Card[] Function GetCards()
	CardDeck:Card[] array = new CardDeck:Card[0]
	int index = 0
	While (index < Cards.Length)
		array.Add(Cards[index])
		index += 1
	EndWhile
	return array
EndFunction


ObjectReference[] Function GetReferences(CardDeck:Card[] aCards) Global
	ObjectReference[] array = new ObjectReference[0]
	If (aCards)
		int index = 0
		While (index < aCards.Length)
			array.Add(aCards[index].Reference)
			index += 1
		EndWhile
	EndIf
	return array
EndFunction


Function NewCards()
	WriteLine(self, "Replacing the Cards in the deck with new ones.")
	Cards = Create(UseJoker)
EndFunction


CardDeck:Card[] Function Create(bool aUseJoker = false)
	CardDeck:Card[] array = new CardDeck:Card[0]

	CardDeck:Card Club01 = new CardDeck:Card
	Club01.Suit = Club
	Club01.Rank = Ace
	Club01.Reference = Gambling_ClubAce
	array.Add(Club01)

	CardDeck:Card Club02 = new CardDeck:Card
	Club02.Suit = Club
	Club02.Rank = Two
	Club02.Reference = Gambling_Club02
	array.Add(Club02)

	CardDeck:Card Club03 = new CardDeck:Card
	Club03.Suit = Club
	Club03.Rank = Three
	Club03.Reference = Gambling_Club03
	array.Add(Club03)

	CardDeck:Card Club04 = new CardDeck:Card
	Club04.Suit = Club
	Club04.Rank = Four
	Club04.Reference = Gambling_Club04
	array.Add(Club04)

	CardDeck:Card Club05 = new CardDeck:Card
	Club05.Suit = Club
	Club05.Rank = Five
	Club05.Reference = Gambling_Club05
	array.Add(Club05)

	CardDeck:Card Club06 = new CardDeck:Card
	Club06.Suit = Club
	Club06.Rank = Six
	Club06.Reference = Gambling_Club06
	array.Add(Club06)

	CardDeck:Card Club07 = new CardDeck:Card
	Club07.Suit = Club
	Club07.Rank = Seven
	Club07.Reference = Gambling_Club07
	array.Add(Club07)

	CardDeck:Card Club08 = new CardDeck:Card
	Club08.Suit = Club
	Club08.Rank = Eight
	Club08.Reference = Gambling_Club08
	array.Add(Club08)

	CardDeck:Card Club09 = new CardDeck:Card
	Club09.Suit = Club
	Club09.Rank = Nine
	Club09.Reference = Gambling_Club09
	array.Add(Club09)

	CardDeck:Card Club10 = new CardDeck:Card
	Club10.Suit = Club
	Club10.Rank = Ten
	Club10.Reference = Gambling_Club10
	array.Add(Club10)

	CardDeck:Card Club11 = new CardDeck:Card
	Club11.Suit = Club
	Club11.Rank = Jack
	Club11.Reference = Gambling_ClubJack
	array.Add(Club11)

	CardDeck:Card Club12 = new CardDeck:Card
	Club12.Suit = Club
	Club12.Rank = Queen
	Club12.Reference = Gambling_ClubQueen
	array.Add(Club12)

	CardDeck:Card Club13 = new CardDeck:Card
	Club13.Suit = Club
	Club13.Rank = King
	Club13.Reference = Gambling_ClubKing
	array.Add(Club13)

	CardDeck:Card Diamond01 = new CardDeck:Card
	Diamond01.Suit = Diamond
	Diamond01.Rank = Ace
	Diamond01.Reference = Gambling_DiamondAce
	array.Add(Diamond01)

	CardDeck:Card Diamond02 = new CardDeck:Card
	Diamond02.Suit = Diamond
	Diamond02.Rank = Two
	Diamond02.Reference = Gambling_Diamond02
	array.Add(Diamond02)

	CardDeck:Card Diamond03 = new CardDeck:Card
	Diamond03.Suit = Diamond
	Diamond03.Rank = Three
	Diamond03.Reference = Gambling_Diamond03
	array.Add(Diamond03)

	CardDeck:Card Diamond04 = new CardDeck:Card
	Diamond04.Suit = Diamond
	Diamond04.Rank = Four
	Diamond04.Reference = Gambling_Diamond04
	array.Add(Diamond04)

	CardDeck:Card Diamond05 = new CardDeck:Card
	Diamond05.Suit = Diamond
	Diamond05.Rank = Five
	Diamond05.Reference = Gambling_Diamond05
	array.Add(Diamond05)

	CardDeck:Card Diamond06 = new CardDeck:Card
	Diamond06.Suit = Diamond
	Diamond06.Rank = Six
	Diamond06.Reference = Gambling_Diamond06
	array.Add(Diamond06)

	CardDeck:Card Diamond07 = new CardDeck:Card
	Diamond07.Suit = Diamond
	Diamond07.Rank = Seven
	Diamond07.Reference = Gambling_Diamond07
	array.Add(Diamond07)

	CardDeck:Card Diamond08 = new CardDeck:Card
	Diamond08.Suit = Diamond
	Diamond08.Rank = Eight
	Diamond08.Reference = Gambling_Diamond08
	array.Add(Diamond08)

	CardDeck:Card Diamond09 = new CardDeck:Card
	Diamond09.Suit = Diamond
	Diamond09.Rank = Nine
	Diamond09.Reference = Gambling_Diamond09
	array.Add(Diamond09)

	CardDeck:Card Diamond10 = new CardDeck:Card
	Diamond10.Suit = Diamond
	Diamond10.Rank = Ten
	Diamond10.Reference = Gambling_Diamond10
	array.Add(Diamond10)

	CardDeck:Card Diamond11 = new CardDeck:Card
	Diamond11.Suit = Diamond
	Diamond11.Rank = Jack
	Diamond11.Reference = Gambling_DiamondJack
	array.Add(Diamond11)

	CardDeck:Card Diamond12 = new CardDeck:Card
	Diamond12.Suit = Diamond
	Diamond12.Rank = Queen
	Diamond12.Reference = Gambling_DiamondQueen
	array.Add(Diamond12)

	CardDeck:Card Diamond13 = new CardDeck:Card
	Diamond13.Suit = Diamond
	Diamond13.Rank = King
	Diamond13.Reference = Gambling_DiamondKing
	array.Add(Diamond13)

	CardDeck:Card Heart01 = new CardDeck:Card
	Heart01.Suit = Heart
	Heart01.Rank = Ace
	Heart01.Reference = Gambling_HeartAce
	array.Add(Heart01)

	CardDeck:Card Heart02 = new CardDeck:Card
	Heart02.Suit = Heart
	Heart02.Rank = Two
	Heart02.Reference = Gambling_Heart02
	array.Add(Heart02)

	CardDeck:Card Heart03 = new CardDeck:Card
	Heart03.Suit = Heart
	Heart03.Rank = Three
	Heart03.Reference = Gambling_Heart03
	array.Add(Heart03)

	CardDeck:Card Heart04 = new CardDeck:Card
	Heart04.Suit = Heart
	Heart04.Rank = Four
	Heart04.Reference = Gambling_Heart04
	array.Add(Heart04)

	CardDeck:Card Heart05 = new CardDeck:Card
	Heart05.Suit = Heart
	Heart05.Rank = Five
	Heart05.Reference = Gambling_Heart05
	array.Add(Heart05)

	CardDeck:Card Heart06 = new CardDeck:Card
	Heart06.Suit = Heart
	Heart06.Rank = Six
	Heart06.Reference = Gambling_Heart06
	array.Add(Heart06)

	CardDeck:Card Heart07 = new CardDeck:Card
	Heart07.Suit = Heart
	Heart07.Rank = Seven
	Heart07.Reference = Gambling_Heart07
	array.Add(Heart07)

	CardDeck:Card Heart08 = new CardDeck:Card
	Heart08.Suit = Heart
	Heart08.Rank = Eight
	Heart08.Reference = Gambling_Heart08
	array.Add(Heart08)

	CardDeck:Card Heart09 = new CardDeck:Card
	Heart09.Suit = Heart
	Heart09.Rank = Nine
	Heart09.Reference = Gambling_Heart09
	array.Add(Heart09)

	CardDeck:Card Heart10 = new CardDeck:Card
	Heart10.Suit = Heart
	Heart10.Rank = Ten
	Heart10.Reference = Gambling_Heart10
	array.Add(Heart10)

	CardDeck:Card Heart11 = new CardDeck:Card
	Heart11.Suit = Heart
	Heart11.Rank = Jack
	Heart11.Reference = Gambling_HeartJack
	array.Add(Heart11)

	CardDeck:Card Heart12 = new CardDeck:Card
	Heart12.Suit = Heart
	Heart12.Rank = Queen
	Heart12.Reference = Gambling_HeartQueen
	array.Add(Heart12)

	CardDeck:Card Heart13 = new CardDeck:Card
	Heart13.Suit = Heart
	Heart13.Rank = King
	Heart13.Reference = Gambling_HeartKing
	array.Add(Heart13)

	CardDeck:Card Spade01 = new CardDeck:Card
	Spade01.Suit = Spade
	Spade01.Rank = Ace
	Spade01.Reference = Gambling_SpadeAce
	array.Add(Spade01)

	CardDeck:Card Spade02 = new CardDeck:Card
	Spade02.Suit = Spade
	Spade02.Rank = Two
	Spade02.Reference = Gambling_Spade02
	array.Add(Spade02)

	CardDeck:Card Spade03 = new CardDeck:Card
	Spade03.Suit = Spade
	Spade03.Rank = Three
	Spade03.Reference = Gambling_Spade03
	array.Add(Spade03)

	CardDeck:Card Spade04 = new CardDeck:Card
	Spade04.Suit = Spade
	Spade04.Rank = Four
	Spade04.Reference = Gambling_Spade04
	array.Add(Spade04)

	CardDeck:Card Spade05 = new CardDeck:Card
	Spade05.Suit = Spade
	Spade05.Rank = Five
	Spade05.Reference = Gambling_Spade05
	array.Add(Spade05)

	CardDeck:Card Spade06 = new CardDeck:Card
	Spade06.Suit = Spade
	Spade06.Rank = Six
	Spade06.Reference = Gambling_Spade06
	array.Add(Spade06)

	CardDeck:Card Spade07 = new CardDeck:Card
	Spade07.Suit = Spade
	Spade07.Rank = Seven
	Spade07.Reference = Gambling_Spade07
	array.Add(Spade07)

	CardDeck:Card Spade08 = new CardDeck:Card
	Spade08.Suit = Spade
	Spade08.Rank = Eight
	Spade08.Reference = Gambling_Spade08
	array.Add(Spade08)

	CardDeck:Card Spade09 = new CardDeck:Card
	Spade09.Suit = Spade
	Spade09.Rank = Nine
	Spade09.Reference = Gambling_Spade09
	array.Add(Spade09)

	CardDeck:Card Spade10 = new CardDeck:Card
	Spade10.Suit = Spade
	Spade10.Rank = Ten
	Spade10.Reference = Gambling_Spade10
	array.Add(Spade10)

	CardDeck:Card Spade11 = new CardDeck:Card
	Spade11.Suit = Spade
	Spade11.Rank = Jack
	Spade11.Reference = Gambling_SpadeJack
	array.Add(Spade11)

	CardDeck:Card Spade12 = new CardDeck:Card
	Spade12.Suit = Spade
	Spade12.Rank = Queen
	Spade12.Reference = Gambling_SpadeQueen
	array.Add(Spade12)

	CardDeck:Card Spade13 = new CardDeck:Card
	Spade13.Suit = Spade
	Spade13.Rank = King
	Spade13.Reference = Gambling_SpadeKing
	array.Add(Spade13)

	If (aUseJoker)
		CardDeck:Card Joker01 = new CardDeck:Card
		Joker01.Suit = -1
		Joker01.Rank = Joker
		Joker01.Reference = Gambling_JokerBlack
		array.Add(Joker01)

		CardDeck:Card Joker02 = new CardDeck:Card
		Joker02.Suit = -1
		Joker02.Rank = Joker
		Joker02.Reference = Gambling_JokerRed
		array.Add(Joker02)
	EndIf

	return array
EndFunction


; Properties
;---------------------------------------------

Group References
	ObjectReference Property Gambling_JokerBlack Auto Const Mandatory
	ObjectReference Property Gambling_JokerRed Auto Const Mandatory

	ObjectReference Property Gambling_SpadeAce Auto Const Mandatory
	ObjectReference Property Gambling_Spade02 Auto Const Mandatory
	ObjectReference Property Gambling_Spade03 Auto Const Mandatory
	ObjectReference Property Gambling_Spade04 Auto Const Mandatory
	ObjectReference Property Gambling_Spade05 Auto Const Mandatory
	ObjectReference Property Gambling_Spade06 Auto Const Mandatory
	ObjectReference Property Gambling_Spade07 Auto Const Mandatory
	ObjectReference Property Gambling_Spade08 Auto Const Mandatory
	ObjectReference Property Gambling_Spade09 Auto Const Mandatory
	ObjectReference Property Gambling_Spade10 Auto Const Mandatory
	ObjectReference Property Gambling_SpadeJack Auto Const Mandatory
	ObjectReference Property Gambling_SpadeQueen Auto Const Mandatory
	ObjectReference Property Gambling_SpadeKing Auto Const Mandatory

	ObjectReference Property Gambling_DiamondAce Auto Const Mandatory
	ObjectReference Property Gambling_Diamond02 Auto Const Mandatory
	ObjectReference Property Gambling_Diamond03 Auto Const Mandatory
	ObjectReference Property Gambling_Diamond04 Auto Const Mandatory
	ObjectReference Property Gambling_Diamond05 Auto Const Mandatory
	ObjectReference Property Gambling_Diamond06 Auto Const Mandatory
	ObjectReference Property Gambling_Diamond07 Auto Const Mandatory
	ObjectReference Property Gambling_Diamond08 Auto Const Mandatory
	ObjectReference Property Gambling_Diamond09 Auto Const Mandatory
	ObjectReference Property Gambling_Diamond10 Auto Const Mandatory
	ObjectReference Property Gambling_DiamondJack Auto Const Mandatory
	ObjectReference Property Gambling_DiamondQueen Auto Const Mandatory
	ObjectReference Property Gambling_DiamondKing Auto Const Mandatory

	ObjectReference Property Gambling_ClubAce Auto Const Mandatory
	ObjectReference Property Gambling_Club02 Auto Const Mandatory
	ObjectReference Property Gambling_Club03 Auto Const Mandatory
	ObjectReference Property Gambling_Club04 Auto Const Mandatory
	ObjectReference Property Gambling_Club05 Auto Const Mandatory
	ObjectReference Property Gambling_Club06 Auto Const Mandatory
	ObjectReference Property Gambling_Club07 Auto Const Mandatory
	ObjectReference Property Gambling_Club08 Auto Const Mandatory
	ObjectReference Property Gambling_Club09 Auto Const Mandatory
	ObjectReference Property Gambling_Club10 Auto Const Mandatory
	ObjectReference Property Gambling_ClubJack Auto Const Mandatory
	ObjectReference Property Gambling_ClubQueen Auto Const Mandatory
	ObjectReference Property Gambling_ClubKing Auto Const Mandatory

	ObjectReference Property Gambling_HeartAce Auto Const Mandatory
	ObjectReference Property Gambling_Heart02 Auto Const Mandatory
	ObjectReference Property Gambling_Heart03 Auto Const Mandatory
	ObjectReference Property Gambling_Heart04 Auto Const Mandatory
	ObjectReference Property Gambling_Heart05 Auto Const Mandatory
	ObjectReference Property Gambling_Heart06 Auto Const Mandatory
	ObjectReference Property Gambling_Heart07 Auto Const Mandatory
	ObjectReference Property Gambling_Heart08 Auto Const Mandatory
	ObjectReference Property Gambling_Heart09 Auto Const Mandatory
	ObjectReference Property Gambling_Heart10 Auto Const Mandatory
	ObjectReference Property Gambling_HeartJack Auto Const Mandatory
	ObjectReference Property Gambling_HeartQueen Auto Const Mandatory
	ObjectReference Property Gambling_HeartKing Auto Const Mandatory
EndGroup
