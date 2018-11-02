
ScriptName BarstoolGames:WorkshopBlackjackTableScript extends WorkshopObjectScript

Actor Property thisOwnerNPC Auto Hidden
Faction Property Games_WorkshopDealersFaction Auto Const Mandatory


Event Actor.OnDeath(Actor akDeadActor, Actor akKiller)
	Cleanup()
EndEvent


function AssignActorCustom(workshopnpcscript newActor)
	;begin BG block
	if(newActor)
		if(newActor as Actor != thisOwnerNPC)
			thisOwnerNPC = newActor
			RegisterForRemoteEvent(newActor, "OnDeath")
			thisOwnerNPC.AddToFaction(Games_WorkshopDealersFaction)
		endif
	else
		Cleanup()
	endif
	;end BG block
endFunction



Function Cleanup()
	thisOwnerNPC.RemoveFromFaction(Games_WorkshopDealersFaction)
	UnregisterForRemoteEvent(thisOwnerNPC, "OnDeath")
	thisOwnerNPC = None
EndFunction



