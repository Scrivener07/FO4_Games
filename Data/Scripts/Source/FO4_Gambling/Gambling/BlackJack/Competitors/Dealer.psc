ScriptName Gambling:BlackJack:Competitors:Dealer extends Gambling:BlackJack:Competitors:Seat
import Gambling
import Gambling:Common


; Events
;---------------------------------------------

Event OnStartup()
	ID = 0
	Abort = false
	Score = 0
	Wager = 0
	Winnings = 0
	Hand = new Deck:Card[0]
EndEvent


Event OnWager()
	WriteLine(self, "Skipping, a dealer does not wager a bet.")
EndEvent


Event OnDeal(Deck:Card card, int index)
	If (card)
		If (card.Reference)
			If (index == 0)
				Controller.Translate(card.Reference, Gambling_BlackJack_D1C01)
			ElseIf (index == 1)
				Controller.Translate(card.Reference, Gambling_BlackJack_D1C02)
			ElseIf (index == 2)
				Controller.Translate(card.Reference, Gambling_BlackJack_D1C03)
			ElseIf (index == 3)
				Controller.Translate(card.Reference, Gambling_BlackJack_D1C04)
			ElseIf (index == 4)
				Controller.Translate(card.Reference, Gambling_BlackJack_D1C05)
			ElseIf (index == 5)
				Controller.Translate(card.Reference, Gambling_BlackJack_D1C06)
			ElseIf (index == 6)
				Controller.Translate(card.Reference, Gambling_BlackJack_D1C07)
			ElseIf (index == 7)
				Controller.Translate(card.Reference, Gambling_BlackJack_D1C08)
			ElseIf (index == 8)
				Controller.Translate(card.Reference, Gambling_BlackJack_D1C09)
			ElseIf (index == 9)
				Controller.Translate(card.Reference, Gambling_BlackJack_D1C10)
			ElseIf (index == 10)
				Controller.Translate(card.Reference, Gambling_BlackJack_D1C11)
			Else
				WriteLine(self, "The hand index '"+index+"' is out of range.")
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
		Deck:Card card = Hand[0]
		Controller.Translate(card.Reference, Gambling_BlackJack_D1C01B)

		If (Main.IsWin(Score))
			WriteLine(self, "The dealer has a black jack on turn one.")
			return
		Else
			int selected = OptionChoice()

			If (selected == OptionHit)
				WriteLine(self, "The dealer has chosen to hit with "+Score)
				Deal(Main.Cards.Deck.Draw())
				self.OnPlay()

			ElseIf (selected == OptionStand)
				WriteLine(self, "The dealer has chosen to stand with "+Score)
				return
			Else
				WriteLine(self, "The option '"+selected+"' is unhandled.")
				return
			EndIf
		EndIf

	ElseIf (Turn >= 2)
		If (Main.IsWin(Score))
			WriteLine(self, "The dealer has a black jack with "+Score)
			return

		ElseIf (Main.IsBust(Score))
			WriteLine(self, "The dealer has busted with "+Score)
			return

		Else
			Deck:Card card = Hand[Turn]
			int selected = OptionChoice()

			If (selected == OptionHit)
				WriteLine(self, "The dealer has chosen to hit with "+Score)
				Deal(Main.Cards.Deck.Draw())
				self.OnPlay()

			ElseIf (selected == OptionStand)
				WriteLine(self, "The dealer has chosen to stand with "+Score)
				return

			Else
				WriteLine(self, "The option '"+selected+"' is unhandled.")
				return
			EndIf
		EndIf
	EndIf
EndEvent


; Functions
;---------------------------------------------

int Function OptionChoice()
	If (Score <= 16)
		return OptionHit
	Else
		return OptionStand
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Cards
	ObjectReference Property Gambling_BlackJack_D1C01 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_D1C01B Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_D1C02 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_D1C03 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_D1C04 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_D1C05 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_D1C06 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_D1C07 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_D1C08 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_D1C09 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_D1C10 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_D1C11 Auto Const Mandatory
EndGroup
