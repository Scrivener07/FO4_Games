Scriptname Games:Shared:UI:Menu extends Games:Shared:UI:MenuType
import Games:Papyrus:Log

MenuData Menu
CustomEvent OnLoaded


; Events
;---------------------------------------------

Event OnInit()
	Menu = GetMenuData()
	If (Load())
		WriteLine(self, "Loaded")
	EndIf
EndEvent


; Methods
;---------------------------------------------

bool Function Load()
	If (IsLoaded)
		WriteLine(self, "The menu is already loaded.")
		return Incomplete
	Else
		; TODO: A wait is only good for hud menu. I may need IsMenuOpen
		Utility.Wait(0.1) ; wait for HUDMenu to be loaded...

		return self.Await() ; @ busy
	EndIf
EndFunction


; Task
;---------------------------------------------

State Busy
	Event OnBeginState(string asOldState)
		If (UI.Load(Name, Root, Load, self, MenuLoadedCallback))

		Else
			AwaitEnd()
		EndIf

		; RegisterForRemoteEvent(Reference, "OnActivate")
		; RegisterForRemoteEvent(Menu, "OnEntryRun")
		; Player.AddPerk(Menu)
	EndEvent



	Event MenuLoadedCallback(bool success, string menuName, string sourceVar, string destVar, string assetPath)
		If (menuName == Name)
			Menu.Method = destVar
			self.OnMenuLoaded()
			WriteLine(self, "Callback loaded "+assetPath+" within "+menuName)
		Else
			WriteLine(self, "Callback loaded unhandled "+assetPath+" within "+menuName)
		EndIf
	EndEvent



	; Event ObjectReference.OnActivate(ObjectReference akSender, ObjectReference akActionRef)
	; 	; Data.Selected = 0
	; 	; SendCustomEvent("OnSelected")
	; EndEvent


	; Event Perk.OnEntryRun(Perk akSender, int auiEntryID, ObjectReference akTarget, Actor akOwner)
	; 	; Data.Selected = auiEntryID
	; 	; SendCustomEvent("OnSelected")
	; EndEvent


	; Event Games:Shared:Tasks:Activation.OnSelected(Tasks:Activation akSender, var[] arguments)
	; 	; WriteLine(self, "Selected "+akSender.Selected)
	; EndEvent


	Event OnEndState(string asNewState)
		; UnregisterForRemoteEvent(Reference, "OnActivate")
		; UnregisterForRemoteEvent(Menu, "OnEntryRun")
		; Player.RemovePerk(Menu)
	EndEvent
EndState


; Functions
;---------------------------------------------

string Function GetMember(string member)
	return Method+"."+member
EndFunction


; Virtual
;---------------------------------------------

MenuData Function GetMenuData()
	{VIRTUAL}
	WriteLine(self, "The virtual 'GetMenuData' function is not implemented.")
	return new MenuData
EndFunction


Event OnMenuLoaded()
	{VIRTUAL}
	WriteLine(self, "The virtual 'OnMenuLoaded' event is not implemented.")
EndEvent


; Properties
;---------------------------------------------

Group Properties
	string Property Name Hidden
		string Function Get()
			return Menu.Name
		EndFunction
	EndProperty

	string Property Root Hidden
		string Function Get()
			return Menu.Root
		EndFunction
	EndProperty

	string Property Load Hidden
		string Function Get()
			return Menu.Load
		EndFunction
	EndProperty

	string Property Method Hidden
		string Function Get()
			return Menu.Method
		EndFunction
	EndProperty
EndGroup


Group Menu
	bool Property IsLoaded Hidden
		bool Function Get()
			return UI.Get(Name, GetMember("IsLoaded")) as bool
		EndFunction
	EndProperty

	bool Property Visible Hidden
		bool Function Get()
			return UI.Get(Name, GetMember("Visible")) as bool
		EndFunction
		Function Set(bool value)
			UI.Set(Name, GetMember("Visible"), value)
		EndFunction
	EndProperty
EndGroup
