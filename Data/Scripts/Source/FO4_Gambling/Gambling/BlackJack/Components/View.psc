ScriptName Gambling:BlackJack:Components:View extends Gambling:BlackJack:GameComponent
import Gambling
import Gambling:BlackJack:Game
import Gambling:Common

Actor Player
InputEnableLayer InputLayer


; Events
;---------------------------------------------

Event OnInitialize()
	Player = Game.GetPlayer()
EndEvent


Event OnGamePhase(PhaseEventArgs e)
	If (e.Name == StartingPhase && e.Change == Begun)
		Enable()
	EndIf

	If (e.Name == ScoringPhase && e.Change == Ended)
		Disable()
	EndIf
EndEvent


; Functions
;---------------------------------------------

Function Enable()
	Player.SetAlpha(0.0)
	InputLayer = InputEnableLayer.Create()
	InputLayer.DisablePlayerControls(true, true, true, true, true, true, true, true, true, true, true)
	Game.StartDialogueCameraOrCenterOnTarget(Gambling_BlackJack_Camera)
EndFunction


Function Disable()
	Player.SetAlpha(1.0)
	If (InputLayer)
		InputLayer.Delete()
		InputLayer = none
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Markers
	ObjectReference Property Gambling_BlackJack_Camera Auto Const Mandatory
EndGroup
