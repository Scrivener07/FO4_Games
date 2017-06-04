ScriptName Gambling:BlackJack:Players:PlayerType extends ReferenceAlias Native Const Hidden
import Gambling:Shared


; Virtuals
;---------------------------------------------

Event OnInitialize()
	{Virtual}
EndEvent


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
