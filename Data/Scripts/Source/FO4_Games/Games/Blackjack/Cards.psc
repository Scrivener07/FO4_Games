ScriptName Games:Blackjack:Cards extends Games:Blackjack:Type
import Games
import Games:Blackjack
import Games:Shared
import Games:Shared:Deck
import Games:Shared:Log

ReferenceData Data
ObjectReference[] References


; Events
;---------------------------------------------

Event OnInit()
	Data = new ReferenceData
	Data.Spade01 = GamesBlackjack_Deck01SpadeAce
	Data.Spade02 = GamesBlackjack_Deck01Spade02
	Data.Spade03 = GamesBlackjack_Deck01Spade03
	Data.Spade04 = GamesBlackjack_Deck01Spade04
	Data.Spade05 = GamesBlackjack_Deck01Spade05
	Data.Spade06 = GamesBlackjack_Deck01Spade06
	Data.Spade07 = GamesBlackjack_Deck01Spade07
	Data.Spade08 = GamesBlackjack_Deck01Spade08
	Data.Spade09 = GamesBlackjack_Deck01Spade09
	Data.Spade10 = GamesBlackjack_Deck01Spade10
	Data.Spade11 = GamesBlackjack_Deck01SpadeJack
	Data.Spade12 = GamesBlackjack_Deck01SpadeQueen
	Data.Spade13 = GamesBlackjack_Deck01SpadeKing
	Data.Diamond01 = GamesBlackjack_Deck01DiamondAce
	Data.Diamond02 = GamesBlackjack_Deck01Diamond02
	Data.Diamond03 = GamesBlackjack_Deck01Diamond03
	Data.Diamond04 = GamesBlackjack_Deck01Diamond04
	Data.Diamond05 = GamesBlackjack_Deck01Diamond05
	Data.Diamond06 = GamesBlackjack_Deck01Diamond06
	Data.Diamond07 = GamesBlackjack_Deck01Diamond07
	Data.Diamond08 = GamesBlackjack_Deck01Diamond08
	Data.Diamond09 = GamesBlackjack_Deck01Diamond09
	Data.Diamond10 = GamesBlackjack_Deck01Diamond10
	Data.Diamond11 = GamesBlackjack_Deck01DiamondJack
	Data.Diamond12 = GamesBlackjack_Deck01DiamondQueen
	Data.Diamond13 = GamesBlackjack_Deck01DiamondKing
	Data.Club01 = GamesBlackjack_Deck01ClubAce
	Data.Club02 = GamesBlackjack_Deck01Club02
	Data.Club03 = GamesBlackjack_Deck01Club03
	Data.Club04 = GamesBlackjack_Deck01Club04
	Data.Club05 = GamesBlackjack_Deck01Club05
	Data.Club06 = GamesBlackjack_Deck01Club06
	Data.Club07 = GamesBlackjack_Deck01Club07
	Data.Club08 = GamesBlackjack_Deck01Club08
	Data.Club09 = GamesBlackjack_Deck01Club09
	Data.Club10 = GamesBlackjack_Deck01Club10
	Data.Club11 = GamesBlackjack_Deck01ClubJack
	Data.Club12 = GamesBlackjack_Deck01ClubQueen
	Data.Club13 = GamesBlackjack_Deck01ClubKing
	Data.Heart01 = GamesBlackjack_Deck01HeartAce
	Data.Heart02 = GamesBlackjack_Deck01Heart02
	Data.Heart03 = GamesBlackjack_Deck01Heart03
	Data.Heart04 = GamesBlackjack_Deck01Heart04
	Data.Heart05 = GamesBlackjack_Deck01Heart05
	Data.Heart06 = GamesBlackjack_Deck01Heart06
	Data.Heart07 = GamesBlackjack_Deck01Heart07
	Data.Heart08 = GamesBlackjack_Deck01Heart08
	Data.Heart09 = GamesBlackjack_Deck01Heart09
	Data.Heart10 = GamesBlackjack_Deck01Heart10
	Data.Heart11 = GamesBlackjack_Deck01HeartJack
	Data.Heart12 = GamesBlackjack_Deck01HeartQueen
	Data.Heart13 = GamesBlackjack_Deck01HeartKing
	Deck:Card[] cards = Deck.SetData(Data)
	References = ToReferences(cards)
