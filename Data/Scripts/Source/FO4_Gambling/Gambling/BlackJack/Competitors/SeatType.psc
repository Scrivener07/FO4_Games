ScriptName Gambling:BlackJack:Competitors:SeatType extends ReferenceAlias Native Const Hidden
import Gambling
import Gambling:Common


; Virtuals
;---------------------------------------------

Event OnStartup()
	{Virtual}
EndEvent


Event OnWager()
	{Virtual}
EndEvent


Event OnDeal(Deck:Card aCard, int aIndex)
	{Virtual}
EndEvent


Event OnPlay()
	{Virtual}
EndEvent


Event OnShutdown()
	{Virtual}
EndEvent
