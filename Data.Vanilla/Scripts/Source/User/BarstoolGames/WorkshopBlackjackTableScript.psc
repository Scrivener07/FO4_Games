
ScriptName BarstoolGames:WorkshopBlackjackTableScript extends WorkshopObjectScript


Actor Property thisOwnerNPC Auto Hidden
Faction Property GamesWorkshopDealersFaction Auto Const Mandatory

Event Actor.OnDeath(Actor akDeadActor, Actor akKiller)
	Cleanup()
EndEvent


Function AssignActorCustom(WorkshopNPCScript newActor)
	if(newActor)
		if(newActor as Actor != thisOwnerNPC)
			thisOwnerNPC = newActor
			RegisterForRemoteEvent(newActor, "OnDeath")
			thisOwnerNPC.AddToFaction(GamesWorkshopDealersFaction)
		endif
	else
		Cleanup()
	endif
	
Parent.AssignActor(newActor)

EndFunction


Function Cleanup()
	thisOwnerNPC.RemoveFromFaction(GamesWorkshopDealersFaction)
	UnregisterForRemoteEvent(thisOwnerNPC, "OnDeath")
	thisOwnerNPC = None
EndFunction



