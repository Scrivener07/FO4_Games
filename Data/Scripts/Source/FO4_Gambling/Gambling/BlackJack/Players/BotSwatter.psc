ScriptName Gambling:BlackJack:Players:BotSwatter extends Gambling:BlackJack:Player

;/ Personality
	Swatter
	-Really likes to hit on their turn.
/;


; Player
;---------------------------------------------

int Function BehaviorTurn()
	If (Score <= 18)
		return OptionHit
	Else
		return OptionStand
	EndIf
EndFunction
