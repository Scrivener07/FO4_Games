ScriptName GamesTest:SharedUI_Display extends Games:Shared:UI:Display
import Games
import Games:Papyrus:Log


; Display
;---------------------------------------------

Event OnDisplayData(DisplayData display)
	display.Menu = "PipboyMenu"
	display.Asset = "Dummy.swf"
	; display.Root = "root1.BottomCenterGroup_mc.CompassWidget_mc"
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
		UI.Invoke(Menu, GetMember("BringToFront"))
		WriteNotification(self, "You pressed the L key on the keyboard.")
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Test
	Shared:Keyboard Property Keyboard Auto Const Mandatory
EndGroup
