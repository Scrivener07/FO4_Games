ScriptName Games:Blackjack:Game extends Games:Blackjack:GameType
import Games
import Games:Shared
import Games:Shared:Deck
import Games:Papyrus:Log
import Games:Papyrus:Script


ObjectReference Entry
CustomEvent PhaseEvent

float TimeWait = 3.0 const


; Events
;---------------------------------------------

Event OnInit()
	RegisterForPhaseEvent(self)
EndEvent


Event OnGamePhase(PhaseEventArgs e)
	WriteLine(self, "OnGamePhase " + e.Name)
EndEvent


; Methods
;---------------------------------------------

bool Function Play(ObjectReference aEntryPoint)
	If (Idling)
		If (aEntryPoint)
			Entry = aEntryPoint
			return ChangeState(self, StartingTask)
		Else
			WriteLine(self, "The game needs an entry point reference to play.")
			return false
		EndIf
	Else
		WriteLine(self, "The game is not ready to play right now.")
		return false
	EndIf
EndFunction


bool Function RegisterForPhaseEvent(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "PhaseEvent")
		return true
	Else
		WriteLine(self, "Cannot register a none script for phase events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForPhaseEvent(Blackjack:Game script)
	If (script)
		script.UnregisterForCustomEvent(self, "PhaseEvent")
		return true
	Else
		WriteLine(self, "Cannot unregister a none script for phase events.")
		return false
	EndIf
EndFunction


; Tasks
;---------------------------------------------

State Starting
	Event OnBeginState(string asOldState)
		{Session Begin}
		WriteLine("Phase", "Starting")
		If (Session.Human.HasCaps == false)
			ChangeState(self, NoTask)
			WriteMessage(self, "Kicked", "You dont have any caps to play Blackjack.")
			return
		EndIf

		If (SendPhase(self, StartingTask, Begun))
			Display.Visible = true
			TaskAwait(Table, StartingTask)
			TaskAwait(Cards, StartingTask)
			TaskAwait(Session, StartingTask)
			ChangeState(self, WageringTask)
		Else
			ChangeState(self, ExitingTask)
		EndIf
	EndEvent

	Event OnEndState(string asNewState)
		If (asNewState == WageringTask)
			SendPhase(self, StartingTask, Ended)
		EndIf
	EndEvent
EndState


State Wagering
	Event OnBeginState(string asOldState)
		{Game State}
		WriteLine("Phase", "Wagering")
		If (Session.Human.HasCaps == false)
			ChangeState(self, ExitingTask)
			Dialog.ShowKicked()
			return
		EndIf

		If (SendPhase(self, WageringTask, Begun))
			Utility.Wait(TimeWait)
			TaskAwait(Session, WageringTask)

			If (Session.Human.Bet == Invalid)
				ChangeState(self, ExitingTask)
			Else
				ChangeState(self, DealingTask)
			EndIf
		Else
			ChangeState(self, ExitingTask)
		EndIf
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, WageringTask, Ended)
	EndEvent
EndState


State Dealing
	Event OnBeginState(string asOldState)
		{Game State}
		WriteLine("Phase", "Dealing")
		If (SendPhase(self, DealingTask, Begun))
			Utility.Wait(TimeWait)
			Cards.Shuffle()
			TaskAwait(Session, DealingTask)
			ChangeState(self, PlayingTask)
		Else
			ChangeState(self, ExitingTask)
		EndIf
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, DealingTask, Ended)
	EndEvent
EndState


State Playing
	Event OnBeginState(string asOldState)
		{Game State}
		WriteLine("Phase", "Playing")
		If (SendPhase(self, PlayingTask, Begun))
			Utility.Wait(TimeWait)
			TaskAwait(Session, PlayingTask)
			ChangeState(self, ScoringTask)
		Else
			ChangeState(self, ExitingTask)
		EndIf
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, PlayingTask, Ended)
	EndEvent
EndState


State Scoring
	Event OnBeginState(string asOldState)
		{Game State}
		WriteLine("Phase", "Scoring")
		If (SendPhase(self, ScoringTask, Begun))
			Utility.Wait(TimeWait)
			TaskAwait(Session, ScoringTask)

			If (Session.Human.HasCaps)
				If (Dialog.PlayAgain())
					ChangeState(self, WageringTask)
				Else
					ChangeState(self, ExitingTask)
				EndIf
			Else
				ChangeState(self, ExitingTask)
				Dialog.ShowKicked()
			EndIf

		Else
			ChangeState(self, ExitingTask)
		EndIf
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, ScoringTask, Ended)
	EndEvent
EndState


State Exiting
	Event OnBeginState(string asOldState)
		{Session End}
		WriteLine("Phase", "Exiting")
		If (SendPhase(self, ExitingTask, Begun))
			Utility.Wait(TimeWait)
			Display.Visible = false
			TaskAwait(Table, ExitingTask)
			TaskAwait(Cards, ExitingTask)
			TaskAwait(Session, ExitingTask)
		EndIf
		ChangeState(self, NoTask)
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, ExitingTask, Ended)
	EndEvent
EndState


; Properties
;---------------------------------------------

Group Tasks
	Tasks:Table Property Table Auto Const Mandatory
	Tasks:Session Property Session Auto Const Mandatory
	Tasks:Cards Property Cards Auto Const Mandatory
EndGroup

Group UI
	Blackjack:Display Property Display Auto Const Mandatory
	Blackjack:Dialog Property Dialog Auto Const Mandatory
EndGroup

Group Actions
	ObjectReference Property EntryPoint Hidden
		ObjectReference Function Get()
			return Entry
		EndFunction
	EndProperty
EndGroup
