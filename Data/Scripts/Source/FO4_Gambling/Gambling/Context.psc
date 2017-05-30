ScriptName Gambling:Context extends Quest
import Gambling:Common


; Meta
;---------------------------------------------

string Function GetTitle() Global
	return "Gambling"
EndFunction

string Function GetPlugin() Global
	return "Gambling.esp"
EndFunction


; Properties
;---------------------------------------------

Group Properties
	string Property Title Hidden
		string Function Get()
			return GetTitle()
		EndFunction
	EndProperty

	string Property Plugin Hidden
		string Function Get()
			return GetPlugin()
		EndFunction
	EndProperty
EndGroup


; Group Types
; 	Activator Property Gambling_Cards_DeckType Auto Const Mandatory
; EndGroup
