ScriptName Games:Blackjack:PlayerWidget extends Games:Shared:Widgets:HUDWidget
import Games
import Games:Shared:Common
import Games:Shared:PointType

string WidgetID = "PlayerWidget.swf" const
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
	widget.X = 920
	widget.Y = 480
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


Group Values
	string Property Name Hidden
		Function Set(string value)
			SendText("100", value)
		EndFunction
	EndProperty

	string Property Turn Hidden
		Function Set(string value)
			SendText("200", value)
		EndFunction
	EndProperty

	int Property Score Hidden
		Function Set(int value)
			SendText("300", value)
		EndFunction
	EndProperty

	int Property Bet Hidden
		Function Set(int value)
			SendText("400", value)
		EndFunction
	EndProperty

	int Property Earnings Hidden
		Function Set(int value)
			SendText("500", value)
		EndFunction
	EndProperty
EndGroup
