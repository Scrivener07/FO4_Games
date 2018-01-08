ScriptName Games:Blackjack:PlayerType extends Games:Blackjack:GameType Native Hidden
import Games:Papyrus:Log


Struct SessionData
	int Winnings = 0
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


; Starting
;---------------------------------------------

State Starting
	Event Starting()
		{Allocate data for new game session.}
	EndEvent

	Event StartBegin()
		{TODO}
	EndEvent

	Event SetMarkers(MarkerValue set)
		{Required - Destination markers for motion.}
		WriteMessage(self, "Error, I forgot to implement the SetMarkers event!")
	EndEvent
EndState

Event StartBegin() Native
Event SetMarkers(MarkerValue set) Native


; Wagering
;---------------------------------------------

State Wagering
	Event Wagering()
		{Wagering}
	EndEvent

	Event WagerBegin()
		{TODO}
	EndEvent

	Event SetWager(WagerValue set)
		{Set the amount of caps to wager.}
		WriteMessage(self, "Error, I forgot to implement the SetWager event!")
	EndEvent
EndState

Event WagerBegin() Native
Event SetWager(WagerValue set) Native
Function IncreaseWager(int value) Native
Function DecreaseWager(int value) Native


; Dealing
;---------------------------------------------

State Dealing
	Event Dealing()
		{Dealing}
	EndEvent

	Event DealBegin()
		{TODO}
	EndEvent
EndState

Event DealBegin() Native


; Playing
;---------------------------------------------

State Playing
	Event Playing()
		{Playing}
	EndEvent

	Event PlayBegin(int aTurn)
		{The given turn is beginning.}
	EndEvent

	Event SetChoice(ChoiceValue set)
		{Configure the choice data for this play.}
		WriteMessage(self, "Error, I forgot to implement the SetChoice event!")
	EndEvent
EndState

Event PlayBegin(int aTurn) Native
Event SetChoice(ChoiceValue set) Native


; Scoring
;---------------------------------------------

State Scoring
	Event Scoring()
		{Scoring}
	EndEvent

	Event ScoreBegin()
		{TODO}
	EndEvent

	Event ScoreEnd()
		{TODO}
	EndEvent
EndState

Event ScoreBegin() Native
Event ScoreEnd() Native


; Virtual
;---------------------------------------------

int Function GetBank()
	{The amount of caps the player has to gamble with.}
	return 999
EndFunction


; Properties
;---------------------------------------------

Group Choice
	int Property ChoiceHit = 0 AutoReadOnly
	int Property ChoiceStand = 1 AutoReadOnly
	int Property ChoiceDouble = 2 AutoReadOnly ; not supported
	int Property ChoiceSplit = 3 AutoReadOnly  ; not supported
EndGroup
