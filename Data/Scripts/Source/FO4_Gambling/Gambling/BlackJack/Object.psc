ScriptName Gambling:BlackJack:Object extends ScriptObject Native Const Hidden


Group Game
	string Property Invalid = -1 AutoReadOnly
EndGroup


; Phase --------------------------------------
;---------------------------------------------

Struct PhaseEventArgs
	string Name
	bool Change = true
EndStruct


Group PhaseNames
	string Property IdlePhase = "" AutoReadOnly
	string Property StartingPhase = "Starting" AutoReadOnly
	string Property WageringPhase = "Wagering" AutoReadOnly
	string Property DealingPhase = "Dealing" AutoReadOnly
	string Property PlayingPhase = "Playing" AutoReadOnly
	string Property ScoringPhase = "Scoring" AutoReadOnly
	string Property ExitingPhase = "Exiting" AutoReadOnly
EndGroup


Group PhaseChanges
	bool Property Begun = true AutoReadOnly
	bool Property Ended = false AutoReadOnly
EndGroup
