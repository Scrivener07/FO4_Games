ScriptName Games:Blackjack:Players:Human extends Games:Blackjack:Player
import Games:Shared
import Games:Papyrus:Log
import Games:Blackjack:UI:Choice

Actor PlayerRef

int W = 87 const ; test key
int A = 65 const ; test key
int S = 83 const ; test key
int D = 68 const ; test key
int E_Key = 69 const ; test key
int R = 82 const ; test key
int T = 84 const ; test key



Function WageringButtons()
	Button AcceptButton = new Button
	AcceptButton.Text = "Accept"
	AcceptButton.KeyCode = E_Key
	AcceptButton.PC = "E"
	AcceptButton.PSN = "PSN_A"
	AcceptButton.Xenon = "Xenon_A"

	Button IncreaseButton = new Button
	IncreaseButton.Text = "Increase"
	IncreaseButton.KeyCode = D
	IncreaseButton.PC = "D"
	IncreaseButton.PSN = "PSN_L2"
	IncreaseButton.Xenon = "Xenon_L2"

	Button DecreaseButton = new Button
	DecreaseButton.Text = "Increase"
	DecreaseButton.KeyCode = A
	DecreaseButton.PC = "A"
	DecreaseButton.PSN = "PSN_R2"
	DecreaseButton.Xenon = "Xenon_R2"

	Button[] array = new Button[0]
	array.Add(AcceptButton)
	array.Add(IncreaseButton)
	array.Add(DecreaseButton)

	Menu.SetButtons(array)
EndFunction



; hit
; stand
Function PlayingButtons()
	Button HitButton = new Button
	HitButton.Text = "Hit"
	HitButton.KeyCode = A
	HitButton.PC = "A"
	HitButton.PSN = "PSN_R2"
	HitButton.Xenon = "Xenon_R2"

	Button StandButton = new Button
	StandButton.Text = "Stand"
	StandButton.KeyCode = A
	StandButton.PC = "A"
	StandButton.PSN = "PSN_R2"
	StandButton.Xenon = "Xenon_R2"

	Button[] array = new Button[0]
	array.Add(HitButton)
	array.Add(StandButton)

	Menu.SetButtons(array)
EndFunction



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


; Event Games:Shared:Tasks:Activation.OnSelected(Tasks:Activation akSender, var[] arguments)
; 	{EMPTY}
; EndEvent


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

	; Event Games:Shared:Tasks:Activation.OnSelected(Tasks:Activation akSender, var[] arguments)
	; 	If (akSender.Menu == Games_Blackjack_Activate_Wager)
	; 		; |   [3]   |
	; 		; | [2] [1] |
	; 		; |   [0]   |
	; 		int OptionAccept = 0 const
	; 		int OptionDecrease = 1 const
	; 		int OptionIncrease = 2 const

	; 		int value = 5 const

	; 		If (akSender.Selected == OptionIncrease)
	; 			IncreaseWager(value)
	; 		EndIf

	; 		If (akSender.Selected == OptionDecrease)
	; 			DecreaseWager(value)
	; 		EndIf

	; 		If (akSender.Selected == OptionAccept)
	; 			akSender.Accept()
	; 		EndIf
	; 	EndIf
	; EndEvent
EndState



State Playing
	Event SetChoice(ChoiceValue set)
		set.Selected = Invalid
		Activation.Show(Games_Blackjack_ActivateMenu, Games_Blackjack_Activate_Turn)

		set.Selected = Activation.Selected
	EndEvent

	; Event Games:Shared:Tasks:Activation.OnSelected(Tasks:Activation akSender, var[] arguments)
	; 	If (akSender.Menu == Games_Blackjack_Activate_Turn)
	; 		akSender.Accept()
	; 	EndIf
	; EndEvent
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


	; Event Games:Shared:Tasks:Activation.OnSelected(Tasks:Activation akSender, var[] arguments)
	; 	If (akSender.Menu == Games_Blackjack_Activate_Replay)
	; 		akSender.Accept()
	; 	EndIf
	; EndEvent
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

Group Menu
	Games:Blackjack:UI:Choice Property Menu Auto Const Mandatory
EndGroup
