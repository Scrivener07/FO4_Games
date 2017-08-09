Scriptname Games:Shared:UI:Menu extends Games:Shared:UI:MenuType
import Games:Papyrus:Log
import Games:Shared:UI:Interface

MenuData Data
CustomEvent OnSelected


; Methods
;---------------------------------------------

Function Setup()
	Data = new MenuData
	self.SetData(Data)
EndFunction


bool Function Load()
	return MenuLoad(Data, self)
EndFunction


; Callbacks
;---------------------------------------------

Event UI_Loaded(bool success, string menuName, string sourceVar, string destVar, string assetPath)
	If (menuName == Data.Name)
		self.OnLoaded()
		WriteLine(self, "Callback loaded the '"+menuName+"' menu.")
	Else
		WriteLine(self, "Callback loaded unhandled '"+menuName+"' menu.")
	EndIf
EndEvent


; Virtual
;---------------------------------------------

Event SetData(MenuData menu)
	{VIRTUAL}
	WriteLine(self, "The menu has not implemented the virtual 'SetData' event.")
EndEvent


Event OnLoaded()
	{VIRTUAL}
	WriteLine(self, "The menu has not implemented the virtual 'OnLoaded' event.")
EndEvent
