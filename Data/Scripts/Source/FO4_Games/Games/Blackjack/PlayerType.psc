ScriptName Games:Blackjack:PlayerType extends Games:Blackjack:GameType Native Hidden
import Games:Shared:Log

; FSM - Finite State Machine
;---------------------------------------------

State Starting
	Event OnTask()
		{Allocate data for new game session.}
		WriteNotImplemented(self, "Starting.OnTask", "The member must be implemented on and extending script.")
	EndEvent
EndState

State Wagering
	Event OnTask()
		{Wagering}
		WriteNotImplemented(self, "Wagering.OnTask", "The member must be implemented on and extending script.")
	EndEvent
EndState

State Dealing
	Event OnTask()
		{Dealing}
		WriteNotImplemented(self, "Dealing.OnTask", "The member must be implemented on and extending script.")
	EndEvent
EndState

State Playing
	Event OnTask()
		{Playing}
		WriteNotImplemented(self, "Playing.OnTask", "The member must be implemented on and extending script.")
	EndEvent
EndState

State Scoring
	Event OnTask()
		{Scoring}
		WriteNotImplemented(self, "Scoring.OnTask", "The member must be implemented on and extending script.")
	EndEvent
EndState

State Exiting
	Event OnTask()
		{Exiting}
		WriteNotImplemented(self, "Exiting.OnTask", "The member must be implemented on and extending script.")
	EndEvent
EndState


; Abstract
;---------------------------------------------

Event OnTurn(int aTurn) Native
Event OnScoreLose() Native
Event OnScoreWin() Native
Event OnScorePush() Native
Event OnScoreError() Native


; Properties
;---------------------------------------------

Struct SessionData
	int Earnings = 0
EndStruct

Struct MatchData
	bool Rematch = false
	int Bet = 0
	int Score = 0
	int Turn = 0
	int TurnChoice = -1
	int Winnings = 0
EndStruct

Struct MarkerValue
	ObjectReference Card01
	ObjectReference Card02
	ObjectReference Card03
	ObjectReference Card04
	ObjectReference Card05
	ObjectReference Card06
	ObjectReference Card07
	ObjectReference Card08
	ObjectReference Card09
	ObjectReference Card10
	ObjectReference Card11
EndStruct

Group Choice
	{The choice type for playing.}
	int Property ChoiceHit = 0 AutoReadOnly
	int Property ChoiceStand = 1 AutoReadOnly
	int Property ChoiceDouble = 2 AutoReadOnly ; not supported
	int Property ChoiceSplit = 3 AutoReadOnly  ; not supported
EndGroup

Group Result
	{The result type for scoring.}
	int Property ScoreLose = 0 AutoReadOnly
	int Property ScoreWin = 1 AutoReadOnly
	int Property ScorePush = 2 AutoReadOnly
EndGroup


Group Wager
	int Property WagerStep = 5 AutoReadOnly
	int Property WagerMinimum = 5 AutoReadOnly
	int Property WagerMaximum = 50 AutoReadOnly
EndGroup
