ScriptName Gambling:BlackJack:Components:Cards extends Gambling:BlackJack:GameComponent
import Gambling
import Gambling:Shared
import Gambling:BlackJack


; Methods
;---------------------------------------------

Function Allocate()
	Deck.Allocate()
	CollectAll()
EndFunction


Function Collect(Players:Player seat)
	ObjectReference[] references = Gambling:Shared:Deck.GetReferences(seat.Hand)
	Controller.TranslateEach(references, Gambling_BlackJack_DeckMarker)
EndFunction


Function CollectAll()
	Deck:Card[] Cards = Deck.GetCards()
	ObjectReference[] references = Gambling:Shared:Deck.GetReferences(Cards)
	Controller.TranslateEach(references, Gambling_BlackJack_DeckMarker)
EndFunction


Function Shuffle()
	Deck.Shuffle()
EndFunction


; Properties
;---------------------------------------------

Group Properties
	Shared:Deck Property Deck Auto Const Mandatory
	Motion:Controller Property Controller Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_DeckMarker Auto Const Mandatory
EndGroup
