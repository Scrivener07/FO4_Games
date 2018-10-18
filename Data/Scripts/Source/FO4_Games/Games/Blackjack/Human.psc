ScriptName Games:Blackjack:Human extends Games:Blackjack:Players:Object
import Games
import Games:Shared
import Games:Shared:Deck
import Games:Shared:Log
import Games:Shared:Papyrus
import Games:Shared:UI:ButtonMenu
import Games:Blackjack:Players:Hand

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


; Events
;---------------------------------------------

Event OnQuestInit()
	parent.OnQuestInit()
	PlayerRef = Game.GetPlayer()
	Caps = Game.GetCaps()

	Hand.Markers = new Marker
	Hand.Markers.Delay = 0.75
	Hand.Markers.Transition = GamesBlackjack_DeckMarkerB
	Hand.Markers.Card01 = GamesBlackjack_PlayerCard01
	Hand.Markers.Card02 = GamesBlackjack_PlayerCard02
	Hand.Markers.Card03 = GamesBlackjack_PlayerCard03
	Hand.Markers.Card04 = GamesBlackjack_PlayerCard04
	Hand.Markers.Card05 = GamesBlackjack_PlayerCard05
	Hand.Markers.Card06 = GamesBlackjack_PlayerCard06
	Hand.Markers.Card07 = GamesBlackjack_PlayerCard07
	Hand.Markers.Card08 = GamesBlackjack_PlayerCard08
	Hand.Markers.Card09 = GamesBlackjack_PlayerCard09
	Hand.Markers.Card10 = GamesBlackjack_PlayerCard10
	Hand.Markers.Card11 = GamesBlackjack_PlayerCard11

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


