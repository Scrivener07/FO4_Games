ScriptName GamesTest:Framework:Library Const Native Hidden
import Games:Papyrus:Log
import GamesTest:Framework


Function LilacTrace(GamesTest:Framework:Lilac framework, int logLevel, string text) Global
	string level
	If (logLevel == 0)
		level = ""
	ElseIf (logLevel == 1)
		level = "WARN - "
	ElseIf (logLevel == 2)
		level = "ERROR - "
	Else
		level = "??? - "
	EndIf
	string value = "[" + framework.SystemName + "] " +level + text
	WriteLine("Lilac", value)
EndFunction
