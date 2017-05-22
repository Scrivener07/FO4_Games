ScriptName Gambling:BlackJack:Cards extends Quest
import Gambling
import Gambling:Common
import Gambling:BlackJack

bool once = false


; Methods
;---------------------------------------------

Function Restore()
	Deck.NewCards()

	If (once == false) ; TODO: this whole block, yikes
		once = true
		Gambling:Deck:Card[] Cards = Deck.GetCards()
		ObjectReference[] array = Gambling:Deck.GetReferences(Cards)
		Controller.TranslateEach(array, Gambling_Card)
	Else
		WriteLine(self, "The deck has already been restored.")
	EndIf
EndFunction


Function Shuffle()
	Deck.Shuffle()
EndFunction


Function Position()
	Point origin = ToPoint(Gambling_BlackJack_Origin)
	ObjectReference[] references = Gambling_BlackJack_Origin.GetRefsLinkedToMe()

	int index = 0
	While (index < references.Length)
		ObjectReference reference = references[index]

		Point offset = GetOffset(origin, reference)
		offset = PointMultiply(offset, -1)

		reference.Disable()
		reference.MoveTo(Gambling_BlackJack_Destination)

		Point destination = ToPoint(Gambling_BlackJack_Destination)
		destination = PointAddition(destination, offset)
		SetPoint(reference, destination)

		reference.Enable()

		WriteLine(self, reference + ", Offset:"+PointToString(offset))

		index += 1
	EndWhile
EndFunction



Point Function GetOffset(Point origin, ObjectReference reference)
	Point p = ToPoint(reference)
	p = PointSubtraction(origin, p)
	return p
EndFunction




; Properties
;---------------------------------------------

Group Properties
	Gambling:Deck Property Deck Auto Const Mandatory
	Motion:Controller Property Controller Auto Const Mandatory

	ObjectReference Property Gambling_BlackJack_Origin Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Destination Auto Const Mandatory
	ObjectReference Property Gambling_Card Auto Const Mandatory
EndGroup