EndEvent


; States
;---------------------------------------------

State Starting
	Event OnState()
		{Starting}
		CollectAll(true)
	EndEvent
EndState


State Dealing
	Event OnState()
		{Dealing}
		Shuffle()
	EndEvent
EndState



; Methods
;---------------------------------------------

Function CollectFrom(Blackjack:Player player)
	If (player)
		CollectEach(player.Hand)
		player.Motion.TranslateEach(ToReferences(player.Hand), GamesBlackjack_DeckMarker)
	Else
		WriteUnexpectedValue(self, "CollectFrom", "player", "Cannot collect cards from a none player.")
	EndIf
EndFunction


; Functions
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
		WriteUnexpectedValue(self, "CollectEach", "aCards", "Cannot collect none or empty card array.")
	EndIf
EndFunction





Function CollectAll(bool aForce = false)
	If (References)
		If (aForce)
			int index = 0
			While (index < References.Length)
				References[index].MoveTo(GamesBlackjack_DeckMarker)
				index += 1
			EndWhile
		Else
			Motion.TranslateEach(References, GamesBlackjack_DeckMarker)
		EndIf
	Else
		WriteUnexpectedValue(self, "CollectAll", "References", "Cannot collect all for none references.")
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Scripts
	Shared:Deck Property Deck Auto Const Mandatory
	Shared:Motion Property Motion Auto Const Mandatory
EndGroup

Group Deck
	ObjectReference Property GamesBlackjack_DeckMarker Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DeckMarkerB Auto Const Mandatory
	ObjectReference Property GamesBlackjack_CardArrow Auto Const Mandatory
EndGroup

Group Dealer
	ObjectReference Property GamesBlackjack_DealerCard01 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard01Reveal Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard02 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard03 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard04 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard05 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard06 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard07 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard08 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard09 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard10 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_DealerCard11 Auto Const Mandatory
EndGroup

Group Player
	ObjectReference Property GamesBlackjack_PlayerCard01 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCard02 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCard03 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCard04 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCard05 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCard06 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCard07 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCard08 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCard09 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCard10 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCard11 Auto Const Mandatory
EndGroup
Group PlayerSplitA
	; ObjectReference Property GamesBlackjack_PlayerCardSplitA_Selected Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCardSplitA01 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCardSplitA02 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCardSplitA03 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCardSplitA04 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCardSplitA05 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCardSplitA06 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCardSplitA07 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCardSplitA08 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCardSplitA09 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCardSplitA10 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCardSplitA11 Auto Const Mandatory

EndGroup
Group PlayerSplitB
	; ObjectReference Property GamesBlackjack_PlayerCardSplitB_Selected Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCardSplitB01 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCardSplitB02 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCardSplitB03 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCardSplitB04 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCardSplitB05 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCardSplitB06 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCardSplitB07 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCardSplitB08 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCardSplitB09 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCardSplitB10 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_PlayerCardSplitB11 Auto Const Mandatory
EndGroup

Group Cards
	ObjectReference Property GamesBlackjack_Deck01SpadeAce Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Spade02 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Spade03 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Spade04 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Spade05 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Spade06 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Spade07 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Spade08 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Spade09 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Spade10 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01SpadeJack Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01SpadeQueen Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01SpadeKing Auto Const Mandatory

	ObjectReference Property GamesBlackjack_Deck01DiamondAce Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Diamond02 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Diamond03 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Diamond04 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Diamond05 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Diamond06 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Diamond07 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Diamond08 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Diamond09 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Diamond10 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01DiamondJack Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01DiamondQueen Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01DiamondKing Auto Const Mandatory

	ObjectReference Property GamesBlackjack_Deck01ClubAce Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Club02 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Club03 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Club04 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Club05 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Club06 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Club07 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Club08 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Club09 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Club10 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01ClubJack Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01ClubQueen Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01ClubKing Auto Const Mandatory

	ObjectReference Property GamesBlackjack_Deck01HeartAce Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Heart02 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Heart03 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Heart04 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Heart05 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Heart06 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Heart07 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Heart08 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Heart09 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01Heart10 Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01HeartJack Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01HeartQueen Auto Const Mandatory
	ObjectReference Property GamesBlackjack_Deck01HeartKing Auto Const Mandatory
EndGroup
