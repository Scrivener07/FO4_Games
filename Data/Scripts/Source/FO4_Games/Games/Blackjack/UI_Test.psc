ScriptName Games:Blackjack:UI_Test extends Games:Shared:UI:Display Default
import Games
import Games:Papyrus:Log


; Display
;---------------------------------------------

Event OnDisplayData(DisplayData display)
	display.Menu = "HUDMenu"
	display.Asset = "Untitled.swf"
	WriteLine(self, "OnDisplayData:"+display)
EndEvent


Event OnDisplayLoaded()
	RegisterForKey(Keyboard.J)
	RegisterForKey(Keyboard.K)
	RegisterForKey(Keyboard.L)
EndEvent


; Events
;---------------------------------------------

Event OnKeyDown(int keyCode)
	If (keyCode == Keyboard.J)
		Data()
		WriteLine(self, "Data")
	EndIf

	If (keyCode == Keyboard.K)
		Load()
		WriteLine(self, "Load")
	EndIf

	If (keyCode == Keyboard.L)
		WriteNotification(self, "You pressed the L key on the keyboard.")
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Test
	Shared:Keyboard Property Keyboard Auto Const Mandatory
EndGroup
