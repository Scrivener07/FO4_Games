ScriptName Games:Blackjack:PlayerType extends Games:Blackjack:Type Native Hidden
import Games:Shared:Deck
import Games:Shared:Log

; States
;---------------------------------------------

State Starting
	Event OnState()
		{Allocate data for new game session.}
		WriteNotImplemented(self, "Starting.OnState", "The member must be implemented on and extending script.")
	EndEvent
EndState

State Wagering
	Event OnState()
		{Wagering}
		WriteNotImplemented(self, "Wagering.OnState", "The member must be implemented on and extending script.")
	EndEvent
EndState

State Dealing
	Event OnState()
		{Dealing}
		WriteNotImplemented(self, "Dealing.OnState", "The member must be implemented on and extending script.")
	EndEvent
EndState

State Playing
	Event OnState()
		{Playing}
		WriteNotImplemented(self, "Playing.OnState", "The member must be implemented on and extending script.")
	EndEvent
EndState

State Scoring
	Event OnState()
		{Scoring}
		WriteNotImplemented(self, "Scoring.OnState", "The member must be implemented on and extending script.")
	EndEvent
EndState

State Exiting
	Event OnState()
		{Exiting}
		WriteNotImplemented(self, "Exiting.OnState", "The member must be implemented on and extending script.")
	EndEvent
EndState


; Abstract
;---------------------------------------------

Event OnDrawn(Card drawn, ObjectReference marker) Native
Event OnTurn(int number) Native
Event OnScoring(int scoring) Native


; Structures
;---------------------------------------------

Struct SessionData
	int Earnings = 0
	bool Continue = true
EndStruct

Struct MatchData
	int Bet = 0
	int Score = 0
	int Turn = 0
	int TurnChoice = -1
	int Debt = 0
EndStruct


; Properties
;---------------------------------------------

Group Wager
	{The wager values.}
	int Property WagerStep = 5 AutoReadOnly
	int Property WagerMinimum = 5 AutoReadOnly
	int Property WagerMaximum = 50 AutoReadOnly
EndGroup

Group Choice
	{The choice type for playing.}
	int Property ChoiceHit = 0 AutoReadOnly
	int Property ChoiceStand = 1 AutoReadOnly
	int Property ChoiceDouble = 2 AutoReadOnly
	int Property ChoiceSplit = 3 AutoReadOnly
	int Property ChoiceSplitSwitch = 4 AutoReadOnly
EndGroup

Group Score
	{The result type for scoring.}
	int Property ScoreLose = 0 AutoReadOnly
	int Property ScoreWin = 1 AutoReadOnly
	int Property ScoreBlackjack = 2 AutoReadOnly
	int Property ScorePush = 3 AutoReadOnly
EndGroup
