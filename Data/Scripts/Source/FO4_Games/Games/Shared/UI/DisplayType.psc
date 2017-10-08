Scriptname Games:Shared:UI:DisplayType extends Quest Native Hidden
{The papyrus script for user interface display types.}

Struct DisplayData
	string Menu = ""
	{The name of the menu to load within.}

	string Root = "root1"
	{The root display object.}

	string Asset = ""
	{The asset file to load within the given menu. The root directory is "Data\Interface".}

	string Instance = ""
	{The destination instance variable.}
EndStruct


Struct DisplayArguments
	string Menu
	{menuName}
	string Root
	{sourceVar}
	string Asset
	{assetPath}
	string Instance
	{destVar}
	bool Success = false
	{Load success}
EndStruct


; Virtual
;---------------------------------------------

Event OnDisplayData(DisplayData display) Native
{Required, event occurs when the display needs to configure its data.}

Event OnDisplayLoaded() Native
{Optional, event occurs when the display has been loaded.}


; Methods
;---------------------------------------------

bool Function Data() Native
{A member of the DisplayType papyrus script.}

bool Function Load() Native
{A member of the DisplayType papyrus script.}

string Function GetMember(string member) Native
{A member of the DisplayType papyrus script.}

string Function ToString() Native
{A member of the DisplayType papyrus script.}


; Callbacks
;---------------------------------------------

Function LoadingCallback(bool success, string menuName, string sourceVar, string destVar, string assetPath) Native
{Callback for OnDisplayLoaded.}
