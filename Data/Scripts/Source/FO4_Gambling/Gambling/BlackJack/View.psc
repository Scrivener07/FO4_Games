ScriptName Gambling:BlackJack:View extends Quest


; Functions
;---------------------------------------------

Function Test()
	{Camera Stuff}
	InputEnableLayer inputLayer = InputEnableLayer.Create()
	inputLayer.DisablePlayerControls(true, true, true, true, true, true, true, true, true, true, true)
	Game.StartDialogueCameraOrCenterOnTarget(Gambling_Camera)
	Utility.Wait(3)
	inputLayer.Delete()
EndFunction


; Properties
;---------------------------------------------

Group Properties
	ObjectReference Property Gambling_Camera Auto Const Mandatory
EndGroup
