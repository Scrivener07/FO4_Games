Scriptname Games:Compatibility extends Games:Type
import Games:Shared:Log
import Games:Shared:Papyrus

; Events
;---------------------------------------------

Event OnQuestInit()
	RegisterForGameReload(self)
EndEvent

Event OnQuestShutdown()
	UnregisterForGameReload(self)
EndEvent

Event OnGameReload()
	string help = "\n\nFor more help, visit "+Title+" at "+Website
	If (F4SE.GetVersionRelease() == 0)
		Problem(Title+" Problem", "The Fallout 4 Script Extender (F4SE) is not running.\nClassic Games will not work correctly!\n\n" \
			+ "This message may also appear if a new Fallout 4 patch has been released. In this case, wait until F4SE has been updated, then install the new version." \
			+ help)
	ElseIf (F4SE.GetVersionRelease() < F4SE_ReleaseMinimum)
		Problem(Title+" Problem", "F4SE is outdated.\nClassic Games will not work correctly!\n" \
			+ "Required version: " + F4SE_VersionName + " or newer\n" \
			+ "Detected version: " + F4SE.GetVersion() + "." + F4SE.GetVersionMinor() + "." + F4SE.GetVersionBeta() \
			+ help)
	ElseIf (F4SE.GetScriptVersionRelease() < F4SE_ReleaseMinimum)
		Problem(Title+" Problem", "F4SE scripts are outdated.\nYou probably forgot to install/update them with the rest of F4SE.\nClassic Games will not work correctly!" + help)
	Else
		WriteLine(self, "The game reloaded with all prerequisites met.")
	EndIf
EndEvent


; Functions
;---------------------------------------------

Function Problem(string title, string text)
	If (IsDebug())
		WriteMessage(self, title, text)
	Else
		Games_MessageEnableDebug.Show()
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	string Property Title = "Classic Games" Auto Const
	string Property Website = "github.com/Scrivener07/FO4_Games" Auto Const
	Message Property Games_MessageEnableDebug Auto Const Mandatory
EndGroup

Group F4SE
	string Property F4SE_VersionName Hidden
		string Function Get()
			return "0.6.5"
		EndFunction
	EndProperty

	int Property F4SE_ReleaseMinimum Hidden
		int Function Get()
			return 12
		EndFunction
	EndProperty
EndGroup
