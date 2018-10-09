ScriptName Games:Blackjack:Setup extends Games:Blackjack:Type
import Games:Shared:Log

Actor Player
ObjectReference ExitMarker
InputEnableLayer InputLayer

string HavokDisablePlayerCollision = "bDisablePlayerCollision:Havok" const

; Events
;---------------------------------------------

Event OnQuestInit()
	Player = Game.GetPlayer()
EndEvent


; Methods
;---------------------------------------------

bool Function SetExit(ObjectReference reference)
	If (reference)
		ExitMarker = reference
		return true
	Else
		WriteUnexpectedValue(ToString(), "SetExit", "reference", "The exit marker reference cannot be none.")
		return false
	EndIf
EndFunction


Function FadeGameOut()
	{Fade to a black screen over 1 second and leave up fader when done.}
	Game.FadeOutGame(true, true, 1.0, 1.0, true)
	Utility.Wait(2.1)
EndFunction


Function FadeGameIn()
	{Spend 2 seconds on a black screen before fading in to the game over 1 second and hide fader when done.}
	Game.FadeOutGame(false, true, 2.0, 1.0)
	Utility.Wait(3.1)
EndFunction


; States
;---------------------------------------------

State Starting
	Event OnState()
		{Starting}
		FadeGameOut()
		Utility.SetIniBool(HavokDisablePlayerCollision, true)
		Player.MoveTo(Games_Blackjack_CellMarker)
		Game.ForceFirstPerson()
		Utility.Wait(1.0)

		InputLayer = InputEnableLayer.Create()
		InputLayer.EnableMovement(false)
		InputLayer.EnableLooking(false)
		InputLayer.EnableCamSwitch(false)
		InputLayer.EnableMenu(false)
		InputLayer.EnableVATS(false)
		InputLayer.EnableFighting(false)
		InputLayer.EnableActivate(false)
		InputLayer.EnableZKey(false)

		Game.SetPlayerAIDriven()
		Game.ShowFirstPersonGeometry(false)
		Game.SetInChargen(true, true, false)
		Player.SetScale(0.35)

		Game.StartDialogueCameraOrCenterOnTarget(Games_Blackjack_CameraMarker)

		FadeGameIn()
	EndEvent
EndState


State Exiting
	Event OnState()
		{Exiting}
		FadeGameOut()

		If (InputLayer)
			InputLayer.Delete()
			InputLayer = none
		EndIf

		Game.SetPlayerAIDriven(false)
		Game.ShowFirstPersonGeometry(true)
		Game.SetInChargen(false, false, false)
		Player.SetScale(1.0)

		Player.MoveTo(ExitMarker, -120.0)
		Utility.SetIniBool(HavokDisablePlayerCollision, false)
		FadeGameIn()
	EndEvent
EndState


; Properties
;---------------------------------------------

Group Markers
	ObjectReference Property Games_Blackjack_CellMarker Auto Const Mandatory
	ObjectReference Property Games_Blackjack_CameraMarker Auto Const Mandatory
EndGroup
