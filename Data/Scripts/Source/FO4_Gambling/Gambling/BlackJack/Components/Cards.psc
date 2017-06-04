ScriptName Gambling:BlackJack:Components:Cards extends Gambling:BlackJack:GameComponent
import Gambling
import Gambling:Shared


; Methods
;---------------------------------------------

Function Allocate()
	Deck.Allocate()
	GoHome()
EndFunction


Function GoHome()
	Deck:Card[] Cards = Deck.GetCards()
	ObjectReference[] array = Gambling:Shared:Deck.GetReferences(Cards)
	Controller.TranslateEach(array, Gambling_Card)
EndFunction


Function Shuffle()
	Deck.Shuffle()
EndFunction


; Properties
;---------------------------------------------

Group Properties
	Shared:Deck Property Deck Auto Const Mandatory
	Motion:Controller Property Controller Auto Const Mandatory
	ObjectReference Property Gambling_Card Auto Const Mandatory
EndGroup
