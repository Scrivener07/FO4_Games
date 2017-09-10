Scriptname Games:Shared:UI:DisplayType extends Quest Native Hidden
import Games:Papyrus:Log


Struct DisplayData
	string Menu = ""
	{The name of the menu to load within.}
	string Root = ""
	{The root display object.}
	string Asset = ""
	{The asset file to load within the given menu.}
	string Method = ""
	{The destination variable.}
EndStruct


; Methods
;---------------------------------------------

Function Setup() Native
{Configures the display data provided by extending script.}

bool Function Load() Native
{Loads the DisplayData into the user interface.}

Event UILoadedCallback(bool success, string menuName, string sourceVar, string destVar, string assetPath) Native
{Callback from `UI.Load` F4SE script.}


; Virtual
;---------------------------------------------

DisplayData Function GetDisplay() Native
{An extending script returns the DisplayData required to load swf files.}

Event OnDisplayLoaded() Native
{The menu has been loaded.}


; Properties
;---------------------------------------------

string Property UILoadedCallback = "UILoadedCallback" AutoReadOnly
