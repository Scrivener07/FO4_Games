Scriptname Games:Shared:UI:MenuType extends Games:Type Hidden Native Const
{Script for menu type displays.}

; Display
;---------------------------------------------

Struct DisplayData
	string Menu
	{The name of the menu to load within.}
	string Root = "root1"
	{The root display object.}
	string Asset
	{The asset file to load within the given menu. The root directory is "Data\Interface".}
EndStruct

DisplayData Function NewDisplay() Native
