ScriptName Gambling:Blackjack:Components:Cards extends Gambling:Blackjack:Component
import Gambling
import Gambling:Blackjack
import Gambling:Shared
import Gambling:Shared:Common
import Gambling:Shared:Deck


ObjectReference[] References
ReferenceData Data


; Events
;---------------------------------------------

Event OnInit()
	Data = new ReferenceData
	Data.JokerBlack = Gambling_Blackjack_JokerBlack
	Data.JokerRed = Gambling_Blackjack_JokerRed
	Data.Spade01 = Gambling_Blackjack_SpadeAce
	Data.Spade02 = Gambling_Blackjack_Spade02
	Data.Spade03 = Gambling_Blackjack_Spade03
	Data.Spade04 = Gambling_Blackjack_Spade04
	Data.Spade05 = Gambling_Blackjack_Spade05
	Data.Spade06 = Gambling_Blackjack_Spade06
	Data.Spade07 = Gambling_Blackjack_Spade07
	Data.Spade08 = Gambling_Blackjack_Spade08
	Data.Spade09 = Gambling_Blackjack_Spade09
	Data.Spade10 = Gambling_Blackjack_Spade10
	Data.Spade11 = Gambling_Blackjack_SpadeJack
	Data.Spade12 = Gambling_Blackjack_SpadeQueen
	Data.Spade13 = Gambling_Blackjack_SpadeKing
	Data.Diamond01 = Gambling_Blackjack_DiamondAce
	Data.Diamond02 = Gambling_Blackjack_Diamond02
	Data.Diamond03 = Gambling_Blackjack_Diamond03
	Data.Diamond04 = Gambling_Blackjack_Diamond04
	Data.Diamond05 = Gambling_Blackjack_Diamond05
	Data.Diamond06 = Gambling_Blackjack_Diamond06
	Data.Diamond07 = Gambling_Blackjack_Diamond07
	Data.Diamond08 = Gambling_Blackjack_Diamond08
	Data.Diamond09 = Gambling_Blackjack_Diamond09
	Data.Diamond10 = Gambling_Blackjack_Diamond10
	Data.Diamond11 = Gambling_Blackjack_DiamondJack
	Data.Diamond12 = Gambling_Blackjack_DiamondQueen
	Data.Diamond13 = Gambling_Blackjack_DiamondKing
	Data.Club01 = Gambling_Blackjack_ClubAce
	Data.Club02 = Gambling_Blackjack_Club02
	Data.Club03 = Gambling_Blackjack_Club03
	Data.Club04 = Gambling_Blackjack_Club04
	Data.Club05 = Gambling_Blackjack_Club05
	Data.Club06 = Gambling_Blackjack_Club06
	Data.Club07 = Gambling_Blackjack_Club07
	Data.Club08 = Gambling_Blackjack_Club08
	Data.Club09 = Gambling_Blackjack_Club09
	Data.Club10 = Gambling_Blackjack_Club10
	Data.Club11 = Gambling_Blackjack_ClubJack
	Data.Club12 = Gambling_Blackjack_ClubQueen
	Data.Club13 = Gambling_Blackjack_ClubKing
	Data.Heart01 = Gambling_Blackjack_HeartAce
	Data.Heart02 = Gambling_Blackjack_Heart02
	Data.Heart03 = Gambling_Blackjack_Heart03
	Data.Heart04 = Gambling_Blackjack_Heart04
	Data.Heart05 = Gambling_Blackjack_Heart05
	Data.Heart06 = Gambling_Blackjack_Heart06
	Data.Heart07 = Gambling_Blackjack_Heart07
	Data.Heart08 = Gambling_Blackjack_Heart08
	Data.Heart09 = Gambling_Blackjack_Heart09
	Data.Heart10 = Gambling_Blackjack_Heart10
	Data.Heart11 = Gambling_Blackjack_HeartJack
	Data.Heart12 = Gambling_Blackjack_HeartQueen
	Data.Heart13 = Gambling_Blackjack_HeartKing
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


Function CollectFrom(Player gambler)
	If (gambler)
		CollectEach(gambler.Hand)
		gambler.Motion.TranslateEach(ToReferences(gambler.Hand), Gambling_Blackjack_DeckMarker)
	Else
		WriteLine(self, "Cannot collect cards from a none player.")
	EndIf
EndFunction


Function CollectAll(bool aForce = false)
	If (References)
		If (aForce)
			int index = 0
			While (index < References.Length)
				References[index].MoveTo(Gambling_Blackjack_DeckMarker)
				index += 1
			EndWhile
		Else
			Motion.TranslateEach(References, Gambling_Blackjack_DeckMarker)
		EndIf
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Object
	Blackjack:Game Property Blackjack Auto Const Mandatory
	Shared:Deck Property Deck Auto Const Mandatory
	Controllers:Motion Property Motion Auto Const Mandatory
EndGroup

Group Markers
	ObjectReference Property Gambling_Blackjack_DeckMarker Auto Const Mandatory
EndGroup

Group References
	ObjectReference Property Gambling_Blackjack_JokerBlack Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_JokerRed Auto Const Mandatory

	ObjectReference Property Gambling_Blackjack_SpadeAce Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Spade02 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Spade03 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Spade04 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Spade05 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Spade06 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Spade07 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Spade08 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Spade09 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Spade10 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_SpadeJack Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_SpadeQueen Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_SpadeKing Auto Const Mandatory

	ObjectReference Property Gambling_Blackjack_DiamondAce Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Diamond02 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Diamond03 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Diamond04 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Diamond05 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Diamond06 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Diamond07 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Diamond08 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Diamond09 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Diamond10 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_DiamondJack Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_DiamondQueen Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_DiamondKing Auto Const Mandatory

	ObjectReference Property Gambling_Blackjack_ClubAce Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Club02 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Club03 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Club04 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Club05 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Club06 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Club07 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Club08 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Club09 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Club10 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_ClubJack Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_ClubQueen Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_ClubKing Auto Const Mandatory

	ObjectReference Property Gambling_Blackjack_HeartAce Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Heart02 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Heart03 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Heart04 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Heart05 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Heart06 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Heart07 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Heart08 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Heart09 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_Heart10 Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_HeartJack Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_HeartQueen Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_HeartKing Auto Const Mandatory
EndGroup
