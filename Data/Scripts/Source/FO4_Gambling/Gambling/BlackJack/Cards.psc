ScriptName Gambling:BlackJack:Cards extends Quest
import Gambling
import Gambling:BlackJack
import Gambling:Common
import Gambling:Shared


bool Once = false


; Methods
;---------------------------------------------

Function Restore()
	Deck.NewCards()

	If (Once == false) ; TODO: this whole block, yikes
		Once = true
		CardDeck:Card[] cards = Deck.GetCards()
		ObjectReference[] references = Gambling:Shared:CardDeck.GetReferences(cards)
		Controller.TranslateEach(references, Gambling_Card)
	Else
		WriteLine(self, "The deck has already been restored.")
	EndIf
EndFunction


Function Shuffle()
	Deck.Shuffle()
EndFunction


CardDeck:Card Function Draw()
	return Deck.Draw()
EndFunction


Function Position(ObjectReference tableReference)
	ObjectReference[] references = Gambling_BlackJack_Origin.GetRefsLinkedToMe()

	int index = 0
	While (index < references.Length)
		ObjectReference reference = references[index]

		Point offset = GetOffset(Gambling_BlackJack_Origin, reference)
		offset = PointMultiply(offset, -1)

		reference.Disable()
		reference.MoveTo(tableReference)

		Point destination = ToPoint(tableReference)
		destination = PointAddition(destination, offset)
		SetPoint(reference, destination)

		reference.Enable()
		WriteLine(self, reference + ", Offset:"+PointToString(offset))
		index += 1
	EndWhile
EndFunction


Point Function GetOffset(ObjectReference origin, ObjectReference reference) Global
	Point pOrigin = ToPoint(origin)
	Point pReference = ToPoint(reference)
	pReference = PointSubtraction(pOrigin, pReference)
	return pReference
EndFunction


; Properties
;---------------------------------------------

Group Properties
	CardDeck Property Deck Auto Const Mandatory
	Motion:Controller Property Controller Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Origin Auto Const Mandatory
	ObjectReference Property Gambling_Card Auto Const Mandatory
EndGroup
