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


; Properties
;---------------------------------------------

Group Player
	int Property Score Hidden
		Function Set(int value)
			UI.Set(Menu, GetMember("Score"), value)
		EndFunction
	EndProperty

	int Property Bet Hidden
		Function Set(int value)
			UI.Set(Menu, GetMember("Bet"), value)
		EndFunction
	EndProperty

	int Property Caps Hidden
		Function Set(int value)
			UI.Set(Menu, GetMember("Caps"), value)
		EndFunction
	EndProperty

	int Property Earnings Hidden
		Function Set(int value)
			UI.Set(Menu, GetMember("Earnings"), value)
		EndFunction
	EndProperty
EndGroup
