ScriptName Games:Blackjack:Players:Abraham extends Games:Blackjack:Player

;/ Personality
	High Roller (Whale)
	Be the highest betting player at the table.
	TODO: expose the highest bet among players
/;

; Tasks
;---------------------------------------------

State Starting
	Event SetMarkers(MarkerValue set)
		set.Card01 = Games_Blackjack_P2C01
		set.Card02 = Games_Blackjack_P2C02
		set.Card03 = Games_Blackjack_P2C03
		set.Card04 = Games_Blackjack_P2C04
		set.Card05 = Games_Blackjack_P2C05
		set.Card06 = Games_Blackjack_P2C06
		set.Card07 = Games_Blackjack_P2C07
		set.Card08 = Games_Blackjack_P2C08
		set.Card09 = Games_Blackjack_P2C09
		set.Card10 = Games_Blackjack_P2C10
		set.Card11 = Games_Blackjack_P2C11
	EndEvent
EndState


State Wagering
	Event SetWager(WagerValue set)
		set.Bet = (Blackjack.Human.Bet * 3) + 50
	EndEvent
EndState


; Properties
;---------------------------------------------

Group Markers
	ObjectReference Property Games_Blackjack_P2C01 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C02 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C03 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C04 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C05 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C06 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C07 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C08 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C09 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C10 Auto Const Mandatory
	ObjectReference Property Games_Blackjack_P2C11 Auto Const Mandatory
EndGroup
