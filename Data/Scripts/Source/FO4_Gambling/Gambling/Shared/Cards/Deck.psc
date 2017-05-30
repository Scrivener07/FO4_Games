Scriptname Gambling:Shared:Cards:Deck extends ObjectReference
import Gambling
import Gambling:Common
import Gambling:Shared
import Gambling:Shared:Cards:Deck


Cards:Shoe Owner
Card:Data[] Cards


Group Required
	DeckPreset Property Preset Auto Hidden
	bool Property UseJoker Auto Hidden
EndGroup


; Constructor
;---------------------------------------------

Event OnInit()
	Cards = new Card:Data[0]
	Preset = new DeckPreset
	UseJoker = false
EndEvent


Function Initialize(Cards:Shoe aOwner)
	Owner = aOwner
EndFunction


; Events
;---------------------------------------------

Event Gambling:Shared:Cards:Card.Drawn(Card akSender, var[] arguments)
	WriteLine(self, "Drew card:"+akSender)
EndEvent


; Methods
;---------------------------------------------

Function Allocate()
	Unallocate()

	Create(Spade, Ace, Preset.Spade01, Preset.Plugin)
	Create(Spade, Two, Preset.Spade02, Preset.Plugin)
	Create(Spade, Three, Preset.Spade03, Preset.Plugin)
	Create(Spade, Four, Preset.Spade04, Preset.Plugin)
	Create(Spade, Five, Preset.Spade05, Preset.Plugin)
	Create(Spade, Six, Preset.Spade06, Preset.Plugin)
	Create(Spade, Seven, Preset.Spade07, Preset.Plugin)
	Create(Spade, Eight, Preset.Spade08, Preset.Plugin)
	Create(Spade, Nine, Preset.Spade09, Preset.Plugin)
	Create(Spade, Ten, Preset.Spade10, Preset.Plugin)
	Create(Spade, Jack, Preset.Spade11, Preset.Plugin)
	Create(Spade, Queen, Preset.Spade12, Preset.Plugin)
	Create(Spade, King, Preset.Spade13, Preset.Plugin)
	Create(Diamond, Ace, Preset.Diamond01, Preset.Plugin)
	Create(Diamond, Two, Preset.Diamond02, Preset.Plugin)
	Create(Diamond, Three, Preset.Diamond03, Preset.Plugin)
	Create(Diamond, Four, Preset.Diamond04, Preset.Plugin)
	Create(Diamond, Five, Preset.Diamond05, Preset.Plugin)
	Create(Diamond, Six, Preset.Diamond06, Preset.Plugin)
	Create(Diamond, Seven, Preset.Diamond07, Preset.Plugin)
	Create(Diamond, Eight, Preset.Diamond08, Preset.Plugin)
	Create(Diamond, Nine, Preset.Diamond09, Preset.Plugin)
	Create(Diamond, Ten, Preset.Diamond10, Preset.Plugin)
	Create(Diamond, Jack, Preset.Diamond11, Preset.Plugin)
	Create(Diamond, Queen, Preset.Diamond12, Preset.Plugin)
	Create(Diamond, King, Preset.Diamond13, Preset.Plugin)
	Create(Club, Ace, Preset.Club01, Preset.Plugin)
	Create(Club, Two, Preset.Club02, Preset.Plugin)
	Create(Club, Three, Preset.Club03, Preset.Plugin)
	Create(Club, Four, Preset.Club04, Preset.Plugin)
	Create(Club, Five, Preset.Club05, Preset.Plugin)
	Create(Club, Six, Preset.Club06, Preset.Plugin)
	Create(Club, Seven, Preset.Club07, Preset.Plugin)
	Create(Club, Eight, Preset.Club08, Preset.Plugin)
	Create(Club, Nine, Preset.Club09, Preset.Plugin)
	Create(Club, Ten, Preset.Club10, Preset.Plugin)
	Create(Club, Jack, Preset.Club11, Preset.Plugin)
	Create(Club, Queen, Preset.Club12, Preset.Plugin)
	Create(Club, King, Preset.Club13, Preset.Plugin)
	Create(Heart, Ace, Preset.Heart01, Preset.Plugin)
	Create(Heart, Two, Preset.Heart02, Preset.Plugin)
	Create(Heart, Three, Preset.Heart03, Preset.Plugin)
	Create(Heart, Four, Preset.Heart04, Preset.Plugin)
	Create(Heart, Five, Preset.Heart05, Preset.Plugin)
	Create(Heart, Six, Preset.Heart06, Preset.Plugin)
	Create(Heart, Seven, Preset.Heart07, Preset.Plugin)
	Create(Heart, Eight, Preset.Heart08, Preset.Plugin)
	Create(Heart, Nine, Preset.Heart09, Preset.Plugin)
	Create(Heart, Ten, Preset.Heart10, Preset.Plugin)
	Create(Heart, Jack, Preset.Heart11, Preset.Plugin)
	Create(Heart, Queen, Preset.Heart12, Preset.Plugin)
	Create(Heart, King, Preset.Heart13, Preset.Plugin)

	If (UseJoker)
		Create(Black, Joker, Preset.JokerBlack, Preset.Plugin)
		Create(Red, Joker, Preset.JokerRed, Preset.Plugin)
	EndIf

	WriteLine(self, "Allocated:"+Count)
