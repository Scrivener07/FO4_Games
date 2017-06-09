ScriptName Gambling:BlackJack:Players:BotWhale extends Gambling:BlackJack:Player
import Gambling
import Gambling:Shared
import Gambling:Shared:Common

;/ Personality
	High Roller (Whale)
	Be the highest betting player at the table.
/;


; Player
;---------------------------------------------

int Function BehaviorWager()
	; TODO: expose the highest bet
	return (BlackJack.Players.Human.Wager * 3) + 50
EndFunction
