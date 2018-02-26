ScriptName Games:Blackjack:Environment extends Games:Blackjack:Type
import Games:Shared:Log

Actor Player
ObjectReference ExitMarker
InputEnableLayer InputLayer


; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
EndEvent


; Methods
;---------------------------------------------

bool Function SetExit(ObjectReference aExitMarker)
	If (aExitMarker)
		ExitMarker = aExitMarker
		return true
	Else
		WriteUnexpectedValue(self, "SetExit", "aExitMarker", "The exit marker reference cannot be none.")
		return false
	EndIf
EndFunction


; States
;---------------------------------------------

State Starting
	Event OnState()
		{Starting}
		; Fade to a black screen over 1 second and leave up fader when done
		Game.FadeOutGame(true, true, 1.0, 1.0, true)
		Player.MoveTo(Games_Blackjack_CellMarker)

		Game.SetInChargen(true, true, false)
		InputLayer = InputEnableLayer.Create()
		InputLayer.EnableMovement(false)
		InputLayer.EnableLooking(false)
		InputLayer.EnableCamSwitch(false)
		InputLayer.EnableMenu(false)
		InputLayer.EnableVATS(false)
		InputLayer.EnableFighting(false)

		Game.SetPlayerAIDriven()
		Game.ShowFirstPersonGeometry(false)
		Player.SetScale(0.35)
		Game.StartDialogueCameraOrCenterOnTarget(Games_Blackjack_CameraMarker)

		; Spend 2 seconds on a black screen before fading in to the game over 1 second and hide fader when done
		Game.FadeOutGame(false, true, 2.0, 1.0)
	EndEvent
EndState


State Exiting
	Event OnState()
		{Exiting}
		Game.FadeOutGame(true, true, 1.0, 1.0, true)
		Game.SetInChargen(false, false, false)
		If (InputLayer)
			InputLayer.Delete()
			InputLayer = none
		EndIf
		Game.SetPlayerAIDriven(false)
		Game.ShowFirstPersonGeometry(true)
		Player.SetScale(1.0)
		Player.MoveTo(ExitMarker, -120.0)
		Game.FadeOutGame(false, true, 2.0, 1.0)
	EndEvent
EndState


; Properties
;---------------------------------------------

Group Markers
	ObjectReference Property Games_Blackjack_CellMarker Auto Const Mandatory
	ObjectReference Property Games_Blackjack_CameraMarker Auto Const Mandatory
EndGroup
