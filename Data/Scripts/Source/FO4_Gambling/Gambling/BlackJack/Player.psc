ScriptName Gambling:BlackJack:Player extends Gambling:BlackJack:Component Hidden
import Gambling
import Gambling:BlackJack
import Gambling:Shared
import Gambling:Shared:Common
import Gambling:Shared:Deck


Card[] Cards
SessionData Session

Struct SessionData
	int Score = 0
	int Wager = 0
	int Winnings = 0
	bool Abort = false
	int Turn = -1
EndStruct


; Component
;---------------------------------------------

Function GameBegin()
	Cards = new Deck:Card[0]
	Session = new SessionData
EndFunction


Function GameWager()
	int bet = BehaviorWager()
	If (bet > 0)
		Session.Wager = bet
	Else
		Session.Abort = true
	EndIf
EndFunction


Function GameDeal()
	BehaviorDraw()
	BehaviorDraw()
EndFunction


Function GamePlay()
	If (Turn == 0)

	EndIf

	If (Turn == 1)
		If (BlackJack.Rules.IsWin(Score))
			WriteLine(self, "Has a black jack on turn one.")
			return
		Else
			int selected = BehaviorTurn()

			If (selected == OptionHit)
				WriteLine(self, "Has chosen to hit with "+Score)
				BehaviorDraw()
				self.GamePlay()

			ElseIf (selected == OptionStand)
				WriteLine(self, "Has chosen to stand with "+Score)
				return
			Else
				WriteLine(self, "The option '"+selected+"' is unhandled.")
				return
			EndIf
		EndIf
	EndIf


	If (Turn >= 2)
		If (BlackJack.Rules.IsWin(Score))
			WriteLine(self, "Has a black jack with "+Score)
			return

		ElseIf (BlackJack.Rules.IsBust(Score))
			WriteLine(self, "Has busted with "+Score)
			return

		Else
			int selected = BehaviorTurn()

			If (selected == OptionHit)
				WriteLine(self, "Has chosen to hit with "+Score)
				BehaviorDraw()
				self.GamePlay()

			ElseIf (selected == OptionStand)
				WriteLine(self, "Has chosen to stand with "+Score)
				return

			Else
				WriteLine(self, "The option '"+selected+"' is unhandled.")
				return
			EndIf
		EndIf
	EndIf
EndFunction


; Player
;---------------------------------------------

int Function BehaviorWager()
	{Returns the amount of caps to wager.}
	return 20
EndFunction


int Function BehaviorTurn()
	{Return th decision for this turn.}
	If (Session.Score <= 16)
		return OptionHit
	Else
		return OptionStand
	EndIf
EndFunction


Function BehaviorDraw()
	Card value = BlackJack.Cards.Deck.Draw()
	Cards.Add(value)

	If (value)
		If (value.Reference)
			If (Turn == 0)
				Motion.Translate(value.Reference, Hand_CardMarker01)
			ElseIf (Turn == 1)
				Motion.Translate(value.Reference, Hand_CardMarker02)
			ElseIf (Turn == 2)
				Motion.Translate(value.Reference, Hand_CardMarker03)
			ElseIf (Turn == 3)
				Motion.Translate(value.Reference, Hand_CardMarker04)
			ElseIf (Turn == 4)
				Motion.Translate(value.Reference, Hand_CardMarker05)
			ElseIf (Turn == 5)
				Motion.Translate(value.Reference, Hand_CardMarker06)
			ElseIf (Turn == 6)
				Motion.Translate(value.Reference, Hand_CardMarker07)
			ElseIf (Turn == 7)
				Motion.Translate(value.Reference, Hand_CardMarker08)
			ElseIf (Turn == 8)
				Motion.Translate(value.Reference, Hand_CardMarker09)
			ElseIf (Turn == 9)
				Motion.Translate(value.Reference, Hand_CardMarker10)
			ElseIf (Turn == 10)
				Motion.Translate(value.Reference, Hand_CardMarker11)
			Else
				WriteLine(self, "The turn '"+Turn+"' is out of range.")
			EndIf
		Else
			WriteLine(self, "Cannot deal a none card reference.")
		EndIf
	Else
		WriteLine(self, "Cannot deal a none card.")
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Object
	BlackJack:Game Property BlackJack Auto Const Mandatory
	Controllers:Motion Property Motion Auto Const Mandatory
EndGroup

Group Player
	Card[] Property Hand Hidden
		Card[] Function Get()
			return Cards
		EndFunction
	EndProperty

	int Property Turn Hidden
		int Function Get()
			{ TODO: not really the turn number}
			return Cards.Length - 1
		EndFunction
	EndProperty

	int Property Score Hidden
		int Function Get()
			return Session.Score
		EndFunction
	EndProperty

	int Property Wager Hidden
		int Function Get()
			return Session.Wager
		EndFunction
	EndProperty

	bool Property Abort Hidden
		bool Function Get()
			return Session.Abort
		EndFunction
	EndProperty
EndGroup

Group Turn
	int Property OptionHit = 0 AutoReadOnly
	int Property OptionStand = 1 AutoReadOnly
EndGroup

Group Hand
	ObjectReference Property Hand_CardMarker01 Auto Const Mandatory
	ObjectReference Property Hand_CardMarker02 Auto Const Mandatory
	ObjectReference Property Hand_CardMarker03 Auto Const Mandatory
	ObjectReference Property Hand_CardMarker04 Auto Const Mandatory
	ObjectReference Property Hand_CardMarker05 Auto Const Mandatory
	ObjectReference Property Hand_CardMarker06 Auto Const Mandatory
	ObjectReference Property Hand_CardMarker07 Auto Const Mandatory
	ObjectReference Property Hand_CardMarker08 Auto Const Mandatory
	ObjectReference Property Hand_CardMarker09 Auto Const Mandatory
	ObjectReference Property Hand_CardMarker10 Auto Const Mandatory
	ObjectReference Property Hand_CardMarker11 Auto Const Mandatory
EndGroup
