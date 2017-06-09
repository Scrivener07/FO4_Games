ScriptName Gambling:BlackJack:Components:Table extends Gambling:BlackJack:Component
import Gambling
import Gambling:BlackJack
import Gambling:Shared:Common

Actor Player
InputEnableLayer InputLayer


; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
EndEvent


; Component
;---------------------------------------------

Function GameBegin()
	Game.SetPlayerAIDriven()

	Player.MoveTo(Gambling_BlackJack_CellMarker)

	InputLayer = InputEnableLayer.Create()
	InputLayer.DisablePlayerControls(true, true, true, true, true, true, true, true, true, true, true)

	Game.StartDialogueCameraOrCenterOnTarget(Gambling_BlackJack_CameraMarker)
EndFunction


Function GameEnd()
	Game.SetPlayerAIDriven(false)

	If (PlayAction)
		Player.MoveTo(PlayAction as ObjectReference)
	EndIf

	If (InputLayer)
		InputLayer.Delete()
		InputLayer = none
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Actions
	Actions:Play Property PlayAction Auto Hidden
EndGroup

Group Markers
	ObjectReference Property Gambling_BlackJack_CellMarker Auto Const Mandatory
	ObjectReference Property Gambling_BlackJack_CameraMarker Auto Const Mandatory
EndGroup

; Group Zoom
; 	Perk Property Gambling_TablePerk Auto Const Mandatory
; 	Weapon Property Gambling_ZoomWeapon Auto Const Mandatory
; EndGroup