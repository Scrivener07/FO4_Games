Scriptname Games:Shared:UI:Display extends Games:Shared:UI:DisplayType Hidden
import Games:Papyrus:Log
import Games:Papyrus:Script
import Games:Papyrus:StringType
import Games:Shared
import Games:Shared:UI:DisplayType
import Games:Shared:UI:Framework

DisplayData Display


; Events
;---------------------------------------------

Event OnInit()
	OnGameReload()
	RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
	WriteLine(self, "Initialization is complete for "+ToString())
EndEvent


Event Actor.OnPlayerLoadGame(Actor akSender)
	OnGameReload()
	WriteLine(self, "Reload is complete for "+ToString())
EndEvent


Event OnGameReload()
	If (Data())
		Load()
	EndIf
EndEvent


Event OnMenuOpenCloseEvent(string menuName, bool opening)
	DisplayOpenCloseHandler(self, menuName, opening)
EndEvent
bool Function DisplayOpenCloseHandler(UI:Display this, string menuName, bool opening) Global
	{Loads this display when the menu is opening.}
	If (this)
		If (menuName == this.Menu)
			If (opening)
				return this.Load()
			Else
				WriteLine(this, "The "+menuName+"' menu is closing.")
				return true
			EndIf
		Else
			InvalidOperationException(this, "DisplayOpenCloseHandler", this.ToString()+" received unhandled menu '"+menuName+"', expected '"+this.Menu+"'.")
			return false
		EndIf
	Else
		ArgumentNoneException("Games:Shared:UI:Display", "DisplayOpenCloseHandler", "this")
		return false
	EndIf
EndFunction


Function LoadingCallback(bool success, string menuName, string sourceVar, string destVar, string assetPath)
	{F4SE callback for the UI.Load function.}
	DisplayArguments arguments = new DisplayArguments
	arguments.Menu = menuName
	arguments.Root = sourceVar
	arguments.Instance = destVar
	arguments.Asset = assetPath
	arguments.Success = success
	DisplayLoadingHandler(self, Display, arguments)
EndFunction
bool Function DisplayLoadingHandler(UI:Display this, DisplayData data, DisplayArguments arguments) Global
	{Stores additional display information post loading.}
	If (arguments.Menu == data.Menu)
		If (arguments.Asset == data.Asset)
			data.Root = arguments.Root
			data.Instance = arguments.Instance

			If (arguments.Success)
				this.OnDisplayLoaded()
				WriteLine(this, this.ToString()+" finished loading.")
				return true
			Else
				InvalidOperationException(this, "DisplayLoadingHandler", this.ToString()+" failed to load.")
				return false
			EndIf
		Else
			InvalidOperationException(this, "DisplayLoadingHandler", this.ToString()+" received unhandled asset '"+arguments.Asset+"', expected '"+data.Asset+"'.")
			return false
		EndIf
	Else
		InvalidOperationException(this, "DisplayLoadingHandler", this.ToString()+" received unhandled menu '"+arguments.Menu+"', expected '"+data.Menu+"'.")
		return false
	EndIf
EndFunction


; Methods
;---------------------------------------------

bool Function Data()
	Display = DisplayData(self)
	return Display as bool
EndFunction
DisplayData Function DisplayData(UI:Display this) Global
	If (this)
		DisplayData data = new DisplayData
		this.OnDisplayData(data)
		return data
	Else
		ArgumentNoneException("Games:Shared:UI:Display", "DisplayData", "this")
		return none
	EndIf
EndFunction


bool Function Load()
	return DisplayLoad(self)
EndFunction
bool Function DisplayLoad(UI:Display this) Global
	{Registers the display for menu open/close.}
	If (this)
		If (StringIsNoneOrEmpty(this.Menu))
			ArgumentException(this, "DisplayLoad", "Menu", "Cannot operate on a none or empty display Menu.")
			return false
		ElseIf (StringIsNoneOrEmpty(this.Root))
			ArgumentException(this, "DisplayLoad", "Root", "Cannot operate on a none or empty display Root.")
			return false
		ElseIf (StringIsNoneOrEmpty(this.Asset))
			ArgumentException(this, "DisplayLoad", "Asset", "Cannot operate on a none or empty display Asset.")
			return false
		Else
			this.RegisterForMenuOpenCloseEvent(this.Menu)
			If (this.IsOpen)
				return UI.Load(this.Menu, this.Root, this.Asset, this, "LoadingCallback")
			Else
				InvalidOperationException(this, "DisplayLoad", this.Menu+"' is not open, listening for menu open.")
				return false
			EndIf
		EndIf
	Else
		ArgumentNoneException("Games:Shared:UI:Display", "DisplayLoad", "this")
		return false
	EndIf
