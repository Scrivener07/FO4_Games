Scriptname Games:Compatibility extends Quest
import Games:Shared:Log

Actor Player

; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
	RegisterForRemoteEvent(Player, "OnPlayerLoadGame")
	OnGameReload()
EndEvent

Event Actor.OnPlayerLoadGame(Actor akSender)
	OnGameReload()
EndEvent


; Functions
;---------------------------------------------

Function OnGameReload()
	string help = "\n\nFor more help, visit "+Title+" at "+Website

	If (F4SE.GetVersionRelease() == 0)
		WriteMessage(self, Title+" Error\n", "The Fallout 4 Script Extender (F4SE) is not running.\nClassic Games will not work correctly!\n\n" \
			+ "This message may also appear if a new Fallout 4 patch has been released. In this case, wait until F4SE has been updated, then install the new version." \
			+ help)
		return
	ElseIf (F4SE.GetVersionRelease() < MinimumReleaseF4SE)
		WriteMessage(self, Title+" Error\n", "F4SE is outdated.\nClassic Games will not work correctly!\n" \
			+ "Required version: " + MinimumVersionF4SE + " or newer\n" \
			+ "Detected version: " + F4SE.GetVersion() + "." + F4SE.GetVersionMinor() + "." + F4SE.GetVersionBeta() \
			+ help)
		return
	ElseIf (F4SE.GetScriptVersionRelease() < MinimumReleaseF4SE)
		WriteMessage(self, Title+" Error\n", "F4SE scripts are outdated.\nYou probably forgot to install/update them with the rest of F4SE.\nClassic Games will not work correctly!" + help)
		return
	Else
		WriteLine(self, "All prerequisites are met.")
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	string Property Title = "Classic Games" Auto Const
	string Property Website = "github.com/Scrivener07/FO4_Games" Auto Const
EndGroup

Group F4SE
	int Property MinimumReleaseF4SE = 12  AutoReadOnly
	string Property	MinimumVersionF4SE = "0.6.5" AutoReadOnly
EndGroup
