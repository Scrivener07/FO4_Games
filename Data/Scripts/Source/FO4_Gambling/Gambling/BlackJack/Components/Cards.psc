ScriptName Gambling:BlackJack:Components:Cards extends Gambling:BlackJack:Component
import Gambling
import Gambling:BlackJack
import Gambling:Shared
import Gambling:Shared:Common
import Gambling:Shared:Deck


ObjectReference[] References
ReferenceData Data


; Events
;---------------------------------------------

Event OnInit()
	Data = new ReferenceData
	Data.JokerBlack = Gambling_BlackJack_JokerBlack
	Data.JokerRed = Gambling_BlackJack_JokerRed
	Data.Spade01 = Gambling_BlackJack_SpadeAce
	Data.Spade02 = Gambling_BlackJack_Spade02
	Data.Spade03 = Gambling_BlackJack_Spade03
	Data.Spade04 = Gambling_BlackJack_Spade04
	Data.Spade05 = Gambling_BlackJack_Spade05
	Data.Spade06 = Gambling_BlackJack_Spade06
	Data.Spade07 = Gambling_BlackJack_Spade07
	Data.Spade08 = Gambling_BlackJack_Spade08
	Data.Spade09 = Gambling_BlackJack_Spade09
	Data.Spade10 = Gambling_BlackJack_Spade10
	Data.Spade11 = Gambling_BlackJack_SpadeJack
	Data.Spade12 = Gambling_BlackJack_SpadeQueen
	Data.Spade13 = Gambling_BlackJack_SpadeKing
	Data.Diamond01 = Gambling_BlackJack_DiamondAce
	Data.Diamond02 = Gambling_BlackJack_Diamond02
	Data.Diamond03 = Gambling_BlackJack_Diamond03
	Data.Diamond04 = Gambling_BlackJack_Diamond04
	Data.Diamond05 = Gambling_BlackJack_Diamond05
	Data.Diamond06 = Gambling_BlackJack_Diamond06
	Data.Diamond07 = Gambling_BlackJack_Diamond07
	Data.Diamond08 = Gambling_BlackJack_Diamond08
	Data.Diamond09 = Gambling_BlackJack_Diamond09
	Data.Diamond10 = Gambling_BlackJack_Diamond10
	Data.Diamond11 = Gambling_BlackJack_DiamondJack
	Data.Diamond12 = Gambling_BlackJack_DiamondQueen
	Data.Diamond13 = Gambling_BlackJack_DiamondKing
	Data.Club01 = Gambling_BlackJack_ClubAce
	Data.Club02 = Gambling_BlackJack_Club02
	Data.Club03 = Gambling_BlackJack_Club03
	Data.Club04 = Gambling_BlackJack_Club04
	Data.Club05 = Gambling_BlackJack_Club05
	Data.Club06 = Gambling_BlackJack_Club06
	Data.Club07 = Gambling_BlackJack_Club07
	Data.Club08 = Gambling_BlackJack_Club08
	Data.Club09 = Gambling_BlackJack_Club09
	Data.Club10 = Gambling_BlackJack_Club10
	Data.Club11 = Gambling_BlackJack_ClubJack
	Data.Club12 = Gambling_BlackJack_ClubQueen
	Data.Club13 = Gambling_BlackJack_ClubKing
	Data.Heart01 = Gambling_BlackJack_HeartAce
	Data.Heart02 = Gambling_BlackJack_Heart02
	Data.Heart03 = Gambling_BlackJack_Heart03
	Data.Heart04 = Gambling_BlackJack_Heart04
	Data.Heart05 = Gambling_BlackJack_Heart05
	Data.Heart06 = Gambling_BlackJack_Heart06
	Data.Heart07 = Gambling_BlackJack_Heart07
	Data.Heart08 = Gambling_BlackJack_Heart08
	Data.Heart09 = Gambling_BlackJack_Heart09
	Data.Heart10 = Gambling_BlackJack_Heart10
	Data.Heart11 = Gambling_BlackJack_HeartJack
	Data.Heart12 = Gambling_BlackJack_HeartQueen
	Data.Heart13 = Gambling_BlackJack_HeartKing
	Deck:Card[] cards = Deck.SetData(Data)
	References = ToReferences(cards)
EndEvent


; Component
;---------------------------------------------

State Starting
	Event OnBeginState(string asOldState)
		CollectAll(true)
		ReleaseThread()
	EndEvent
EndState


; Methods
;---------------------------------------------

Function Shuffle()
	Deck.Shuffle()
EndFunction


Card Function Draw()
	return Deck.Draw()
EndFunction


Function Collect(Card aCard)
	Deck.Collect(aCard)
EndFunction


Function CollectEach(Card[] aCards)
	If (aCards)
		int index = 0
		While (index < aCards.Length)
			Collect(aCards[index])
			index += 1
		EndWhile
	Else
		WriteLine(self, "Cannot collect none or empty cards.")
	EndIf
EndFunction


Function CollectFrom(Player gambler, Controllers:Motion aMotion)
	If (gambler)
		CollectEach(gambler.Hand)
		aMotion.TranslateEach(ToReferences(gambler.Hand), Gambling_BlackJack_DeckMarker)
	Else
		WriteLine(self, "Cannot collect cards from a none player.")
	EndIf
EndFunction


Function CollectAll(bool aForce = false)
	If (References)
		If (aForce)
			int index = 0
			While (index < References.Length)
				References[index].MoveTo(Gambling_BlackJack_DeckMarker)
				index += 1
			EndWhile
		Else
			Motion.TranslateEach(References, Gambling_BlackJack_DeckMarker)
		EndIf
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Object
	BlackJack:Game Property BlackJack Auto Const Mandatory
	Shared:Deck Property Deck Auto Const Mandatory
	Controllers:Motion Property Motion Auto Const Mandatory
EndGroup

Group Markers
	ObjectReference Property Gambling_BlackJack_DeckMarker Auto Const Mandatory
EndGroup

Group References
	ObjectReference Property Gambling_BlackJack_JokerBlack Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_JokerRed Auto Const Mandatory

	ObjectReference Property Gambling_BlackJack_SpadeAce Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Spade02 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Spade03 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Spade04 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Spade05 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Spade06 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Spade07 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Spade08 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Spade09 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Spade10 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_SpadeJack Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_SpadeQueen Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_SpadeKing Auto Const Mandatory

	ObjectReference Property Gambling_BlackJack_DiamondAce Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Diamond02 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Diamond03 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Diamond04 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Diamond05 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Diamond06 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Diamond07 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Diamond08 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Diamond09 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Diamond10 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_DiamondJack Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_DiamondQueen Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_DiamondKing Auto Const Mandatory

	ObjectReference Property Gambling_BlackJack_ClubAce Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Club02 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Club03 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Club04 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Club05 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Club06 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Club07 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Club08 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Club09 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Club10 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_ClubJack Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_ClubQueen Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_ClubKing Auto Const Mandatory

	ObjectReference Property Gambling_BlackJack_HeartAce Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Heart02 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Heart03 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Heart04 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Heart05 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Heart06 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Heart07 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Heart08 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Heart09 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_Heart10 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_HeartJack Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_HeartQueen Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_HeartKing Auto Const Mandatory
EndGroup
