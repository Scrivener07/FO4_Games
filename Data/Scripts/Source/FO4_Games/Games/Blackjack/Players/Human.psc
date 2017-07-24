ScriptName Games:Blackjack:Players:Human extends Games:Blackjack:Player
import Games:Shared
import Games:Shared:Common

Actor PlayerRef


; Events
;---------------------------------------------

Event OnInit()
	parent.OnInit()
	PlayerRef = Game.GetPlayer()
	RegisterForCustomEvent(Activation, "OnSelected")
	RegisterForPhaseEvent(Blackjack)
EndEvent


Event OnGamePhase(PhaseEventArgs e)
	If (e.Change == Begun)
		;
	Else
		Activation.Accept()
	EndIf
EndEvent


Event Games:Shared:Tasks:Activation.OnSelected(Tasks:Activation akSender, var[] arguments)
	{EMPTY}
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
		Activation.Show(Games_Blackjack_ActivateMenu, Games_Blackjack_Activate_Wager)
		Game.RemovePlayerCaps(Bet)
	EndEvent

	Event Games:Shared:Tasks:Activation.OnSelected(Tasks:Activation akSender, var[] arguments)
		If (akSender.Menu == Games_Blackjack_Activate_Wager)
			; |   [3]   |
			; | [2] [1] |
			; |   [0]   |
			int OptionAccept = 0 const
			int OptionDecrease = 1 const
			int OptionIncrease = 2 const

			int value = 5 const

			If (akSender.Selected == OptionIncrease)
				IncreaseWager(value)
			EndIf

			If (akSender.Selected == OptionDecrease)
				DecreaseWager(value)
			EndIf

			If (akSender.Selected == OptionAccept)
				akSender.Accept()
			EndIf
		EndIf
	EndEvent
EndState



State Playing
	Event SetChoice(ChoiceValue set)
		set.Selected = Invalid
		Activation.Show(Games_Blackjack_ActivateMenu, Games_Blackjack_Activate_Turn)

		set.Selected = Activation.Selected
	EndEvent

	Event Games:Shared:Tasks:Activation.OnSelected(Tasks:Activation akSender, var[] arguments)
		If (akSender.Menu == Games_Blackjack_Activate_Turn)
			akSender.Accept()
		EndIf
	EndEvent
EndState


State Scoring
	Event ScoreBegin()
		Activation.Show(Games_Blackjack_ActivateMenu, Games_Blackjack_Activate_Replay)

		int OptionNo = 0 const
		int OptionYes = 1 const

		If (Activation.Selected == OptionNo)
			WriteMessage("Selected", "Replay No")
			; TODO: does nothing
		EndIf

		If (Activation.Selected == OptionYes)
			WriteMessage("Selected", "Replay Yes")
			; TODO: does nothing
		EndIf
	EndEvent


	Event Games:Shared:Tasks:Activation.OnSelected(Tasks:Activation akSender, var[] arguments)
		If (akSender.Menu == Games_Blackjack_Activate_Replay)
			akSender.Accept()
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

Group Activation
	Tasks:Activation Property Activation Auto Const Mandatory

	ObjectReference Property Games_Blackjack_ActivateMenu Auto Const Mandatory
	Perk Property Games_Blackjack_Activate_Replay Auto Const Mandatory
	Perk Property Games_Blackjack_Activate_Turn Auto Const Mandatory
	Perk Property Games_Blackjack_Activate_Wager Auto Const Mandatory
EndGroup
