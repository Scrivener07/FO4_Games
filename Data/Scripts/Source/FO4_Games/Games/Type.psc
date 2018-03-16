Scriptname Games:Type extends Quest Hidden Native Const
{The base script type for all game scripts which instantiate long running instances via Quest forms.}

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