EndFunction


string Function GetMember(string member)
	WriteLine(self, "GetMember for '"+member+"' member.")
	return DisplayGetMember(self, member) ; TODO: Stack too deep (infinite recursion likely) - aborting call and returning None
EndFunction
string Function DisplayGetMember(UI:Display this, string member) Global
	If (this)
		If (StringIsNoneOrEmpty(member))
			ArgumentException(this, "DisplayGetMember", "member", "Cannot operate on a none or empty display member.")
			return none
		ElseIf (StringIsNoneOrEmpty(this.Instance))
			InvalidOperationException(this, "DisplayGetMember", "Cannot operate on a none or empty display Instance.")
			return none
		Else
			return this.Instance+"."+member
		EndIf
	Else
		ArgumentNoneException("Games:Shared:UI:Display", "DisplayGetMember", "this")
		return none
	EndIf
EndFunction


string Function ToString()
	return DisplayToString(self)
EndFunction
string Function DisplayToString(UI:Display this) Global
	If (this)
		return "[Menu:"+this.Menu+", Root:"+this.Root+", Asset:"+this.Asset+", Instance:"+this.Instance+"]"
	Else
		return "NONE [Games:Shared:UI:Display]"
	EndIf
EndFunction


; Virtual
;---------------------------------------------

Event OnDisplayData(DisplayData widget)
	{Required}
	NotImplementedException(self, "OnDisplayData", "The event must be implemented on an extending script.")
EndEvent


Event OnDisplayLoaded()
	{Optional}
	WriteLine(self, "The display is loaded.")
EndEvent


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

	bool Property IsOpen Hidden
		bool Function Get()
			return DisplayIsOpen(self)
		EndFunction
	EndProperty

	bool Property Visible Hidden
		bool Function Get()
			return DisplayGetVisible(self)
		EndFunction
		Function Set(bool value)
			WriteLine(self, "Visible is being set to '"+value+"'.")
			DisplaySetVisible(self, value) ; TODO: Stack too deep (infinite recursion likely) - aborting call and returning None
		EndFunction
	EndProperty
EndGroup


bool Function DisplayIsOpen(UI:Display this) Global
	If (this)
		If (StringIsNoneOrEmpty(this.Menu))
			WriteLine(this, "DisplayIsOpen cannot operate on a none or empty display Menu.")
			return false
		Else
			return UI.IsMenuOpen(this.Menu)
		EndIf
	Else
		ArgumentNoneException("Games:Shared:UI:Display", "DisplayIsOpen", "this")
		return false
	EndIf
EndFunction


bool Function DisplayGetVisible(UI:Display this) Global
	If (this)
		If (StringIsNoneOrEmpty(this.Menu))
			ArgumentException(this, "DisplayGetVisible", "Menu", "Cannot operate on a none or empty value.")
			return false
		ElseIf (StringIsNoneOrEmpty(this.Instance))
			ArgumentException(this, "DisplayGetVisible", "Instance", "Cannot operate on a none or empty value.")
			return false
		Else
			return UI.Get(this.Menu, this.GetMember("Visible")) as bool
		EndIf
	Else
		ArgumentNoneException("Games:Shared:UI:Display", "DisplayGetVisible", "this")
		return false
	EndIf
EndFunction
bool Function DisplaySetVisible(UI:Display this, bool value) Global
	If (this)
		If (StringIsNoneOrEmpty(this.Menu))
			ArgumentException(this, "DisplaySetVisible", "Menu", "Cannot operate on a none or empty value.")
			return false
		ElseIf (StringIsNoneOrEmpty(this.Instance))
			ArgumentException(this, "DisplaySetVisible", "Instance", "Cannot operate on a none or empty value.")
			return false
		Else
			return UI.Set(this.Menu, this.GetMember("Visible"), value) ; TODO: Stack too deep (infinite recursion likely) - aborting call and returning None
		EndIf
	Else
		ArgumentNoneException("Games:Shared:UI:Display", "DisplaySetVisible", "this")
		return false
	EndIf
EndFunction
