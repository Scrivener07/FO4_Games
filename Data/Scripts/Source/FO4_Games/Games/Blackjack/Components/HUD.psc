ScriptName Games:Blackjack:Components:HUD extends Games:Blackjack:Component
import Games
import Games:Blackjack
import Games:Shared:Common
import Games:Shared:Deck


; Widget
;---------------------------------------------

Function Widget()
	Display.Widget()
EndFunction


Function Register()
	Display.Register()
EndFunction


Function Load()
	Display.Load()
EndFunction


Function Unload()
	Display.Unload()
EndFunction


; Methods
;---------------------------------------------

Function Update(Player gambler)
	; TODO: TEMP ONLY
	PlayerName = gambler.Name
	PlayerScore = gambler.Score
	PlayerBet = gambler.Wager
	PlayerCaps = gambler.Caps
	PlayerEarnings = gambler.Winnings
EndFunction


; Properties
;---------------------------------------------

Group Object
	Blackjack:Game Property Blackjack Auto Const Mandatory
EndGroup


Group HUD
	HUD:Display Property Display Auto Const Mandatory

	string Property Phase Hidden
		Function Set(string value)
			Display.Phase = value
		EndFunction
	EndProperty

	string Property Text Hidden
		Function Set(string value)
			Display.Turn = value
		EndFunction
	EndProperty


	string Property PlayerName Hidden
		Function Set(string value)
			Display.Name = value
		EndFunction
	EndProperty


	int Property PlayerScore Hidden
		Function Set(int value)
			Display.Score = value
		EndFunction
	EndProperty


	int Property PlayerBet Hidden
		Function Set(int value)
			Display.Bet = value
		EndFunction
	EndProperty


	int Property PlayerCaps Hidden
		Function Set(int value)
			Display.Caps = value
		EndFunction
	EndProperty


	int Property PlayerEarnings Hidden
		Function Set(int value)
			Display.Earnings = value
		EndFunction
	EndProperty
EndGroup
