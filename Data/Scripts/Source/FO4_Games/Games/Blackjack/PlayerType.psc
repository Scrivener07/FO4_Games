ScriptName Games:Blackjack:PlayerType extends Games:Blackjack:Type Native Hidden
import Games:Shared:Deck
import Games:Shared:Log

; Data
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


; Logic
;---------------------------------------------

Event OnDrawn(Card drawn, ObjectReference marker) Native
Event OnTurn(int number) Native
Event OnScoring(int scoring) Native


; Seating
;---------------------------------------------

Struct Seat
	ObjectReference Card01
	ObjectReference Card01Reveal
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

ObjectReference Function GetMarkerFor(Seat seat, int next)
	If (next == Invalid)
		return seat.Card01
	ElseIf (next == 0)
		return seat.Card02
	ElseIf (next == 1)
		return seat.Card03
	ElseIf (next == 2)
		return seat.Card04
	ElseIf (next == 3)
		return seat.Card05
	ElseIf (next == 4)
		return seat.Card06
	ElseIf (next == 5)
		return seat.Card07
	ElseIf (next == 6)
		return seat.Card08
	ElseIf (next == 7)
		return seat.Card09
	ElseIf (next == 8)
		return seat.Card10
	ElseIf (next == 9)
		return seat.Card11
	Else
		WriteUnexpectedValue(self, "NextMarker", "next", "The next marker "+next+" is out of range.")
		return none
	EndIf
EndFunction


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
