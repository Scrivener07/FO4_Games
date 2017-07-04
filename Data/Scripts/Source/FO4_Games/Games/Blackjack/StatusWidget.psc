ScriptName Games:Blackjack:StatusWidget extends Games:Shared:Widgets:HUDWidget
import Games
import Games:Shared:Common
import Games:Shared:PointType

string WidgetID = "StatusWidget.swf" const
int Step = 10 const

; Keys
;...............
; UP 	38
; LEFT  37
; DOWN  40
; RIGHT 39
; Num8 	104
; Num2  98
; Num4  100
; Num6  102

int Up = 104 const
int Down = 98 const
int Left = 100 const
int Right = 102 const


; Widget
;---------------------------------------------

WidgetData Function Create()
	WidgetData widget = new WidgetData
	widget.ID = WidgetID
	widget.LoadNow = true
	widget.AutoLoad = true
	widget.X = 0
	widget.Y = 500
	return widget
EndFunction


Event OnLoaded()
	RegisterForKeys()
	WriteLine(self, "OnLoaded")
EndEvent


Event OnUnloaded()
	UnregisterForKeys()
	WriteLine(self, "OnUnloaded")
EndEvent


Event OnUpdated()
	SendText("100", Blackjack.Human.Wager)
	SendText("200", Blackjack.Human.Caps)
	SendText("300", Blackjack.Human.Winnings)
	SendText("400", Blackjack.Human.Score)
	SendText("500", Blackjack.GetState())
	WriteLine(self, "OnUpdated")
EndEvent


; Events
;---------------------------------------------

Event OnKeyDown(int keyCode)
	WriteNotification(self, "Pressed the '"+keyCode+"' key.")

	If (keyCode == Up)
		Position = PointAddition(Position, PointMultiply(Down(), Step))

	ElseIf (keyCode == Down)
		Position = PointAddition(Position, PointMultiply(Up(), Step))

	ElseIf (keyCode == Left)
		Position = PointAddition(Position, PointMultiply(Left(), Step))

	ElseIf (keyCode == Right)
		Position = PointAddition(Position, PointMultiply(Right(), Step))

	Else
		WriteNotification(self, "Unhandled key '"+keyCode+"' has been pressed.")
	EndIf
EndEvent


; Functions
;---------------------------------------------

Function RegisterForKeys()
	RegisterForKey(Up)
	RegisterForKey(Down)
	RegisterForKey(Left)
	RegisterForKey(Right)
EndFunction


Function UnregisterForKeys()
	UnregisterForKey(Up)
	UnregisterForKey(Down)
	UnregisterForKey(Left)
	UnregisterForKey(Right)
EndFunction


; Properties
;---------------------------------------------

Group Object
	Blackjack:Game Property Blackjack Auto Const Mandatory
EndGroup
