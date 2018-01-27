Scriptname Games:Shared:UI:Menu extends Games:Shared:UI:MenuType Hidden
import Games:Shared:Log
import Games:Shared:Papyrus

DisplayData Display


; 0xD = 0x01 + 0x08 + 0x04 ; Pause Game, Enable Menu Control, Show cursor


; Events
;---------------------------------------------

Event OnInit()
	OnGameReload()
	RegisterForGameReload(self)
EndEvent


Event Actor.OnPlayerLoadGame(Actor akSender)
	OnGameReload()
EndEvent


Event OnGameReload()
	Display = NewDisplay()

	UI:MenuData data = new UI:MenuData
	data.MenuFlags = 0x0
	If (UI.RegisterCustomMenu(Display.Menu, Display.Asset, Display.Root, data))
		WriteLine(self, ToString()+" has registered as a custom menu.")
	Else
		WriteUnexpectedValue(self, "OnGameReload", "Display", ToString()+" failed to register as a custom menu.")
	EndIf
EndEvent


; Methods
;---------------------------------------------
bool Function Open()
	If (IsRegistered)
		return UI.OpenMenu(Menu)
	Else
		WriteUnexpected(self, "Open", "The menu is not registered.")
		return false
	EndIf
EndFunction


bool Function Close()
	If (IsRegistered)
		return UI.CloseMenu(Menu)
	Else
		WriteUnexpected(self, "Close", "The menu is not registered.")
		return false
	EndIf
EndFunction


bool Function GetVisible()
	If (IsOpen)
		return UI.Get(Menu, GetMember("Visible")) as bool
	Else
		WriteUnexpected(self, "GetVisible", "The menu is not open.")
		return false
	EndIf
EndFunction


bool Function SetVisible(bool value)
	If (IsOpen)
		return UI.Set(Menu, GetMember("Visible"), value)
	Else
		WriteUnexpected(self, "SetVisible", "The menu is not open.")
		return false
	EndIf
EndFunction


string Function GetMember(string member)
	{Returns the full AS3 instance path for the given member name.}
	; TODO: Stack too deep (infinite recursion likely) - aborting call and returning None
	If (StringIsNoneOrEmpty(member))
		WriteUnexpectedValue(self, "GetMember", "member", "Cannot operate on a none or empty display member.")
		return none
	ElseIf (StringIsNoneOrEmpty(root))
		WriteUnexpected(self, "GetMember", "Cannot operate on a none or empty display root.")
		return none
	Else
		WriteLine(self, "GetMember for '"+member+"' member.")
		return Root+"."+member
	EndIf
EndFunction


string Function ToString()
	{The string representation of this UI type.}
	return "[Menu:"+Menu+", Asset:"+Asset+", Root:"+Root+" Instance:"+Instance+"]"
EndFunction


; Properties
;---------------------------------------------

Group Display
	string Property Menu Hidden
		string Function Get()
			return Display.Menu
		EndFunction
	EndProperty

	string Property Root Hidden
		string Function Get()
			return Display.Root
		EndFunction
	EndProperty

	string Property Asset Hidden
		string Function Get()
			return Display.Asset
		EndFunction
	EndProperty

	string Property Instance Hidden
		string Function Get()
			return Display.Instance
		EndFunction
	EndProperty
EndGroup


Group Properties
	bool Property IsRegistered Hidden
		bool Function Get()
			return UI.IsMenuRegistered(Menu)
		EndFunction
	EndProperty

	bool Property IsOpen Hidden
		bool Function Get()
			return UI.IsMenuOpen(Menu)
		EndFunction
	EndProperty

	; bool Property Visible Hidden
	; 	bool Function Get()
	; 		return GetVisible()
	; 	EndFunction
	; 	Function Set(bool value)
	; 		SetVisible(value)
	; 	EndFunction
	; EndProperty
EndGroup
