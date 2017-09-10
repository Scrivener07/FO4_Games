ScriptName Games:Blackjack:Tasks:Table extends Games:Blackjack:Task
import Games
import Games:Blackjack
import Games:Papyrus:Log
import Games:Papyrus:Script

Actor Player
InputEnableLayer InputLayer

float TimeWait = 2.0 const
int HudStandard = 0 const
int HudHidden = 3 const


; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
EndEvent


; Task
;---------------------------------------------

State Starting
	Event OnBeginState(string asOldState)
		Player.MoveTo(Games_Blackjack_CellMarker)

		Game.SetInChargen(true, true, false)
		Game.ShowFirstPersonGeometry(false)
		; InputLayer = InputEnableLayer.Create()
		; InputLayer.DisablePlayerControls(true, true, true, true, true, true, false, true, true, true, true)
		; Game.SetPlayerAIDriven()
		; Game.SetCharGenHUDMode(HudHidden)
		Player.SetScale(0.75)
		Game.StartDialogueCameraOrCenterOnTarget(Games_Blackjack_CameraMarker)

		Utility.Wait(TimeWait)
		TaskEnd(self)
	EndEvent
EndState


State Exiting
	Event OnBeginState(string asOldState)
		Utility.Wait(TimeWait)

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
