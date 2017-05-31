ScriptName Gambling:BlackJack:Cards extends Quest
import Gambling
import Gambling:BlackJack
import Gambling:Common
import Gambling:Shared

bool once = false


; Methods
;---------------------------------------------

Function Restore()
	Deck.NewCards()

	If (once == false) ; TODO: this whole block, yikes
		once = true
		Deck:Card[] Cards = Deck.GetCards()
		ObjectReference[] array = Gambling:Shared:Deck.GetReferences(Cards)
		Controller.TranslateEach(array, Gambling_Card)
	Else
		WriteLine(self, "The deck has already been restored.")
	EndIf
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
