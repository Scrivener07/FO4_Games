ScriptName Games:Blackjack:Display extends Games:Shared:UI:Display
import Games:Blackjack
import Games:Papyrus:Log
import Games:Papyrus:PointType


; Display
;---------------------------------------------

Event OnDisplayData(DisplayData display)
	display.Menu = "HUDMenu"
	display.Asset = "Blackjack.swf"
EndEvent


; Methods
;---------------------------------------------

; TODO: TEMP ONLY, LAZY
Function Player(Player value)
	Name = value.Name
	Score = value.Score
	Bet = value.Bet
	Caps = value.Caps
	Earnings = value.Winnings
EndFunction


; Properties
;---------------------------------------------

Group Game
	string Property Phase Hidden
		Function Set(string value)
			; SendText("100", value)
		EndFunction
	EndProperty

	string Property Text Hidden
		Function Set(string value)
			; SendText("200", value)
		EndFunction
	EndProperty
EndGroup

Group Dealer
	string Property DealerName Hidden
		Function Set(string value)
			; TODO: hookup property to as3
		EndFunction
	EndProperty

	int Property DealerScore Hidden
		Function Set(int value)
			; TODO: hookup property to as3
		EndFunction
	EndProperty

	int Property DealerBet Hidden
		Function Set(int value)
			; TODO: hookup property to as3
		EndFunction
	EndProperty

	int Property DealerCaps Hidden
		Function Set(int value)
			; TODO: hookup property to as3
		EndFunction
	EndProperty

	int Property DealerEarnings Hidden
		Function Set(int value)
			; TODO: hookup property to as3
		EndFunction
	EndProperty
EndGroup

Group Player
	string Property Name Hidden
		Function Set(string value)
			; SendText("300", value)
		EndFunction
	EndProperty

	int Property Score Hidden
		Function Set(int value)
			; SendText("400", value)
		EndFunction
	EndProperty

	int Property Bet Hidden
		Function Set(int value)
			; SendText("500", value)
		EndFunction
	EndProperty

	int Property Caps Hidden
		Function Set(int value)
			; SendText("600", value)
		EndFunction
	EndProperty

	int Property Earnings Hidden
		Function Set(int value)
			; SendText("700", value)
		EndFunction
	EndProperty
EndGroup


