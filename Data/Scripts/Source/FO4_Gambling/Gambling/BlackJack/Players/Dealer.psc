ScriptName Gambling:BlackJack:Players:Dealer extends Gambling:BlackJack:Player
import Gambling
import Gambling:Shared
import Gambling:Shared:Common


; Component
;---------------------------------------------

Function GamePlay()
	If (Turn == 1)

		RevealHand()

		If (BlackJack.Rules.IsWin(Score))
			WriteLine(self, "The dealer has a black jack on turn one.")
			return
		Else
			int selected = BehaviorTurn()

			If (selected == OptionHit)
				WriteLine(self, "The dealer has chosen to hit with "+Score)

				BehaviorDraw()
				self.GamePlay()

			ElseIf (selected == OptionStand)
				WriteLine(self, "The dealer has chosen to stand with "+Score)
				return
			Else
				WriteLine(self, "The option '"+selected+"' is unhandled.")
				return
			EndIf
		EndIf
	EndIf

	If (Turn >= 2)
		If (BlackJack.Rules.IsWin(Score))
			WriteLine(self, "The dealer has a black jack with "+Score)
			return

		ElseIf (BlackJack.Rules.IsBust(Score))
			WriteLine(self, "The dealer has busted with "+Score)
			return

		Else
			int selected = BehaviorTurn()

			If (selected == OptionHit)
				WriteLine(self, "The dealer has chosen to hit with "+Score)

				BehaviorDraw()
				self.GamePlay()

			ElseIf (selected == OptionStand)
				WriteLine(self, "The dealer has chosen to stand with "+Score)
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

int Function BehaviorTurn()
	{Return the decision for this turn.}
	If (Score <= 16)
		return OptionHit
	Else
		return OptionStand
	EndIf
EndFunction


int Function BehaviorWager()
	WriteLine(self, "Wagering is invalid, a dealer does not wager a bet.")
	return Invalid
EndFunction


Function RevealHand()
	Deck:Card card = Hand[0]
	Motion.Translate(Hand[0].Reference, Gambling_BlackJack_D1C01B)
EndFunction


; Properties
;---------------------------------------------

Group Hand
	ObjectReference Property Gambling_BlackJack_D1C01B Auto Const Mandatory
EndGroup
