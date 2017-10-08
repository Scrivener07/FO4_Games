ScriptName Games:Blackjack:Players:Human extends Games:Blackjack:Player
import Games
import Games:Blackjack
import Games:Papyrus:Log
import Games:Shared
import Games:Shared:UI:ButtonHint

Actor PlayerRef


Button AcceptButton
Button IncreaseButton
Button DecreaseButton

Button HitButton
Button StandButton

Button YesButton
Button NoButton


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

	HitButton = new Button
	HitButton.Text = "Hit"
	HitButton.KeyCode = Keyboard.W

	StandButton = new Button
	StandButton.Text = "Stand"
	StandButton.KeyCode = Keyboard.S

	YesButton = new Button
	YesButton.Text = "Yes"
	YesButton.KeyCode = Keyboard.E

	NoButton = new Button
	NoButton.Text = "No"
	NoButton.KeyCode = Keyboard.Tab

	ButtonHint.RegisterForSelectedEvent(self)
EndEvent


Event Games:Shared:UI:ButtonHint.OnSelected(UI:ButtonHint akSender, var[] arguments)
	akSender.Hide()
EndEvent


; Object
;---------------------------------------------

State Starting
	Event SetMarkers(MarkerValue set)
		set.Card01 = Games_Blackjack_P1C01
		set.Card02 = Games_Blackjack_P1C02
		set.Card03 = Games_Blackjack_P1C03
		set.Card04 = Games_Blackjack_P1C04
		set.Card05 = Games_Blackjack_P1C05
		set.Card06 = Games_Blackjack_P1C06
		set.Card07 = Games_Blackjack_P1C07
		set.Card08 = Games_Blackjack_P1C08
		set.Card09 = Games_Blackjack_P1C09
		set.Card10 = Games_Blackjack_P1C10
		set.Card11 = Games_Blackjack_P1C11
	EndEvent
EndState


State Wagering
	Event SetWager(WagerValue set)
		ButtonHint.Clear()
		ButtonHint.SelectOnce = false
		ButtonHint.Add(AcceptButton)
		ButtonHint.Add(IncreaseButton)
		ButtonHint.Add(DecreaseButton)
		ButtonHint.Show()

		Game.RemovePlayerCaps(Bet)
	EndEvent

	Event Games:Shared:UI:ButtonHint.OnSelected(UI:ButtonHint akSender, var[] arguments)
		Button selected = akSender.GetSelectedEventArgs(arguments)
		If (selected == AcceptButton)
			akSender.Hide()
		ElseIf (selected == IncreaseButton)
			IncreaseWager(5)
			ITMBottlecapsDownx.Play(Player)
		ElseIf (selected == DecreaseButton)
			DecreaseWager(5)
			ITMBottlecapsUpx.Play(Player)
		EndIf
	EndEvent
EndState



State Playing
	Event SetChoice(ChoiceValue set)
		ButtonHint.Clear()
		ButtonHint.SelectOnce = true
		ButtonHint.Add(HitButton)
		ButtonHint.Add(StandButton)

		ButtonHint.Show()
		If (ButtonHint.Selected)
			If (ButtonHint.Selected == HitButton)
				set.Selected = ChoiceHit
			ElseIf (ButtonHint.Selected == StandButton)
				set.Selected = ChoiceStand
			Else
				set.Selected = Invalid
				WriteLine(self, "The play choice was invalid.")
			EndIf
		Else
			WriteLine(self, "No play choice was selected.")
		EndIf
	EndEvent
EndState


State Scoring
	Event ScoreBegin()
		ButtonHint.Clear()
		ButtonHint.SelectOnce = true
		ButtonHint.Add(YesButton)
		ButtonHint.Add(NoButton)

		ButtonHint.Show()
		If (ButtonHint.Selected)
			If (ButtonHint.Selected == YesButton)
				; See: Game.psc @Dialog.PlayAgain()
			ElseIf (ButtonHint.Selected == NoButton)
				; See: Game.psc @Dialog.PlayAgain()
			Else
				; derp
			EndIf
		Else
			WriteLine(self, "No play choice was selected.")
		EndIf
	EndEvent
EndState


; Player
;---------------------------------------------

int Function GetBank()
	return Player.GetGoldAmount()
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

