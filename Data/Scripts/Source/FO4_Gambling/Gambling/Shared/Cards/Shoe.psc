Scriptname Gambling:Shared:Cards:Shoe extends Quest
import Gambling
import Gambling:Common
import Gambling:Context
import Gambling:Shared
import Gambling:Shared:Cards:Deck


Actor Player
ActorValue ActorLuck

; Shoe Settings
bool UseJoker
DeckPreset Preset
ObjectReference Visual

; Shoe Components
Cards:Deck[] Decks

Cards:Shuffler CardsShuffler


CustomEvent DrawRequest
CustomEvent ShuffleRequest


; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
	ActorLuck = Game.GetLuckAV()

	Decks = new Cards:Deck[0]
	Preset = new DeckPreset
	UseJoker = false

	CardsShuffler = Factory.NewShuffler(self)

	WriteLine(self, "Initialized")
EndEvent


; Methods
;---------------------------------------------

Function Allocate()
	WriteLine(self, "Allocate")
	Unallocate()

	; create shoe visual
	Visual = Factory.CreateID(Preset.Deck, Preset.Plugin)


	If (true) ; add a deck for each level of difficulty
		int Difficultly = GetDifficultly()
		int index = 0
		While (index < Difficultly)
			Cards:Deck newDeck = Factory.NewDeck(self)
			newDeck.Preset = Preset
			newDeck.UseJoker = UseJoker
			Decks.Add(newDeck)
			index += 1
		EndWhile
	EndIf


	If (true) ; allocate each deck
		int index = 0
		While (index < Decks.Length)
			Decks[index].Allocate()
			index += 1
		EndWhile
	EndIf


	CardsShuffler.Calculate()
EndFunction



Function Unallocate()
	Factory.Dispose(Visual)

	int index = 0
	While (index < Decks.Length)
		Decks[index].Unallocate()
		index += 1
	EndWhile
	Decks.Clear()

	WriteLine(self, "Unallocated:"+index)
EndFunction





bool Function Shuffle()
	{Shuffles all cards belonging to this collection}
	CardsShuffler.Calculate()
	SendCustomEvent("ShuffleRequest")
EndFunction



Function Draw()
	{Returns the next undrawn card from the top of the deck.}

	int iNext = CardsShuffler.NextDraw()
	var[] arguments = new var[1]
	arguments[0] = iNext

	WriteLine(self, "Requested a draw event. Order:"+iNext)
	SendCustomEvent("DrawRequest", arguments)
EndFunction




; Functions
;---------------------------------------------

int Function GetDifficultly()
	int luck = Player.GetValue(ActorLuck) as int
	int value = (10 - luck) + 1
	WriteLine(self, "GetDifficultly:"+value)
	return value
EndFunction


int Function GetCount()
	int value = 0
	int index = 0
	While (index < Decks.Length)
		value += Decks[index].Count
		index += 1
	EndWhile
	return value
EndFunction


; Properties
;---------------------------------------------

Group Components
	Gambling:ObjectFactory Property Factory Auto Const Mandatory
EndGroup


Cards:Shuffler Property Shuffler Hidden
	Cards:Shuffler Function Get()
		return CardsShuffler
	EndFunction
EndProperty
