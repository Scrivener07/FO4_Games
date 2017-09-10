Scriptname Games:Shared:HUD:Framework Native Const Hidden
import Games:Papyrus:Log
import Games:Papyrus:StringType
import Games:Shared:HUD:WidgetType


; HUD
;---------------------------------------------

Function AS3(HudFramework framework, string expression) Global
	If (framework)
		If (StringIsNoneOrEmpty(expression))
			framework.Eval(expression)
			WriteLine("HUD", "Sent the AS3 expression '"+expression+"' to the HUD.")
		Else
			WriteLine("HUD", "Cannot evaluate a none or empty AS3 expression.")
		EndIf
	Else
		WriteLine("HUD", "HUD Framework is none, cannot evaluate the '"+expression+"' expression.")
	EndIf
EndFunction


; Widgets
;---------------------------------------------

bool Function WidgetRegister(HudFramework framework, WidgetData data, Widget instance) Global
	If (framework)
		framework.RegisterWidget(instance, data.ID, data.X, data.Y, data.LoadNow, data.AutoLoad)
		If (framework.IsWidgetRegistered(data.ID))
			return true
		Else
			WriteLine("HUD", "HUD Framework could not register the '"+data.ID+"' widget.")
			return false
		EndIf
	Else
		WriteLine("HUD", "HUD Framework is none, cannot register the '"+data.ID+"' widget.")
		return false
	EndIf
EndFunction


bool Function WidgetUnregister(HudFramework framework, WidgetData data) Global
	If (framework)
		framework.UnregisterWidget(data.ID)
		If !(framework.IsWidgetRegistered(data.ID))
			return true
		Else
			WriteLine("HUD", "HUD Framework could not unregister the '"+data.ID+"' widget.")
			return false
		EndIf
	Else
		WriteLine("HUD", "HUD Framework is none, cannot unregister the '"+data.ID+"' widget.")
		return false
	EndIf
EndFunction


bool Function WidgetLoad(HudFramework framework, WidgetData data) Global
	If (framework)
		If (framework.IsWidgetRegistered(data.ID))
			framework.LoadWidget(data.ID)
			If (framework.IsWidgetLoaded(data.ID))
				return true
			Else
				WriteLine("HUD", "HUD Framework could not load the '"+data.ID+"' widget.")
				return false
			EndIf
		Else
			WriteLine("HUD", "HUD Framework cannot load the '"+data.ID+"' widget without registering first.")
			return false
		EndIf
	Else
		WriteLine("HUD", "HUD Framework is none, cannot load the '"+data.ID+"' widget.")
		return false
	EndIf
EndFunction


bool Function WidgetUnload(HudFramework framework, WidgetData data) Global
	If (framework)
		If (framework.IsWidgetRegistered(data.ID))
			framework.UnloadWidget(data.ID)
			If !(framework.IsWidgetLoaded(data.ID))
				return true
			Else
				WriteLine("HUD", "HUD Framework could not unload the '"+data.ID+"' widget.")
				return false
			EndIf
		Else
			WriteLine("HUD", "HUD Framework cannot unload the '"+data.ID+"' widget without registering first.")
			return false
		EndIf
	Else
		WriteLine("HUD", "HUD Framework is none, cannot unload the '"+data.ID+"' widget.")
		return false
	EndIf
EndFunction


string Function WidgetToString(WidgetData data) Global
	return data.ID+" [X:"+data.X+", Y:"+data.Y+", %:"+data.Opacity+"]"
EndFunction
