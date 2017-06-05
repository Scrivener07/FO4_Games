ScriptName Gambling:BlackJack:Components:Table extends Gambling:BlackJack:GameComponent
import Gambling
import Gambling:BlackJack
import Gambling:Common

Actor Player
InputEnableLayer InputLayer


; Events
;---------------------------------------------

Event OnInitialize()
	Player = Game.GetPlayer()
EndEvent


; Functions
;---------------------------------------------

Function Enable()
	Game.SetPlayerAIDriven()

	Player.MoveTo(Gambling_BlackJack_CellMarker)

	InputLayer = InputEnableLayer.Create()
	InputLayer.DisablePlayerControls(true, true, true, true, true, true, true, true, true, true, true)

	Game.StartDialogueCameraOrCenterOnTarget(Gambling_BlackJack_CameraMarker)

	Player.AddPerk(Gambling_TablePerk, true)
	Player.AddItem(Gambling_ZoomWeapon)
	Player.EquipItem(Gambling_ZoomWeapon)
EndFunction


Function Disable()
	Game.SetPlayerAIDriven(false)

	If (PlayAction)
		Player.MoveTo(PlayAction as ObjectReference)
	EndIf

	If (InputLayer)
		InputLayer.Delete()
		InputLayer = none
	EndIf

	Player.RemovePerk(Gambling_TablePerk)
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

Perk Property Gambling_TablePerk Auto Const Mandatory
Weapon Property Gambling_ZoomWeapon Auto Const Mandatory
