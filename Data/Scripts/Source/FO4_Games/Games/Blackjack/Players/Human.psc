ScriptName Games:Blackjack:Players:Human extends Games:Blackjack:Player
import Games:Blackjack
import Games:Papyrus:Log
import Games:Shared
import Games:Shared:UI:ButtonHint

Actor PlayerRef

int W = 87 const ; test key
int A = 65 const ; test key
int S = 83 const ; test key
int D = 68 const ; test key

Group ButtonHint
	UI:ButtonHint Property ButtonHint Auto Const Mandatory
EndGroup


Event Games:Shared:UI:ButtonHint.OnSelected(Games:Shared:UI:ButtonHint akSender, var[] arguments)
	{EMPTY}
EndEvent



; Events
;---------------------------------------------

Event OnInit()
	parent.OnInit()
	PlayerRef = Game.GetPlayer()
	RegisterForPhaseEvent(Blackjack)
	RegisterForCustomEvent(ButtonHint, "OnSelected")
EndEvent


Event OnGamePhase(PhaseEventArgs e)
	If (e.Change == Begun)
		;
	Else
		; Activation.Accept()
	EndIf
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

		; delete the following..
		int E = 69 const ; test key

		Button AcceptButton = new Button
		AcceptButton.Text = "Hello World"
		AcceptButton.KeyCode = E

		ButtonHint.SetButton(AcceptButton)
		ButtonHint.Show() ; waits for thread
	EndEvent
EndState


State Wagering
	Event SetWager(WagerValue set)
		int E = 69 const ; test key
		int R = 82 const ; test key
		int T = 84 const ; test key

		Button AcceptButton = new Button
		AcceptButton.Text = "Accept"
		AcceptButton.KeyCode = E

		Button IncreaseButton = new Button
		IncreaseButton.Text = "Increase"
		IncreaseButton.KeyCode = D

		Button DecreaseButton = new Button
		DecreaseButton.Text = "Increase"
		DecreaseButton.KeyCode = A

		Button[] array = new Button[0]
		array.Add(AcceptButton)
		array.Add(IncreaseButton)
		array.Add(DecreaseButton)

		ButtonHint.SetButtons(array)
		ButtonHint.Show() ; waits for thread

		Game.RemovePlayerCaps(Bet) ; set by button selected event during wait
	EndEvent
EndState



State Playing
	Event SetChoice(ChoiceValue set)
		set.Selected = Invalid

	EndEvent
EndState


State Scoring
	Event ScoreBegin()
		; Prompt to play again. (yes/no)

		Button HitButton = new Button
		HitButton.Text = "Hit"
		HitButton.KeyCode = D

		Button StandButton = new Button
		StandButton.Text = "Stand"
		StandButton.KeyCode = A

		Button[] array = new Button[0]
		array.Add(HitButton)
		array.Add(StandButton)

		ButtonHint.SetButtons(array)
		ButtonHint.Show() ; waits for thread
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
