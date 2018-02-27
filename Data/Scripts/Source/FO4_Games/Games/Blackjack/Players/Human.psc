ScriptName Games:Blackjack:Players:Human extends Games:Blackjack:Player
import Games
import Games:Blackjack
import Games:Shared:Log
import Games:Shared
import Games:Shared:UI:ButtonMenu

Actor PlayerRef
MiscObject Caps

int Wager = 0
Button AcceptButton
Button IncreaseButton
Button DecreaseButton
Button MinimumButton
Button MaximumButton

Button HitButton
Button StandButton

Button PlayButton
Button LeaveButton

Group UI
	Blackjack:Display Property Display Auto Const Mandatory
	UI:ButtonMenu Property ButtonMenu Auto Const Mandatory
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
	Caps = Game.GetCaps()

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

	PlayButton = new Button
	PlayButton.Text = "Play Again"
	PlayButton.KeyCode = Keyboard.E

	LeaveButton = new Button
	LeaveButton.Text = "Leave"
	LeaveButton.KeyCode = Keyboard.Tab
EndEvent


Event Games:Shared:UI:ButtonMenu.OnSelected(UI:ButtonMenu akSender, var[] arguments)
	akSender.UnregisterForSelectedEvent(self)
	WriteUnexpected(self, "OnSelected", "Unregistered for event in the '"+StateName+"' state.")
EndEvent


; States
;---------------------------------------------

State Starting
	Event OnState()
		Wager = WagerMinimum

		Display.Open()
		Display.Score = 0
		Display.Bet = Wager
		Display.Caps = Bank
		Display.Earnings = Earnings

		parent.OnState()
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
	Event OnState()
		If (Bank < WagerMinimum)
			; TODO: How/Should I quit here?
			WriteUnexpectedValue(self, "Wagering.OnState", "Bank", "A bank of "+Bank+" cannot be less than the wager minimum of "+WagerMinimum)
		EndIf

		If (Wager > Bank)
			Wager = WagerMinimum
			WriteUnexpectedValue(self, "Wagering.OnState", "Wager", "A wager of "+Wager+" cannot be greater than a bank of "+Bank)
		EndIf

		Display.Score = 0
		Display.Bet = Wager ; last wager amount
		Display.Earnings = Earnings
		Display.Caps = Bank
		parent.OnState()
		Display.Earnings = Earnings
	EndEvent

	int Function IWager()
		ButtonMenu.Clear()
		ButtonMenu.SelectOnce = false
		ButtonMenu.Add(AcceptButton)
		ButtonMenu.Add(IncreaseButton)
		ButtonMenu.Add(DecreaseButton)
		ButtonMenu.Add(MinimumButton)
		ButtonMenu.Add(MaximumButton)
		ButtonMenu.Add(LeaveButton)
		ButtonMenu.RegisterForSelectedEvent(self)
		ButtonMenu.Show()
		return Wager
	EndFunction

	Event Games:Shared:UI:ButtonMenu.OnSelected(UI:ButtonMenu akSender, var[] arguments)
		If (arguments)
			Button selected = akSender.GetSelectedEventArgs(arguments)

			If (selected == AcceptButton)
				If (IsValidWager(Wager))
					akSender.UnregisterForSelectedEvent(self)
					akSender.Hide()
					Player.RemoveItem(Caps, Wager, true)
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
				WriteUnexpected(self, "Wagering.OnSelected", "The selected wager button '"+selected+"' was unhandled in the '"+StateName+"' state.")
			EndIf
		Else
			WriteUnexpectedValue(self, "Wagering.OnSelected", "arguments", "The arguments are null or empty.")
		EndIf
	EndEvent
EndState


State Dealing
	Event OnState()
		parent.OnState()
		Display.Score = Score
	EndEvent
EndState


State Playing
	Event OnTurn(int aTurn)
		Display.Score = Score
	EndEvent

	int Function IChoice()
		ButtonMenu.Clear()
		ButtonMenu.SelectOnce = true
		ButtonMenu.Add(HitButton)
		ButtonMenu.Add(StandButton)
		ButtonMenu.Show()

		If (ButtonMenu.Selected)
			If (ButtonMenu.Selected == HitButton)
				return ChoiceHit
			ElseIf (ButtonMenu.Selected == StandButton)
				return ChoiceStand
			Else
				WriteUnexpected(self, "Playing.IChoice", "The selected choice button '"+ButtonMenu.Selected+"' was unhandled in the '"+StateName+"' state.")
				return Invalid
			EndIf
		Else
			WriteUnexpected(self, "Playing.IChoice", "No choice button was selected.")
			return Invalid
		EndIf
	EndFunction
EndState


State Scoring
	Event OnState()
		parent.OnState()
		Player.AddItem(Caps, Winnings, true)
		Display.Earnings = Earnings
		Display.Caps = Bank

		; TODO: Add UI element for match results.
		Game.ShowPerkVaultBoyOnHUD("Components\\VaultBoys\\Perks\\PerkClip_Default.swf")

		ButtonMenu.Clear()
		ButtonMenu.SelectOnce = true
		ButtonMenu.Add(PlayButton)
		ButtonMenu.Add(LeaveButton)
		ButtonMenu.Show()

		If (ButtonMenu.Selected)
			If (ButtonMenu.Selected == PlayButton)
				Rematch(true)
			ElseIf (ButtonMenu.Selected == LeaveButton)
				Rematch(false)
			Else
				WriteUnexpected(self, "Scoring.OnState", "The selected button '"+ButtonMenu.Selected+"' was unhandled in the '"+StateName+"' state.")
				Rematch(false)
			EndIf
		Else
			WriteUnexpected(self, "Scoring.OnState", "No button hint was selected.")
			Rematch(false)
		EndIf
	EndEvent
EndState


State Exiting
	Event OnState()
		Display.Close()
		parent.OnState()
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