EndFunction




Function Unallocate()
	{Removes all cards from the deck.}

	; dispose of each created card reference
	int index = 0
	While (index < Count)
		Factory.Dispose(Cards[index].Reference)
		index += 1
	EndWhile

	; clear the structure array
	Cards.Clear()

	WriteLine(self, "Unallocated:"+index)
EndFunction





bool Function Create(int suit, int rank, int formid, string plugin)
	If !(IsCapacity)
		ObjectReference reference = Factory.CreateID(formid, plugin)

		If (reference is Card)
			Card created = reference as Card
			created.Owner = self

			Card:Data data = new Card:Data
			data.Suit = suit
			data.Rank = rank
			data.Drawn = false
			; data.Order = Owner.Shuffler.NextShuffle()
			data.Reference = reference

			created.Initialize(data)
			created.RegisterForCustomEvent(Owner, "ShuffleRequest")
			created.RegisterForCustomEvent(Owner, "DrawRequest")
			self.RegisterForCustomEvent(created, "Drawn")

			Cards.Add(data)
			return true
		Else
			WriteLine(self, "Could not create reference for card.")
			return false
		EndIf
	Else
		WriteLine(self, "Cannot create a card while deck is at capacity.")
		return false
	EndIf
EndFunction






; Properties
;---------------------------------------------

Group Components
	Gambling:ObjectFactory Property Factory Auto Const Mandatory
EndGroup


Group ReadOnly
	int Property Invalid = -1 AutoReadOnly

	int Property Count Hidden
		int Function Get()
			{Gets the number of cards contained in the deck.}
			return Cards.Length
		EndFunction
	EndProperty

	int Property Maximum Hidden
		int Function Get()
			{Gets the maximum number of cards the deck may contain.}
			If (UseJoker)
				return 54
			Else
				return 52
			EndIf
		EndFunction
	EndProperty

	bool Property IsCapacity Hidden
		bool Function Get()
			{Returns true when the deck contains the maximum number of cards.}
			return Count > Maximum
		EndFunction
	EndProperty
EndGroup


Group Suits
	int Property Black = 0 AutoReadOnly
	int Property Red = 1 AutoReadOnly
	int Property Spade = 2 AutoReadOnly
	int Property Diamond = 3 AutoReadOnly
	int Property Club = 4 AutoReadOnly
	int Property Heart = 5 AutoReadOnly
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


Struct DeckPreset
	string Plugin = "Gambling.esp"

	int Deck = 0x00001ED1
	int FaceDown = 0x00001ED4

	int JokerBlack = 0x00002719
	int JokerRed = 0x00002717

	int Spade01 = 0x0000270E
	int Spade02 = 0x000026FC
	int Spade03 = 0x000026FE
	int Spade04 = 0x00002700
	int Spade05 = 0x00002702
	int Spade06 = 0x00002704
	int Spade07 = 0x00002706
	int Spade08 = 0x00002708
	int Spade09 = 0x0000270A
	int Spade10 = 0x0000270C
	int Spade11 = 0x00002710
	int Spade12 = 0x00002712
	int Spade13 = 0x00002715

	int Diamond01 = 0x000026F4
	int Diamond02 = 0x00001EFA
	int Diamond03 = 0x000026E4
	int Diamond04 = 0x000026E6
	int Diamond05 = 0x000026E8
	int Diamond06 = 0x000026EA
	int Diamond07 = 0x000026EC
	int Diamond08 = 0x000026EE
	int Diamond09 = 0x000026F0
	int Diamond10 = 0x000026F2
	int Diamond11 = 0x000026F6
	int Diamond12 = 0x000026F8
	int Diamond13 = 0x000026FA

	int Club01 = 0x00001F9B
	int Club02 = 0x00001ED0
	int Club03 = 0x00001F85
	int Club04 = 0x00001F87
	int Club05 = 0x00001F89
	int Club06 = 0x00001F8F
	int Club07 = 0x00001F91
	int Club08 = 0x00001F8D
	int Club09 = 0x00001F8B
	int Club10 = 0x00001F93
	int Club11 = 0x00001F95
	int Club12 = 0x00001F97
	int Club13 = 0x00001F99

	int Heart01 = 0x00001ED5
	int Heart02 = 0x00001EDF
	int Heart03 = 0x00001EE2
	int Heart04 = 0x00001EE5
	int Heart05 = 0x00001EE8
	int Heart06 = 0x00001EEB
	int Heart07 = 0x00001EEE
	int Heart08 = 0x00001EF1
	int Heart09 = 0x00001EF4
	int Heart10 = 0x00001EF7
	int Heart11 = 0x00001ED9
	int Heart12 = 0x00001ED2
	int Heart13 = 0x00001EDC
EndStruct
