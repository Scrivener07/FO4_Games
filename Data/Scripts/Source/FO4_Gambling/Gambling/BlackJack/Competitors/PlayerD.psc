ScriptName Gambling:BlackJack:Competitors:PlayerD extends Gambling:BlackJack:Competitors:Seat
import Gambling
import Gambling:Common
import Gambling:Shared


; Events
;---------------------------------------------

Event OnStartup()
	ID = 4
	Abort = false
	Score = 0
	Wager = 0
	Winnings = 0
	Hand = new Deck:Card[0]
EndEvent


Event OnDeal(Deck:Card card, int index)
	If (card)
		If (card.Reference)
			If (index == 0)
				Controller.Translate(card.Reference, Gambling_BlackJack_P4C01)
			ElseIf (index == 1)
				Controller.Translate(card.Reference, Gambling_BlackJack_P4C02)
			ElseIf (index == 2)
				Controller.Translate(card.Reference, Gambling_BlackJack_P4C03)
			ElseIf (index == 3)
				Controller.Translate(card.Reference, Gambling_BlackJack_P4C04)
			ElseIf (index == 4)
				Controller.Translate(card.Reference, Gambling_BlackJack_P4C05)
			ElseIf (index == 5)
				Controller.Translate(card.Reference, Gambling_BlackJack_P4C06)
			ElseIf (index == 6)
				Controller.Translate(card.Reference, Gambling_BlackJack_P4C07)
			ElseIf (index == 7)
				Controller.Translate(card.Reference, Gambling_BlackJack_P4C08)
			ElseIf (index == 8)
				Controller.Translate(card.Reference, Gambling_BlackJack_P4C09)
			ElseIf (index == 9)
				Controller.Translate(card.Reference, Gambling_BlackJack_P4C10)
			ElseIf (index == 10)
				Controller.Translate(card.Reference, Gambling_BlackJack_P4C11)
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
		If (BlackJack.IsWin(Score))
			WriteLine(self, "The seat '"+ID+"' has a black jack on turn one.")
			return
		Else
			int selected = OptionChoice()

			If (selected == OptionHit)
				WriteLine(self, "The seat '"+ID+"' has chosen to hit with "+Score)
				Deal(BlackJack.Cards.Deck.Draw())
				self.OnPlay()

			ElseIf (selected == OptionStand)
				WriteLine(self, "The seat '"+ID+"' has chosen to stand with "+Score)
				return
			Else
				WriteLine(self, "The option '"+selected+"' is unhandled.")
				return
			EndIf
		EndIf

	ElseIf (Turn >= 2)
		If (BlackJack.IsWin(Score))
			WriteLine(self, "The seat '"+ID+"' has a black jack with "+Score)
			return

		ElseIf (BlackJack.IsBust(Score))
			WriteLine(self, "The seat '"+ID+"' has busted with "+Score)
			return

		Else
			Deck:Card card = Hand[Turn]
			int selected = OptionChoice()

			If (selected == OptionHit)
				WriteLine(self, "The seat '"+ID+"' has chosen to hit with "+Score)
				Deal(BlackJack.Cards.Deck.Draw())
				self.OnPlay()

			ElseIf (selected == OptionStand)
				WriteLine(self, "The seat '"+ID+"' has chosen to stand with "+Score)
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
	ObjectReference Property Gambling_BlackJack_P4C01 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_P4C02 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_P4C03 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_P4C04 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_P4C05 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_P4C06 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_P4C07 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_P4C08 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_P4C09 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_P4C10 Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_P4C11 Auto Const Mandatory
EndGroup
