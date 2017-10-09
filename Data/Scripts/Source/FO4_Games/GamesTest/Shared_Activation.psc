ScriptName GamesTest:Shared_Activation extends GamesTest:Framework:Lilac
import Games
import Games:Papyrus:Log
import Games:Shared

; this was pulled from the Human.psc
; needs to be adapted into a testable unit.

; Events
;---------------------------------------------

Event OnInit()
	RegisterForCustomEvent(Activation, "OnSelected")
EndEvent


; Tasks
;---------------------------------------------

State Wagering
	Function Try()
		Activation.Show(Games_Blackjack_ActivateMenu, Games_Blackjack_Activate_Wager)
		; waits for result
	EndFunction

	Event Games:Shared:Activation.OnSelected(Shared:Activation akSender, var[] arguments)
		If (akSender.Menu == Games_Blackjack_Activate_Wager)
			; |   [3]   |
			; | [2] [1] |
			; |   [0]   |
			int OptionAccept = 0 const
			int OptionDecrease = 1 const
			int OptionIncrease = 2 const

			int value = 5 const

			If (akSender.Selected == OptionIncrease)
				; IncreaseWager(value)
			EndIf

			If (akSender.Selected == OptionDecrease)
				; DecreaseWager(value)
			EndIf

			If (akSender.Selected == OptionAccept)
				; akSender.Accept()
			EndIf
		EndIf
	EndEvent
EndState


State Playing
	Function Try()
		Activation.Show(Games_Blackjack_ActivateMenu, Games_Blackjack_Activate_Turn)
		int result = Activation.Selected
	EndFunction

	Event Games:Shared:Activation.OnSelected(Shared:Activation akSender, var[] arguments)
		If (akSender.Menu == Games_Blackjack_Activate_Turn)
			akSender.Accept()
		EndIf
	EndEvent
EndState


State Scoring
	Function Try()
		Activation.Show(Games_Blackjack_ActivateMenu, Games_Blackjack_Activate_Replay)
		int OptionNo = 0 const
		int OptionYes = 1 const

		If (Activation.Selected == OptionNo)
			WriteMessage(self, "Selected", "Replay No")
			; TODO: does nothing
		EndIf

		If (Activation.Selected == OptionYes)
			WriteMessage(self, "Selected", "Replay Yes")
			; TODO: does nothing
		EndIf
	EndFunction

	Event Games:Shared:Activation.OnSelected(Shared:Activation akSender, var[] arguments)
		If (akSender.Menu == Games_Blackjack_Activate_Replay)
			akSender.Accept()
		EndIf
	EndEvent
EndState


Function Try()
	{EMPTY}
EndFunction

Event Games:Shared:Activation.OnSelected(Shared:Activation akSender, var[] arguments)
	{EMPTY}
EndEvent


; Properties
;---------------------------------------------

Group Activation
	Shared:Activation Property Activation Auto Const Mandatory

	ObjectReference Property Games_Blackjack_ActivateMenu Auto Const Mandatory
	Perk Property Games_Blackjack_Activate_Replay Auto Const Mandatory
	Perk Property Games_Blackjack_Activate_Turn Auto Const Mandatory
	Perk Property Games_Blackjack_Activate_Wager Auto Const Mandatory
EndGroup
