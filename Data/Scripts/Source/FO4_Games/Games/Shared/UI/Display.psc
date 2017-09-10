Scriptname Games:Shared:UI:Display extends Games:Shared:UI:DisplayType Hidden
import Games:Papyrus:Log
import Games:Papyrus:Script

DisplayData Display
CustomEvent OnLoaded


; Events
;---------------------------------------------

Event OnInit()
	Setup()
EndEvent


; Methods
;---------------------------------------------

Function Setup()
	Display = GetDisplay()
	If !(Display)
		WriteLine(self, "The display cannot be none.")
	EndIf
EndFunction


bool Function Load()
	If (IsLoaded)
		WriteLine(self, "The menu is already loaded.")
		return false
	Else
		WriteLine(self, "Awaiting busy task.")
		return TaskAwait(self) ; @ busy
	EndIf
EndFunction


string Function GetMember(string member)
	return Method+"."+member
EndFunction


; Tasks
;---------------------------------------------

State Busy
	Event OnBeginState(string asOldState)
		Utility.Wait(0.1) ; wait for HUDMenu to be loaded...

		If (UI.Load(Menu, Root, Asset, self, UILoadedCallback))
			WriteLine(self, "Load was a success.")
		Else
			WriteLine(self, "Failed to load ui display.")
			TaskEnd(self)
		EndIf
	EndEvent

	bool Function Load()
		{EMPTY}
	EndFunction

	Event UILoadedCallback(bool success, string menuName, string sourceVar, string destVar, string assetPath)
		If (menuName == Menu)
			If (assetPath == Asset)
				Display.Method = destVar
				self.OnDisplayLoaded()
				TaskEnd(self)
				WriteLine(self, "Callback loaded "+assetPath+" within "+menuName)
			Else
				WriteLine(self, "Callback received unhandled asset "+menuName)
			EndIf
		Else
			WriteLine(self, "Callback received unhandled menu "+menuName)
		EndIf
	EndEvent


	Event OnEndState(string asNewState)
		WriteLine(self, "Ending busy state.")
	EndEvent
EndState


; Virtual
;---------------------------------------------

DisplayData Function GetDisplay()
	{VIRTUAL - Member is overridden in a derived class.}
	WriteLine(self, "The virtual 'GetDisplay' function is not implemented.")
	return new DisplayData
EndFunction


Event OnDisplayLoaded()
	{VIRTUAL - Member is overridden in a derived class.}
	WriteLine(self, "The virtual 'OnDisplayLoaded' event is not implemented.")
EndEvent


; Properties
;---------------------------------------------

Group Properties
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

	string Property Method Hidden
		string Function Get()
			return Display.Method
		EndFunction
	EndProperty
EndGroup


Group Display
	bool Property IsLoaded Hidden
		bool Function Get()
			return UI.Get(Menu, GetMember("IsLoaded")) as bool
		EndFunction
	EndProperty

	bool Property Visible Hidden
		bool Function Get()
			return UI.Get(Menu, GetMember("Visible")) as bool
		EndFunction
		Function Set(bool value)
			UI.Set(Menu, GetMember("Visible"), value)
		EndFunction
	EndProperty
EndGroup
