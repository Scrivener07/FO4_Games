Scriptname Games:Shared:UI:MenuType extends Quest Native Const Hidden
import Games:Papyrus:Log


Struct MenuData
	string Name = ""
	string Root = ""
	string File = ""
EndStruct


; Methods
;---------------------------------------------

Function Setup() Native
{Configures the menu data for this menu.}

bool Function Load() Native
{Loads the menu data into the user interface.}


; Callbacks
;---------------------------------------------

Event UI_Loaded(bool success, string menuName, string sourceVar, string destVar, string assetPath) Native
{Callback from "UI.Load" F4SE script.}


; Virtual
;---------------------------------------------

Event SetData(MenuData menu) Native
{Entending script configures the widget data.}


Event OnLoaded() Native
{The menu has been loaded.}
