Scriptname Games:Shared:UI:Display extends Games:Shared:UI:DisplayType Hidden
import Games:Papyrus:Log
import Games:Papyrus:Script
import Games:Shared
import Games:Shared:UI:Framework

DisplayData Display


; Events
;---------------------------------------------

Event OnInit()
	RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
	OnGameReload()
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


; Methods
;---------------------------------------------

bool Function Data()
	Display = DisplayData(self)
	return Display as bool
EndFunction


bool Function Load()
	return DisplayLoad(self)
EndFunction


string Function GetMember(string member)
	WriteLine(self, "GetMember for '"+member+"' member.")
	return DisplayGetMember(self, member) ; TODO: Stack too deep (infinite recursion likely) - aborting call and returning None
EndFunction


string Function ToString()
	return DisplayToString(self)
EndFunction


; Virtual
;---------------------------------------------

Event OnDisplayData(DisplayData widget)
	{Required}
	WriteErrorNotImplemented(self, "OnDisplayData", "The event must be implemented on an extending script.")
EndEvent


Event OnDisplayLoaded()
	{Optional}
	WriteLine(self, "The event OnDisplayLoaded was not implemented on an extending script.")
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
