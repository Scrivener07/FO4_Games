ScriptName Games:Blackjack:PlayerType extends Games:Blackjack:GameType Native Hidden
import Games:Papyrus:Log


; FSM - Finite State Machine
;---------------------------------------------

State Starting
	Event Starting()
		{Allocate data for new game session.}
	EndEvent

	Event SetMarkers(MarkerValue set)
		{Required - Destination markers for motion.}
		WriteMessage(self, "Error, I forgot to implement the SetMarkers event!")
	EndEvent
EndState


State Wagering
	Event Wagering()
		{Wagering}
	EndEvent

	Event SetWager(WagerValue set)
		{Set the amount of caps to wager.}
		WriteMessage(self, "Error, I forgot to implement the SetWager event!")
	EndEvent
EndState


State Dealing
	Event Dealing()
		{Dealing}
	EndEvent
EndState


State Playing
	Event Playing()
		{Playing}
	EndEvent

	Event PlayTurn(int aTurn)
		{The given turn is beginning.}
	EndEvent

	Event SetChoice(ChoiceValue set)
		{Configure the choice data for this play.}
		WriteMessage(self, "Error, I forgot to implement the SetChoice event!")
	EndEvent
EndState


State Scoring
	Event Scoring()
		{Scoring}
	EndEvent
EndState


; Abstract
;---------------------------------------------

Event SetMarkers(MarkerValue set) Native

Event SetWager(WagerValue set) Native
Function IncreaseWager(int value) Native
Function DecreaseWager(int value) Native

Event PlayTurn(int aTurn) Native
Event SetChoice(ChoiceValue set) Native

Event OnScore(int scoring) Native
Function IncreaseEarnings(int value) Native
Function DecreaseEarnings(int value) Native
Function SessionRematch(bool value) Native



; Virtual
;---------------------------------------------

int Function GetBank()
	{The amount of caps the player has to gamble with.}
	return 1000
EndFunction


; Properties
;---------------------------------------------

Struct SessionData
	int Earnings = 0
	bool Rematch = false
EndStruct

Struct MatchData
	int Turn = 0
	int Score = 0
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

Struct WagerValue
	int Bet = 0
EndStruct

Struct ChoiceValue
	int Selected = -1
EndStruct


Group Choice
	int Property ChoiceHit = 0 AutoReadOnly
	int Property ChoiceStand = 1 AutoReadOnly
	int Property ChoiceDouble = 2 AutoReadOnly ; not supported
	int Property ChoiceSplit = 3 AutoReadOnly  ; not supported
EndGroup

Group Scoring
	int Property ScoreLose = 0 AutoReadOnly
	int Property ScoreWin = 1 AutoReadOnly
	int Property ScorePush = 2 AutoReadOnly
EndGroup
