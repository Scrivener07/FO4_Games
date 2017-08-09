ScriptName Games:Blackjack:UI:Choice extends Games:Shared:UI:Menu

string LoadingMenu = "LoadingMenu" const


; Events
;---------------------------------------------

Event OnInit()
	Setup()
	RegisterForMenuOpenCloseEvent(LoadingMenu)
EndEvent


Event SetData(MenuData menu)
	menu.Name = "HUDMenu"
	menu.Root = "root1"
	menu.File = "Choice.swf"
EndEvent


Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	If (abOpening == false)
		Load()
	EndIf
EndEvent
