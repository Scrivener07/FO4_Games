Scriptname Games:Shared:UI:MenuType extends Games:Shared:Task Native Hidden
import Games:Papyrus:Log


Struct MenuData
	string Name = ""
	{The name of the menu to load within.}
	string Root = ""
	{The root display object.}
	string Load = ""
	{The swf file to load within the given menu.}
	string Method = ""
	{destination}
EndStruct


; Methods
;---------------------------------------------

bool Function Load() Native
{Loads the MenuData into the user interface.}

Event MenuLoadedCallback(bool success, string menuName, string sourceVar, string destVar, string assetPath) Native
{Callback from "UI.Load" F4SE script.}


; Virtual
;---------------------------------------------

MenuData Function GetMenuData() Native
{Extending script returns the MenuData for this menu.}

Event OnMenuLoaded() Native
{The menu has been loaded.}


; Properties
;---------------------------------------------

string Property MenuLoadedCallback = "MenuLoadedCallback" AutoReadOnly
