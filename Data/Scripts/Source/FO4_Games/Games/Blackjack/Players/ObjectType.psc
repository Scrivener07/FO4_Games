ScriptName Games:Blackjack:Players:ObjectType extends Games:Blackjack:Type Native Hidden
import Games:Shared:Deck
import Games:Shared:Log
import Games:Shared:Papyrus

; Data
;---------------------------------------------

Struct SessionData
	int Earnings = 0
	bool Quit = false
EndStruct

Struct MatchData
	int Bet = 0
	int Debt = 0
	int Turn = 0
	int Choice = -1
EndStruct


; Abstract
;---------------------------------------------

Event OnTurn(BooleanValue continue) Native
	{The implementation is called at the start of each turn while playing.}

Event OnScoring(int scoring) Native
	{The implementation is called when scoring is resolved.}

Function WagerSet(IntegerValue setter) Native
	{Use the setter to set the wager value.}

Function ChoiceSet(IntegerValue setter) Native
	{Use the setter to set the choice value.}


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
EndGroup

Group Score
	{The result type for scoring.}
	int Property ScoreLose = 0 AutoReadOnly
	int Property ScoreWin = 1 AutoReadOnly
	int Property ScoreBlackjack = 2 AutoReadOnly
	int Property ScorePush = 3 AutoReadOnly
EndGroup
