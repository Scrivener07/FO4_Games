ScriptName Games:Blackjack:Tasks:Table extends Games:Blackjack:GameType
import Games
import Games:Blackjack
import Games:Shared:Log
import Games:Shared:Papyrus

Actor Player
InputEnableLayer InputLayer


; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
EndEvent


; FSM - Finite State Machine
;---------------------------------------------

State Starting
	Event OnBeginState(string asOldState)
		; Fade to a black screen over 1 second and leave up fader when done
		Game.FadeOutGame(true, true, 1.0, 1.0, true)
		Player.MoveTo(Games_Blackjack_CellMarker)

		;Game.SetInChargen(true, true, false)
		InputLayer = InputEnableLayer.Create()
	 ;	InputLayer.EnableMovement(false)
	; 	InputLayer.EnableLooking(false)
	; 	InputLayer.EnableCamSwitch(false)
	; ;	InputLayer.EnableMenu(false)
	; 	InputLayer.EnableVATS(false)
 ; 		InputLayer.EnableFighting(false)

		Game.SetPlayerAIDriven()
		Game.ShowFirstPersonGeometry(false)
		Player.SetScale(0.45)
		Game.StartDialogueCameraOrCenterOnTarget(Games_Blackjack_CameraMarker)

		; Spend 2 seconds on a black screen before fading in to the game over 1 second and hide fader when done
		Game.FadeOutGame(false, true, 2.0, 1.0)
		TaskEnd(self)
	EndEvent
EndState


State Exiting
	Event OnBeginState(string asOldState)
		Game.FadeOutGame(true, true, 1.0, 1.0, true)

	;	Game.SetInChargen(false, false, false)
		If (InputLayer)
			InputLayer.Delete()
			InputLayer = none
		EndIf

		Game.SetPlayerAIDriven(false)
		Game.ShowFirstPersonGeometry(true)
		Player.SetScale(1.0)

		Player.MoveTo(Blackjack.EntryPoint, -120.0)
		Game.FadeOutGame(false, true, 2.0, 1.0)
		TaskEnd(self)
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
