Scriptname Games:Papyrus:Script Const Native Hidden


; State
;---------------------------------------------

bool Function ChangeState(ScriptObject script, string newState) Global
	string stateName = script.GetState()
	If(stateName != newState)
		script.GoToState(newState)
		return true
	Else
		return false
	EndIf
EndFunction


bool Function HasState(ScriptObject script) Global
	return script.GetState() != ""
EndFunction
