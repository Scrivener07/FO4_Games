ScriptName Gambling:BlackJack:Competitors:SeatType extends ReferenceAlias Native Const Hidden
import Gambling
import Gambling:Common
import Gambling:Shared


; Virtuals
;---------------------------------------------

Event OnStartup()
	{Virtual}
EndEvent


Event OnWager()
	{Virtual}
EndEvent


Event OnDeal(CardDeck:Card aCard, int aIndex)
	{Virtual}
EndEvent


Event OnPlay()
	{Virtual}
EndEvent


Event OnShutdown()
	{Virtual}
EndEvent
