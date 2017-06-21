ScriptName Gambling:Blackjack:Components:Table extends Gambling:Blackjack:Component
import Gambling
import Gambling:Blackjack
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

State Starting
	Event OnBeginState(string asOldState)
		Game.SetPlayerAIDriven()

		Player.MoveTo(Gambling_Blackjack_CellMarker)

		InputLayer = InputEnableLayer.Create()
		InputLayer.DisablePlayerControls(true, true, true, true, true, true, true, true, true, true, true)

		Game.StartDialogueCameraOrCenterOnTarget(Gambling_Blackjack_CameraMarker)

		ReleaseThread()
	EndEvent
EndState


State Exiting
	Event OnBeginState(string asOldState)
		Game.SetPlayerAIDriven(false)

		If (PlayAction)
			Player.MoveTo(PlayAction as ObjectReference)
		EndIf

		If (InputLayer)
			InputLayer.Delete()
			InputLayer = none
		EndIf

		ReleaseThread()
	EndEvent
EndState


; Properties
;---------------------------------------------

Group Actions
	Actions:Play Property PlayAction Auto Hidden
EndGroup

Group Markers
	ObjectReference Property Gambling_Blackjack_CellMarker Auto Const Mandatory
	ObjectReference Property Gambling_Blackjack_CameraMarker Auto Const Mandatory
EndGroup
