
ScriptName BarstoolGames:WorkshopBlackjackTableScript extends WorkshopObjectScript


Actor Property thisOwnerNPC Auto Hidden
Faction Property Games_WorkshopDealersFaction Auto Const Mandatory


Event Actor.OnDeath(Actor akDeadActor, Actor akKiller)
	{Called when the assigned actor dies.}
	Debug.TraceSelf(self, "Actor.OnDeath", "The assigned actor has died.")
	Cleanup()
EndEvent


Function AssignActorCustom(WorkshopNPCScript newActor)
	{Called after `WorkshopObjectScript.AssignActor`. Registers for death and adds a faction.}
	If(newActor)
		If(newActor != thisOwnerNPC)
			thisOwnerNPC = newActor
			RegisterForRemoteEvent(newActor, "OnDeath")
			thisOwnerNPC.AddToFaction(Games_WorkshopDealersFaction)
			Debug.TraceSelf(self, "AssignActorCustom", "The "+newActor+" has been assigned.")
		Else
			Debug.TraceSelf(self, "AssignActorCustom", "Cannot assign "+newActor+" because they are already assigned.")
		EndIf
	Else
		Debug.TraceSelf(self, "AssignActorCustom", "Cannot assign a none actor.")
		Cleanup()
	EndIf
EndFunction


Function Cleanup()
	{Unassigns the actor from this object.}
	thisOwnerNPC.RemoveFromFaction(Games_WorkshopDealersFaction)
	UnregisterForRemoteEvent(thisOwnerNPC, "OnDeath")
	thisOwnerNPC = none
	Debug.TraceSelf(self, "Cleanup", "The assigned actor has been cleaned up.")
EndFunction