Event Games:Shared:UI:ButtonMenu.OnSelected(UI:ButtonMenu sender, var[] arguments)
	sender.UnregisterForSelectedEvent(self)
	WriteUnexpected(ToString(), "OnSelected", "Unregistered for event in the '"+StateName+"' state.")
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
			WriteLine(ToString(), "A wager of "+Wager+" cannot be greater than a bank of "+Bank+". Resetting wager to "+WagerMinimum)
			Wager = WagerMinimum
		EndIf
		Display.Score = 0
		Display.Bet = Wager
		Display.Caps = Bank
		Display.Earnings = Earnings
		parent.OnState()
	EndEvent

	Function WagerSet(IntegerValue setter)
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
		setter.Value = Wager
	EndFunction

	Event Games:Shared:UI:ButtonMenu.OnSelected(UI:ButtonMenu sender, var[] arguments)
		If (arguments)
			Button selected = sender.GetSelectedEventArgs(arguments)

			If (selected == AcceptButton)
				If (IsValidWager(Wager))
					sender.UnregisterForSelectedEvent(self)
					sender.Hide()
				Else
					Games_Shared_ButtonMenu_Cancel_SFX.Play(Player)
				EndIf
			ElseIf (selected == LeaveButton)
				Quit()
				sender.UnregisterForSelectedEvent(self)
				sender.Hide()
			Else
				int value = Invalid
				If (selected == IncreaseButton)
					value = Wager + WagerStep
					If (IsValidWager(value) && value != Wager)
						Wager = value
						Display.Bet = value
						Games_Blackjack_WagerIncrease_SFX.Play(Player)
					Else
						Games_Shared_ButtonMenu_Cancel_SFX.Play(Player)
					EndIf
				ElseIf (selected == DecreaseButton)
					value = Wager - WagerStep
					If (IsValidWager(value) && value != Wager)
						Wager = value
						Display.Bet = value
						Games_Blackjack_WagerDecrease_SFX.Play(Player)
					Else
						Games_Shared_ButtonMenu_Cancel_SFX.Play(Player)
					EndIf
				ElseIf (selected == MinimumButton)
					If (IsValidWager(WagerMinimum) && WagerMinimum != Wager)
						Wager = WagerMinimum
						Display.Bet = Wager
						Games_Blackjack_WagerMinimum_SFX.Play(Player)
					Else
						Games_Shared_ButtonMenu_Cancel_SFX.Play(Player)
					EndIf
				ElseIf (selected == MaximumButton)
					If (IsValidWager(WagerMaximum) && WagerMaximum != Wager)
						Wager = WagerMaximum
						Display.Bet = Wager
						Games_Blackjack_WagerMaximum_SFX.Play(Player)
					Else
						Games_Shared_ButtonMenu_Cancel_SFX.Play(Player)
					EndIf
				Else
					WriteUnexpectedValue(ToString(), "Wagering.OnSelected", "selected", "The selected button '"+selected+"' was unhandled.")
				EndIf
			EndIf
		Else
			WriteUnexpectedValue(ToString(), "Wagering.OnSelected", "arguments", "The arguments are null or empty.")
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
	Event OnTurn(BooleanValue continue)
		parent.OnTurn(continue)
		Display.Score = Score
		Display.Bet = Bet
	EndEvent

	Function ChoiceSet(IntegerValue setter)
		ButtonMenu.Clear()
		ButtonMenu.SelectOnce = true
		ButtonMenu.Add(HitButton)
		ButtonMenu.Add(StandButton)

		If (Turn == 1)
			int double = Bet * 2
			If (IsValidWager(double))
				DoubleButton.Text = "Double Down ("+double+")"
				ButtonMenu.Add(DoubleButton)
			EndIf
		EndIf

		ButtonMenu.Show()
		If (ButtonMenu.Selected)
			If (ButtonMenu.Selected == HitButton)
				setter.Value = ChoiceHit
			ElseIf (ButtonMenu.Selected == StandButton)
				setter.Value = ChoiceStand
			ElseIf (ButtonMenu.Selected == DoubleButton)
				setter.Value = ChoiceDouble
			Else
				WriteUnexpectedValue(ToString(), "Playing.ChoiceSet", "ButtonMenu.Selected", "The selected choice button '"+ButtonMenu.Selected+"' was unhandled in the '"+StateName+"' state.")
				setter.Value = Invalid
			EndIf
		Else
			WriteUnexpectedValue(ToString(), "Playing.ChoiceSet", "ButtonMenu.Selected", "No choice button was selected.")
			setter.Value = Invalid
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
				WriteLine(ToString(), "Selected the play button.")
			ElseIf (ButtonMenu.Selected == LeaveButton)
				Quit()
			Else
				WriteUnexpectedValue(ToString(), "Scoring.OnState", "ButtonMenu.Selected", "The selected button '"+ButtonMenu.Selected+"' was unhandled in the '"+StateName+"' state.")
				Quit()
			EndIf
		Else
			WriteUnexpectedValue(ToString(), "Scoring.OnState", "ButtonMenu.Selected", "No button hint was selected.")
			Quit()
		EndIf
	EndEvent

	Event OnScoring(int scoring)
		parent.OnScoring(scoring)

		If (scoring == Invalid)
			return
		ElseIf (scoring == ScorePush)
			Game.ShowPerkVaultBoyOnHUD(PushFX, Games_Blackjack_ScoringPush_SFX)
		ElseIf (scoring == ScoreLose)
			Game.ShowPerkVaultBoyOnHUD(LoseFX, Games_Blackjack_ScoringLose_SFX)
			Player.RemoveItem(Caps, Debt, true)
		ElseIf (scoring == ScoreWin)
			Game.ShowPerkVaultBoyOnHUD(WinFX, Games_Blackjack_ScoringWin_SFX)
			Player.AddItem(Caps, Debt, true)
		ElseIf (scoring == ScoreBlackjack)
			Game.ShowPerkVaultBoyOnHUD(BlackjackFX, Games_Blackjack_ScoringBlackjack_SFX)
			Player.AddItem(Caps, Debt, true)
		Else
			WriteUnexpectedValue(ToString(), "OnScoring", "scoring", "Scoring of "+scoring+" was unhandled.")
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


; Methods
;---------------------------------------------

; @Override
int Function GetBank()
	{The amount of caps the player has to gamble with.}
	return Player.GetGoldAmount()
EndFunction


; Properties
;---------------------------------------------

Group UI
	Blackjack:Display Property Display Auto Const Mandatory
	UI:ButtonMenu Property ButtonMenu Auto Const Mandatory
	Shared:Keyboard Property Keyboard Auto Const Mandatory
EndGroup

Group SFX
	Sound Property Games_Blackjack_WagerIncrease_SFX Auto Const Mandatory
	Sound Property Games_Blackjack_WagerDecrease_SFX Auto Const Mandatory
	Sound Property Games_Blackjack_WagerMinimum_SFX Auto Const Mandatory
	Sound Property Games_Blackjack_WagerMaximum_SFX Auto Const Mandatory
	Sound Property Games_Blackjack_ScoringLose_SFX Auto Const Mandatory
	Sound Property Games_Blackjack_ScoringWin_SFX Auto Const Mandatory
	Sound Property Games_Blackjack_ScoringBlackjack_SFX Auto Const Mandatory
	Sound Property Games_Blackjack_ScoringPush_SFX Auto Const Mandatory
	Sound Property Games_Shared_ButtonMenu_Cancel_SFX Auto Const Mandatory
EndGroup

Group Player
	Actor Property Player Hidden
		Actor Function Get()
			return PlayerRef
		EndFunction
	EndProperty
EndGroup

Group Marker
	ObjectReference Property GamesBlackjack_DeckMarkerB Auto Const Mandatory
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
