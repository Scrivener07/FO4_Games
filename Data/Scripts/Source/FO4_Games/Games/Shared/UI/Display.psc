Scriptname Games:Shared:UI:Display extends Games:Shared:UI:DisplayType Hidden
import Games:Papyrus:Log
import Games:Papyrus:Script
import Games:Shared
import Games:Shared:UI:Framework

DisplayData Display


; Events
;---------------------------------------------

Event OnInit()
	If (Data())
		Load()
	EndIf
EndEvent


Event OnMenuOpenCloseEvent(string menuName, bool opening)
	DisplayOpenCloseHandler(self, menuName, opening)
EndEvent


Function LoadingCallback(bool success, string menuName, string sourceVar, string destVar, string assetPath)
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
	return DisplayGetMember(self, member)
EndFunction


string Function ToString()
	return DisplayToString(self)
EndFunction


; Virtual
;---------------------------------------------

Event OnDisplayData(DisplayData widget)
	{Required}
	WriteMessage(self, "Error!", "The virtual OnDisplayData event is not implemented.")
EndEvent


Event OnDisplayLoaded()
	{Optional}
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
			DisplaySetVisible(self, value)
		EndFunction
	EndProperty
EndGroup
