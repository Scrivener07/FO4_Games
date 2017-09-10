ScriptName Games:Blackjack:Dialog extends Games:Blackjack:Task
import Games:Papyrus:Log

; Options
;---------------------------------------------

bool Function PlayGame()
	int selected = Games_Blackjack_MessagePlay.Show()
	int OptionExit = 0 const
	int OptionStart = 1 const

	If (selected == OptionStart)
		return true

	ElseIf (selected == OptionExit || selected == Invalid)
		WriteLine(self, "Chose not to play Blackjack.")
		return false
	Else
		WriteLine(self, "The option '"+selected+"' is unhandled.")
		return false
	EndIf
EndFunction


bool Function PlayAgain()
	return Games_Blackjack_MessagePlayAgain.Show() == 1
EndFunction


; Messages
;---------------------------------------------

Function ShowKicked()
	; dummy for `Message`
	WriteMessage("Kicked", "Your all out of caps. Better luck next time.")
EndFunction


; int Function PromptWager()
; 	int selected = Games_Blackjack_MessageWager.Show(Human.Caps, Human.Winnings)
; 	int OptionExit = 0 const
; 	int OptionWager1 = 1 const
; 	int OptionWager5 = 2 const
; 	int OptionWager10 = 3 const
; 	int OptionWager20 = 4 const
; 	int OptionWager50 = 5 const
; 	int OptionWager100 = 6 const

; 	If (selected == OptionExit || selected == Invalid)
; 		return Invalid
; 	ElseIf (selected == OptionWager1)
; 		return 1
; 	ElseIf (selected == OptionWager5)
; 		return 5
; 	ElseIf (selected == OptionWager10)
; 		return 10
; 	ElseIf (selected == OptionWager20)
; 		return 20
; 	ElseIf (selected == OptionWager50)
; 		return 50
; 	ElseIf (selected == OptionWager100)
; 		return 100
; 	Else
; 		WriteLine(self, "The option '"+selected+"' is unhandled.")
; 		return Invalid
; 	EndIf
; EndFunction


; int Function ShowTurn(float card1, float card2, float score)
; 	return Games_Blackjack_MessageTurn.Show(card1, card2, score)
; EndFunction


; int Function ShowTurnDealt(float card, float score)
; 	return Games_Blackjack_MessageTurnDealt.Show(card, score)
; EndFunction


; Properties
;---------------------------------------------

Group HUD
	Message Property Games_Blackjack_MessageWager Auto Const Mandatory
	Message Property Games_Blackjack_MessageTurn Auto Const Mandatory
	Message Property Games_Blackjack_MessageTurnDealt Auto Const Mandatory
	Message Property Games_Blackjack_MessagePlay Auto Const Mandatory
	Message Property Games_Blackjack_MessagePlayAgain Auto Const Mandatory
	Message Property Games_Blackjack_MessageWin Auto Const Mandatory
	Message Property Games_Blackjack_MessageBust Auto Const Mandatory
EndGroup
