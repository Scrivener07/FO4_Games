Scriptname Games:Shared:Widgets:HUD extends Quest Native Const Hidden
import Games:Shared:Widgets:HUDWidget


; Virtual
;---------------------------------------------

WidgetData Function Create()
	{VIRTUAL}
	return new WidgetData
EndFunction


Event OnRegistered()
	{VIRTUAL}
EndEvent


Event OnUnregistered()
	{VIRTUAL}
EndEvent


Event OnLoaded()
	{VIRTUAL}
EndEvent


Event OnUnloaded()
	{VIRTUAL}
EndEvent


Event OnUpdated()
	{VIRTUAL}
EndEvent


; Interface
;---------------------------------------------

Function HUD_WidgetLoaded(string asWidgetID)
	{HudFramework}
EndFunction
