ScriptName Gambling:BlackJack:Competitors:PlayerA extends Gambling:BlackJack:Competitors:Seat
import Gambling
import Gambling:Common
import Gambling:Shared


int Invalid = -1 const

int OptionExit = 0 const
int OptionStart = 1 const

int OptionWager1 = 1 const
int OptionWager5 = 2 const
int OptionWager10 = 3 const
int OptionWager20 = 4 const
int OptionWager50 = 5 const
int OptionWager100 = 6 const


; Events
;---------------------------------------------

Event OnStartup()
	ID = 1
	Abort = false
	Score = 0
	Wager = 0
	Winnings = 0
	Hand = new Deck:Card[0]
EndEvent


Event OnWager()
	int selected = Gambling_BlackJack_MessageWager.Show()

	If (selected == OptionExit || selected == Invalid)
		Abort = true
		return
	ElseIf (selected == OptionWager1)
		Wager = 1
	ElseIf (selected == OptionWager5)
		Wager = 5
	ElseIf (selected == OptionWager10)
		Wager = 10
	ElseIf (selected == OptionWager20)
		Wager = 20
	ElseIf (selected == OptionWager50)
		Wager = 50
	ElseIf (selected == OptionWager100)
		Wager = 100
	Else
		WriteLine(self, "The option '"+selected+"' is unhandled.")
		Abort = true
	EndIf
EndEvent


Event OnDeal(Deck:Card card, int index)
	If (card)
		If (card.Reference)
			If (index == 0)
				Controller.Translate(card.Reference, Gambling_BlackJack_P1C01)
			ElseIf (index == 1)
				Controller.Translate(card.Reference, Gambling_BlackJack_P1C02)
			ElseIf (index == 2)
				Controller.Translate(card.Reference, Gambling_BlackJack_P1C03)
			ElseIf (index == 3)
				Controller.Translate(card.Reference, Gambling_BlackJack_P1C04)
			ElseIf (index == 4)
				Controller.Translate(card.Reference, Gambling_BlackJack_P1C05)
			ElseIf (index == 5)
				Controller.Translate(card.Reference, Gambling_BlackJack_P1C06)
			ElseIf (index == 6)
				Controller.Translate(card.Reference, Gambling_BlackJack_P1C07)
			ElseIf (index == 7)
				Controller.Translate(card.Reference, Gambling_BlackJack_P1C08)
			ElseIf (index == 8)
				Controller.Translate(card.Reference, Gambling_BlackJack_P1C09)
			ElseIf (index == 9)
				Controller.Translate(card.Reference, Gambling_BlackJack_P1C10)
			ElseIf (index == 10)
				Controller.Translate(card.Reference, Gambling_BlackJack_P1C11)
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
			WriteLine(self, "The player has a black jack on turn one.")
			return
		Else
			int Card1 = Hand[0].Rank
			int Card2 = Hand[1].Rank
			int selected = Gambling_BlackJack_MessageDealt.Show(Card1, Card2, Score)

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
		If (BlackJack.IsWin(Score))
			WriteLine(self, "The player has a black jack with "+Score)
			return

		ElseIf (BlackJack.IsBust(Score))
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

Group Properties
	Message Property Gambling_BlackJack_MessageWager Auto Const Mandatory
	Message Property Gambling_BlackJack_MessageDealt Auto Const Mandatory
	Message Property Gambling_BlackJack_MessageTurn Auto Const Mandatory
EndGroup


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
