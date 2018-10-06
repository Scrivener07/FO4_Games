Scriptname Games:Type extends Quest Hidden Native Const
{The base script type for all game scripts which instantiate long running instances via Quest forms.}
import Games:Shared:Log
import Games:Shared:Papyrus

; Initialize
;---------------------------------------------

Event OnQuestInit()
	{Allows scripts to be reinitialized by starting the quest.}
	WriteLine(ToString(), "Initialized with OnQuestInit event.")
EndEvent


Event OnQuestShutdown()
	{Allows scripts to be shutdown by stopping the quest.}
	WriteLine(ToString(), "Shutdown with OnQuestShutdown event.")
EndEvent


; States
;---------------------------------------------

Event OnBeginState(string asOldState)
	If (!IsEmptyState)
		RunOnce()
	EndIf
EndEvent


Event OnState()
	{Base event for self terminating states.}
	; Note: Override the `OnBeginState` event to prevent the run once behavior of states.
	WriteNotImplemented(ToString(), "OnState", "Must be implemented on an extending child script.")
EndEvent


bool Function RunOnce()
	{Runs the state one time and then clears all states.}
	If (!IsEmptyState)
		OnState()
		return ClearState(self)
	Else
		WriteUnexpectedValue(ToString(), "RunOnce", "IsEmptyState", "Cannot run once in the empty state.")
		return false
	EndIf
EndFunction


; OnGameReload
;---------------------------------------------

Event OnGameReload() Native
	{Event occurs when the game has been reloaded.}

Event Actor.OnPlayerLoadGame(Actor sender)
	{Do not override this in extending scripts, use OnGameReload}
	OnGameReload()
EndEvent

bool Function RegisterForGameReload(Games:Type this)
	{Registers the game type for reload events.}
	return this.RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
EndFunction

Function UnregisterForGameReload(Games:Type this)
	{Unregisters the game type for reload events.}
	this.UnregisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
EndFunction


; Functions
;---------------------------------------------

string Function ToString()
	{The string representation of this script.}
	If (IsEmptyState)
		return self
	Else
		return self+"["+StateName+"]"
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	int Property Invalid = -1 AutoReadOnly
	{A generic invalid flag.}
EndGroup

Group States
	string Property StateName Hidden
		{A property alias for the GetState function.}
		string Function Get()
			return GetState()
		EndFunction
	EndProperty

	bool Property IsEmptyState Hidden
		{Returns true if this script has the empty state.}
		bool Function Get()
			return StateName == EmptyState
		EndFunction
	EndProperty

	string Property EmptyState Hidden
		{The default papyrus script state is represented as an empty string.}
		string Function Get()
			return ""
		EndFunction
	EndProperty
EndGroup
