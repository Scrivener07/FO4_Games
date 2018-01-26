Scriptname Games:Shared:UI:MenuType extends Quest Hidden Native Const


Struct DisplayData
	string Menu
	{The name of the menu to load within.}

	string Root = "root1"
	{The root display object.}

	string Asset
	{The asset file to load within the given menu. The root directory is "Data\Interface".}

	string Instance
	{The destination instance variable. Used by GetMember(string)}
EndStruct

DisplayData Function NewDisplay() Native


; OnGameReload
;---------------------------------------------

Event OnGameReload() Native
{Event occurs when the game has been reloaded or initialized.}

bool Function RegisterForGameReload(MenuType this)
	return this.RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
EndFunction


Function UnregisterForGameReload(MenuType this)
	this.UnregisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
EndFunction
