Scriptname Games:Shared:UI:Interface Native Const Hidden
import Games:Shared:UI:MenuType


bool Function MenuLoad(MenuData menu, ScriptObject script, string callback = "UI_Loaded") Global
	return UI.Load(menu.Name, menu.Root, menu.File, script, callback)
EndFunction
