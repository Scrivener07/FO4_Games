ScriptName Gambling:BlackJack:View extends Quest


; Functions
;---------------------------------------------

Function Test()
	{Camera Stuff}
	InputEnableLayer input = InputEnableLayer.Create()
	input.DisablePlayerControls(true, true, true, true, true, true, true, true, true, true, true)
	Game.StartDialogueCameraOrCenterOnTarget(Gambling_Camera)
	Utility.Wait(3)
	input.Delete()
EndFunction


; Properties
;---------------------------------------------

Group Properties
	ObjectReference Property Gambling_Camera Auto Const Mandatory
EndGroup
