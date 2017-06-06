ScriptName Gambling:BlackJack:Players:Human extends Gambling:BlackJack:Player
import Gambling
import Gambling:Shared
import Gambling:Shared:Common


; Events
;---------------------------------------------

Event OnWager()
	Wager = BlackJack.GUI.PromptWager()
EndEvent


Event OnDeal(Deck:Card card)
	If (card)
		If (card.Reference)
			If (Turn == 0)
				Controller.Translate(card.Reference, Gambling_BlackJack_P1C01)
			ElseIf (Turn == 1)
				Controller.Translate(card.Reference, Gambling_BlackJack_P1C02)
			ElseIf (Turn == 2)
				Controller.Translate(card.Reference, Gambling_BlackJack_P1C03)
			ElseIf (Turn == 3)
				Controller.Translate(card.Reference, Gambling_BlackJack_P1C04)
			ElseIf (Turn == 4)
				Controller.Translate(card.Reference, Gambling_BlackJack_P1C05)
			ElseIf (Turn == 5)
				Controller.Translate(card.Reference, Gambling_BlackJack_P1C06)
			ElseIf (Turn == 6)
				Controller.Translate(card.Reference, Gambling_BlackJack_P1C07)
			ElseIf (Turn == 7)
				Controller.Translate(card.Reference, Gambling_BlackJack_P1C08)
			ElseIf (Turn == 8)
				Controller.Translate(card.Reference, Gambling_BlackJack_P1C09)
			ElseIf (Turn == 9)
				Controller.Translate(card.Reference, Gambling_BlackJack_P1C10)
			ElseIf (Turn == 10)
				Controller.Translate(card.Reference, Gambling_BlackJack_P1C11)
			Else
				WriteLine(self, "The turn '"+Turn+"' is out of range.")
			EndIf
		Else
			WriteLine(self, "Cannot deal a none card reference.")
		EndIf
	Else
		WriteLine(self, "Cannot deal a none card.")
	EndIf
EndEvent




Event OnPlay()
	If (Turn == 1)
		If (BlackJack.Rules.IsWin(Score))
			WriteLine(self, "The player has a black jack on turn one.")
			return
		Else
			int Card1 = Hand[0].Rank
			int Card2 = Hand[1].Rank

			int selected = BlackJack.GUI.ShowDealt(Card1, Card2, Score)

			If (selected == OptionHit)
				WriteLine(self, "The player has chosen to hit with "+Score)
				Deal(BlackJack.Cards.Deck.Draw())
				self.OnPlay()

			ElseIf (selected == OptionStand)
				WriteLine(self, "The player has chosen to stand with "+Score)
				return
			Else
				WriteLine(self, "The option '"+selected+"' is unhandled.")
				return
			EndIf



		EndIf

	ElseIf (Turn >= 2)
		If (BlackJack.Rules.IsWin(Score))
			WriteLine(self, "The player has a black jack with "+Score)
			return

		ElseIf (BlackJack.Rules.IsBust(Score))
			WriteLine(self, "The player has busted with "+Score)
			return

		Else
			Deck:Card card = Hand[Turn]


			int selected = Gambling_BlackJack_MessageTurn.Show(card.Rank, Score)

			If (selected == OptionHit)
				WriteLine(self, "The player has chosen to hit with "+Score)
				Deal(BlackJack.Cards.Deck.Draw())
				self.OnPlay()

			ElseIf (selected == OptionStand)
				WriteLine(self, "The player has chosen to stand with "+Score)
				return

			Else
				WriteLine(self, "The option '"+selected+"' is unhandled.")
				return
			EndIf
		EndIf
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Markers
	ObjectReference Property Gambling_BlackJack_P1C01 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_P1C02 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_P1C03 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_P1C04 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_P1C05 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_P1C06 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_P1C07 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_P1C08 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_P1C09 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_P1C10 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_P1C11 Auto Const Mandatory
EndGroup
