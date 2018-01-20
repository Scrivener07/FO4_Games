ScriptName Games:Blackjack:Players:Human extends Games:Blackjack:Player
import Games
import Games:Blackjack
import Games:Papyrus:Log
import Games:Shared
import Games:Shared:UI:ButtonHint

Actor PlayerRef

int Wager = 0
Button AcceptButton
Button IncreaseButton
Button DecreaseButton
Button MinimumButton
Button MaximumButton ; TODO: This button is outside the visible area on HUDMenu

Button HitButton
Button StandButton

Button YesButton
Button NoButton


Blackjack:Display Property Display Auto Const Mandatory

Group ButtonHint
	UI:ButtonHint Property ButtonHint Auto Const Mandatory
	Shared:Keyboard Property Keyboard Auto Const Mandatory
EndGroup

Group SFX
	Sound Property ITMBottlecapsUpx Auto Const Mandatory
	Sound Property ITMBottlecapsDownx Auto Const Mandatory
EndGroup


; Events
;---------------------------------------------

Event OnInit()
	parent.OnInit()
	PlayerRef = Game.GetPlayer()

	AcceptButton = new Button
	AcceptButton.Text = "Accept"
	AcceptButton.KeyCode = Keyboard.E

	IncreaseButton = new Button
	IncreaseButton.Text = "Increase"
	IncreaseButton.KeyCode = Keyboard.W

	DecreaseButton = new Button
	DecreaseButton.Text = "Decrease"
	DecreaseButton.KeyCode = Keyboard.S

	MinimumButton = new Button
	MinimumButton.Text = "Minimum"
	MinimumButton.KeyCode = Keyboard.A

	MaximumButton = new Button
	MaximumButton.Text = "Maximum"
	MaximumButton.KeyCode = Keyboard.D

	HitButton = new Button
	HitButton.Text = "Hit"
	HitButton.KeyCode = Keyboard.W

	StandButton = new Button
	StandButton.Text = "Stand"
	StandButton.KeyCode = Keyboard.S

	YesButton = new Button
	YesButton.Text = "Play Again"
	YesButton.KeyCode = Keyboard.E

	NoButton = new Button
	NoButton.Text = "Leave"
	NoButton.KeyCode = Keyboard.Tab
EndEvent


Event Games:Shared:UI:ButtonHint.OnSelected(UI:ButtonHint akSender, var[] arguments)
	akSender.UnregisterForSelectedEvent(self)
	InvalidOperationException(self, "OnSelected", "Unregistered for event in the '"+StateName+"' state.")
EndEvent


; FSM - Finite State Machine
;---------------------------------------------

State Starting
	Event Starting()
		Wager = WagerMinimum

		Display.Score = 0
		Display.Bet = Wager
		Display.Caps = Bank
		Display.Earnings = Earnings
		Display.Visible = true

		parent.Starting()
	EndEvent

	MarkerValue Function IMarkers()
		MarkerValue marker = new MarkerValue
		marker.Card01 = Games_Blackjack_P1C01
		marker.Card02 = Games_Blackjack_P1C02
		marker.Card03 = Games_Blackjack_P1C03
		marker.Card04 = Games_Blackjack_P1C04
		marker.Card05 = Games_Blackjack_P1C05
		marker.Card06 = Games_Blackjack_P1C06
		marker.Card07 = Games_Blackjack_P1C07
		marker.Card08 = Games_Blackjack_P1C08
		marker.Card09 = Games_Blackjack_P1C09
		marker.Card10 = Games_Blackjack_P1C10
		marker.Card11 = Games_Blackjack_P1C11
		return marker
	EndFunction
EndState


