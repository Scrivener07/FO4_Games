Scriptname Games:Shared:UI:Framework Const Native Hidden
import Games:Papyrus:Log
import Games:Papyrus:StringType
import Games:Shared
import Games:Shared:UI:DisplayType

; Events
;---------------------------------------------

bool Function DisplayOpenCloseHandler(UI:Display display, string menuName, bool opening) Global
	If (display)
		If (menuName == display.Menu)
			If (opening)
				display.Load()
			Else
				WriteLine(display, display.ToString()+" DisplayOpenCloseHandler '"+menuName+"' menu is closing.")
			EndIf
			return true
		Else
			WriteLine(display, display.ToString()+" DisplayOpenCloseHandler received unhandled menu '"+menuName+"', expected '"+display.Menu+"'.")
			return false
		EndIf
	Else
		WriteLine(ToString(), "DisplayOpenCloseHandler cannot operate on a none display.")
		return false
	EndIf
EndFunction


bool Function DisplayLoadingHandler(UI:Display display, DisplayData data, DisplayArguments arguments) Global
	If (arguments.Menu == data.Menu)
		If (arguments.Asset == data.Asset)
			data.Root = arguments.Root
			data.Instance = arguments.Instance

			If (arguments.Success)
				display.OnDisplayLoaded()
				WriteLine(display, display.ToString()+" DisplayLoadingHandler finished loading.")
				return true
			Else
				WriteLine(display, display.ToString()+" DisplayLoadingHandler failed to load.")
				return false
			EndIf
		Else
			WriteLine(display, display.ToString()+" DisplayLoadingHandler received unhandled asset '"+arguments.Asset+"', expected '"+data.Asset+"'.")
			return false
		EndIf
	Else
		WriteLine(display, display.ToString()+" DisplayLoadingHandler received unhandled menu '"+arguments.Menu+"', expected '"+data.Menu+"'.")
		return false
	EndIf
EndFunction


; Methods
;---------------------------------------------

DisplayData Function DisplayData(UI:Display display) Global
	If (display)
		DisplayData data = new DisplayData
		display.OnDisplayData(data)
		return data
	Else
		WriteLine(ToString(), "DisplayData cannot operate on a none display.")
		return none
	EndIf
EndFunction


bool Function DisplayLoad(UI:Display display) Global
	If (display)
		If (StringIsNoneOrEmpty(display.Menu))
			WriteLine(display, "DisplayLoad cannot operate on a none or empty display Menu.")
			return false
		ElseIf (StringIsNoneOrEmpty(display.Root))
			WriteLine(display, "DisplayLoad cannot operate on a none or empty display Root.")
			return false
		ElseIf (StringIsNoneOrEmpty(display.Asset))
			WriteLine(display, "DisplayLoad cannot operate on a none or empty display Asset.")
			return false
		Else
			display.RegisterForMenuOpenCloseEvent(display.Menu)
			If (display.IsOpen)
				return UI.Load(display.Menu, display.Root, display.Asset, display, "LoadingCallback")
			Else
				WriteLine(display, display.ToString()+" menu '"+display.Menu+"' is not open, listening for menu open.")
				return false
			EndIf
		EndIf
	Else
		WriteLine(ToString(), "DisplayLoad cannot operate on a none display.")
		return false
	EndIf
EndFunction


bool Function DisplayUnload(UI:Display display) Global
	; TODO: iirc, loaded UI elements require a reload when the game does?
	; Unregister for menu open and recuring game loads.
	WriteErrorNotImplemented(display, "DisplayUnload", "I cannot find a way to directly unload a loaded UI element.")
EndFunction


string Function DisplayGetMember(UI:Display display, string member) Global
	If (display)
		If (StringIsNoneOrEmpty(member))
			WriteLine(display, "DisplayGetMember cannot operate on a none or empty member.")
			return none
		ElseIf (StringIsNoneOrEmpty(display.Instance))
			WriteLine(display, "DisplayGetMember cannot operate on a none or empty display Instance.")
			return none
		Else
			return display.Instance+"."+member
		EndIf
	Else
		WriteLine(ToString(), "DisplayGetMember cannot operate on a none display.")
		return none
	EndIf
EndFunction


; Properties
;---------------------------------------------

bool Function DisplayIsOpen(UI:Display display) Global
	If (display)
		If (StringIsNoneOrEmpty(display.Menu))
			WriteLine(display, "DisplayIsOpen cannot operate on a none or empty display Menu.")
			return false
		Else
			return UI.IsMenuOpen(display.Menu)
		EndIf
	Else
		WriteLine(ToString(), "DisplayIsOpen cannot operate on a none display.")
		return false
	EndIf
EndFunction


bool Function DisplayGetVisible(UI:Display display) Global
	If (display)
		If (StringIsNoneOrEmpty(display.Menu))
			WriteLine(display, "DisplayGetVisible cannot operate on a none or empty display Menu.")
			return false
		ElseIf (StringIsNoneOrEmpty(display.Instance))
			WriteLine(display, "DisplayGetVisible cannot operate on a none or empty display Instance.")
			return false
		Else
			return UI.Get(display.Menu, display.GetMember("Visible")) as bool
		EndIf
	Else
		WriteLine(ToString(), "DisplayGetVisible cannot operate on a none display.")
		return false
	EndIf
EndFunction


bool Function DisplaySetVisible(UI:Display display, bool value) Global
	If (display)
		If (StringIsNoneOrEmpty(display.Menu))
			WriteLine(display, "DisplaySetVisible cannot operate on a none or empty display Menu.")
			return false
		ElseIf (StringIsNoneOrEmpty(display.Instance))
			WriteLine(display, "DisplaySetVisible cannot operate on a none or empty display Instance.")
			return false
		Else
			return UI.Set(display.Menu, display.GetMember("Visible"), value)
		EndIf
	Else
		WriteLine(ToString(), "DisplaySetVisible cannot operate on a none display.")
		return false
	EndIf
EndFunction


; Functions
;---------------------------------------------

string Function DisplayToString(UI:Display display) Global
	If (display)
		return "[Menu:"+display.Menu+", Root:"+display.Root+", Asset:"+display.Asset+", Instance:"+display.Instance+"]"
	Else
		return "NONE [Games:Shared:UI:Display]"
	EndIf
EndFunction


string Function ToString() Global
	return "Games:Shared:UI:Framework"
EndFunction
