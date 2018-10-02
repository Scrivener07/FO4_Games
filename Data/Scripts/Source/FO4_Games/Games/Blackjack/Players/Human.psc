ScriptName Games:Blackjack:Players:Human extends Games:Blackjack:Player
import Games
import Games:Blackjack
import Games:Shared
import Games:Shared:Deck
import Games:Shared:Log
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
Button DoubleButton

Button PlayButton
Button LeaveButton

string LoseFX = "GamesBlackjackScoreLose.swf" const
string WinFX = "GamesBlackjackScoreWin.swf" const
string BlackjackFX = "GamesBlackjackScore21.swf" const
string PushFX = "GamesBlackjackScorePush.swf" const

Seat Seat1


; Events
;---------------------------------------------

Event OnQuestInit()
	parent.OnQuestInit()
	PlayerRef = Game.GetPlayer()
	Caps = Game.GetCaps()

	Seating = new Seat
	Seating.Card01 = GamesBlackjack_PlayerCard01
	Seating.Card01Reveal = Seating.Card01 ; same, same
	Seating.Card02 = GamesBlackjack_PlayerCard02
	Seating.Card03 = GamesBlackjack_PlayerCard03
	Seating.Card04 = GamesBlackjack_PlayerCard04
	Seating.Card05 = GamesBlackjack_PlayerCard05
	Seating.Card06 = GamesBlackjack_PlayerCard06
	Seating.Card07 = GamesBlackjack_PlayerCard07
	Seating.Card08 = GamesBlackjack_PlayerCard08
	Seating.Card09 = GamesBlackjack_PlayerCard09
	Seating.Card10 = GamesBlackjack_PlayerCard10
	Seating.Card11 = GamesBlackjack_PlayerCard11

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

	DoubleButton = new Button
	DoubleButton.Text = "Double Down"
	DoubleButton.KeyCode = Keyboard.D

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
		parent.OnState()
		Wager = WagerMinimum
		Display.Open()
		Display.Score = 0
		Display.Bet = Wager
		Display.Caps = Bank
		Display.Earnings = Earnings
	EndEvent
EndState


State Wagering
	Event OnState()
		If (Wager > Bank)
			WriteLine(self, "A wager of "+Wager+" cannot be greater than a bank of "+Bank+". Resetting wager to "+WagerMinimum)
			Wager = WagerMinimum
		EndIf

		Display.Score = 0
		Display.Bet = Wager
		Display.Caps = Bank
		Display.Earnings = Earnings

		parent.OnState()
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
				EndIf
			ElseIf (selected == LeaveButton)
				If (Quit())
					akSender.UnregisterForSelectedEvent(self)
					akSender.Hide()
				Else
					WriteUnexpected(self, "Wagering.OnSelected", "The request to leave the game failed for some reason.")
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

	Event OnDrawn(Card drawn, ObjectReference marker)
		Motion.Translate(drawn.Reference, Blackjack.Deck.GamesBlackjack_DeckMarkerB)
		Utility.Wait(0.75)
		parent.OnDrawn(drawn, marker)
	EndEvent
EndState


State Playing
	Event OnTurn(int number)
		Display.Score = Score
	EndEvent

	Event OnDrawn(Card drawn, ObjectReference marker)
		Motion.Translate(drawn.Reference, Blackjack.Deck.GamesBlackjack_DeckMarkerB)
		Utility.Wait(0.75)
		parent.OnDrawn(drawn, marker)
	EndEvent

	int Function IChoice()
		ButtonMenu.Clear()
		ButtonMenu.SelectOnce = true
		ButtonMenu.Add(HitButton)
		ButtonMenu.Add(StandButton)

		; TODO: WIP
		If (Turn == 1)
			ButtonMenu.Add(DoubleButton)
		EndIf

		ButtonMenu.Show()
		If (ButtonMenu.Selected)
			If (ButtonMenu.Selected == HitButton)
				return ChoiceHit
			ElseIf (ButtonMenu.Selected == StandButton)
				return ChoiceStand
			ElseIf (ButtonMenu.Selected == DoubleButton)
				return ChoiceDouble
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

		ButtonMenu.Clear()
		ButtonMenu.SelectOnce = true
		ButtonMenu.Add(PlayButton)
		ButtonMenu.Add(LeaveButton)
		ButtonMenu.Show()

		If (ButtonMenu.Selected)
			If (ButtonMenu.Selected == PlayButton)
				WriteLine(self, "Selected the play button.")
			ElseIf (ButtonMenu.Selected == LeaveButton)
				Quit()
			Else
				WriteUnexpected(self, "Scoring.OnState", "The selected button '"+ButtonMenu.Selected+"' was unhandled in the '"+StateName+"' state.")
				Quit()
			EndIf
		Else
			WriteUnexpected(self, "Scoring.OnState", "No button hint was selected.")
			Quit()
		EndIf
	EndEvent

	Event OnScoring(int scoring)
		parent.OnScoring(scoring)

		If (scoring == Invalid)
			return
		ElseIf (scoring == ScorePush)
			Game.ShowPerkVaultBoyOnHUD(PushFX)
		ElseIf (scoring == ScoreLose)
			Game.ShowPerkVaultBoyOnHUD(LoseFX)
			Player.RemoveItem(Caps, Debt, true)
		ElseIf (scoring == ScoreWin)
			Game.ShowPerkVaultBoyOnHUD(WinFX, UIExperienceUp)
			Player.AddItem(Caps, Debt, true)
		ElseIf (scoring == ScoreBlackjack)
			Game.ShowPerkVaultBoyOnHUD(BlackjackFX, UIExperienceUp)
			Player.AddItem(Caps, Debt, true)
		Else
			WriteUnexpected(self, "OnScoring", "Scoring of "+scoring+" was unhandled.")
		EndIf

		Display.Earnings = Earnings
		Display.Caps = Bank
	EndEvent
EndState


State Exiting
	Event OnState()
		Wager = 0
		Display.Close()
		parent.OnState()
	EndEvent
EndState


; Requests
;---------------------------------------------

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

Group UI
	Blackjack:Display Property Display Auto Const Mandatory
	UI:ButtonMenu Property ButtonMenu Auto Const Mandatory
	Shared:Keyboard Property Keyboard Auto Const Mandatory
EndGroup

Group SFX
	Sound Property ITMBottlecapsUpx Auto Const Mandatory
	Sound Property ITMBottlecapsDownx Auto Const Mandatory
	Sound Property UIExperienceUp Auto Const Mandatory
EndGroup

Group Player
	Actor Property Player Hidden
		Actor Function Get()
			return PlayerRef
		EndFunction
	EndProperty
EndGroup

Group Seat
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