State Wagering
	Event Wagering()
		Display.Score = 0
		Display.Bet = Wager ; last wager amount
		parent.Wagering()
		Display.Earnings = Earnings
	EndEvent

	int Function IWager()
		ButtonHint.Clear()
		ButtonHint.SelectOnce = false
		ButtonHint.Add(AcceptButton)
		ButtonHint.Add(IncreaseButton)
		ButtonHint.Add(DecreaseButton)
		ButtonHint.Add(MinimumButton)
		ButtonHint.Add(MaximumButton)
		ButtonHint.RegisterForSelectedEvent(self)
		ButtonHint.Show()
		return Wager
	EndFunction

	Event Games:Shared:UI:ButtonHint.OnSelected(UI:ButtonHint akSender, var[] arguments)
		If (arguments)
			Button selected = akSender.GetSelectedEventArgs(arguments)

			If (selected == AcceptButton)
				If (IsValidWager(Wager))
					akSender.UnregisterForSelectedEvent(self)
					akSender.Hide()
					Game.RemovePlayerCaps(Wager)
					Display.Caps = Bank
				EndIf

			ElseIf (selected == IncreaseButton)
				If (IsValidWager(Wager + WagerStep))
					Wager += WagerStep
					Display.Bet = Wager
					ITMBottlecapsDownx.Play(Player)
				EndIf

			ElseIf (selected == DecreaseButton)
				If (IsValidWager(Wager - WagerStep))
					Wager -= WagerStep
					Display.Bet = Wager
					ITMBottlecapsUpx.Play(Player)
				EndIf

			ElseIf (selected == MinimumButton)
				If (IsValidWager(WagerMinimum))
					Wager = WagerMinimum
					Display.Bet = Wager
					ITMBottlecapsUpx.Play(Player)
				EndIf

			ElseIf (selected == MaximumButton)
				If (IsValidWager(WagerMaximum))
					Wager = WagerMaximum
					Display.Bet = Wager
					ITMBottlecapsDownx.Play(Player)
				EndIf
			Else
				InvalidOperationException(self, "OnSelected", "The selected wager button '"+selected+"' was unhandled in the '"+StateName+"' state.")
			EndIf
		Else
			ArgumentException(self, "OnSelected", "var[] arguments", "The arguments are null or empty.")
		EndIf
	EndEvent
EndState


State Dealing
	Event Dealing()
		parent.Dealing()
		Display.Score = Score
	EndEvent
EndState


State Playing
	Event OnTurn(int aTurn)
		Display.Score = Score
	EndEvent

	int Function IChoice()
		ButtonHint.Clear()
		ButtonHint.SelectOnce = true
		ButtonHint.Add(HitButton)
		ButtonHint.Add(StandButton)
		ButtonHint.Show()

		If (ButtonHint.Selected)
			If (ButtonHint.Selected == HitButton)
				return ChoiceHit
			ElseIf (ButtonHint.Selected == StandButton)
				return ChoiceStand
			Else
				InvalidOperationException(self, "IChoice", "The selected choice button '"+ButtonHint.Selected+"' was unhandled in the '"+StateName+"' state.")
				return Invalid
			EndIf
		Else
			InvalidOperationException(self, "IChoice", "No choice button was selected.")
			return Invalid
		EndIf
	EndFunction
EndState


State Scoring
	Event Scoring()
		parent.Scoring()
		Game.GivePlayerCaps(Winnings)
		Display.Earnings = Earnings
		Display.Caps = Bank

		ButtonHint.Clear()
		ButtonHint.SelectOnce = true
		ButtonHint.Add(YesButton)
		ButtonHint.Add(NoButton)
		ButtonHint.Show()

		If (ButtonHint.Selected)
			If (ButtonHint.Selected == YesButton)
				WriteLine(self, "The '"+ButtonHint.Selected.Text+"' button was selected.")
				Rematch(true)
			ElseIf (ButtonHint.Selected == NoButton)
				WriteLine(self, "The '"+ButtonHint.Selected.Text+"' button was selected.")
				Rematch(false)
			Else
				InvalidOperationException(self, "Scoring", "The selected button '"+ButtonHint.Selected+"' was unhandled in the '"+StateName+"' state.")
				Rematch(false)
			EndIf
		Else
			InvalidOperationException(self, "Scoring", "No button hint was selected.")
			Rematch(false)
		EndIf
	EndEvent
EndState


State Exiting
	Event Exiting()
		Display.Visible = false
		parent.Exiting()
	EndEvent
EndState


; Requests
;---------------------------------------------

MarkerValue Function IMarkers()
	; Required for type-check return because function is not on object.
	return parent.IMarkers()
EndFunction

int Function IWager()
	; Required for type-check return because function is not on object.
	return parent.IWager()
EndFunction

int Function IChoice()
	; Required for type-check return because function is not on object.
	return parent.IChoice()
EndFunction


; Player
;---------------------------------------------

int Function GetBank()
	return Player.GetGoldAmount()
EndFunction


Function SetScore(int value)
	parent.SetScore(value)
	Display.Score = value
EndFunction


; Properties
;---------------------------------------------

Group Human
	Actor Property Player Hidden
		Actor Function Get()
			return PlayerRef
		EndFunction
	EndProperty
EndGroup

Group Markers
	ObjectReference Property Games_Blackjack_P1C01 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P1C02 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P1C03 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P1C04 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P1C05 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P1C06 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P1C07 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P1C08 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P1C09 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P1C10 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P1C11 Auto Const Mandatory
EndGroup
