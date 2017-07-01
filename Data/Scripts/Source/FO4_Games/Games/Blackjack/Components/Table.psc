ScriptName Games:Blackjack:Components:Table extends Games:Blackjack:Component
import Games
import Games:Blackjack
import Games:Shared:Common

Actor Player
InputEnableLayer InputLayer

int HudStandard = 0 const
int HudHidden = 3 const


; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
EndEvent


; Component
;---------------------------------------------

State Starting
	Event OnBeginState(string asOldState)
		Game.ShowFirstPersonGeometry(false)
		Game.SetInChargen(true, true, false)
		Game.SetCharGenHUDMode(HudHidden)

		Game.SetPlayerAIDriven()
		Player.MoveTo(Games_Blackjack_CellMarker)
		Player.SetScale(0.5)

		InputLayer = InputEnableLayer.Create()
		InputLayer.DisablePlayerControls(true, true, true, true, true, true, true, true, true, true, true)

		Game.StartDialogueCameraOrCenterOnTarget(Games_Blackjack_CameraMarker)

		Utility.Wait(1.0)
		ReleaseThread()
	EndEvent
EndState


State Exiting
	Event OnBeginState(string asOldState)
		Utility.Wait(1.0)

		Game.ShowFirstPersonGeometry(true)
		Game.SetInChargen(false, false, false)
		Game.SetCharGenHUDMode(HudStandard)

		Game.SetPlayerAIDriven(false)
		Player.MoveTo(Blackjack.EntryPoint)
		Player.SetScale(1.0)

		If (InputLayer)
			InputLayer.Delete()
			InputLayer = none
		EndIf

		ReleaseThread()
	EndEvent
EndState


; Properties
;---------------------------------------------

Group Object
	Blackjack:Game Property Blackjack Auto Const Mandatory
EndGroup

Group Markers
	ObjectReference Property Games_Blackjack_CellMarker Auto Const Mandatory
	ObjectReference Property Games_Blackjack_CameraMarker Auto Const Mandatory
EndGroup
