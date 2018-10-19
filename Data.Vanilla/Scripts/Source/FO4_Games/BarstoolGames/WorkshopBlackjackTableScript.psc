
ScriptName BarstoolGames:WorkshopBlackjackTableScript extends WorkshopObjectScript

ObjectReference[] myFurnitureMarkerRefs
Actor Property thisOwnerNPC Auto Hidden
Faction Property GamesWorkshopDealersFaction Auto Const Mandatory


Event Actor.OnDeath(Actor akDeadActor, Actor akKiller)
	Cleanup()
EndEvent


function AssignActor(WorkshopNPCScript newActor = None)
	;begin BG block
	if(newActor)
		if(newActor as Actor != thisOwnerNPC)
			thisOwnerNPC = newActor
			RegisterForRemoteEvent(newActor, "OnDeath")
			thisOwnerNPC.AddToFaction(GamesWorkshopDealersFaction)
		endif
	else
		Cleanup()
	endif
	;end BG block

	;WorkshopParent.wsTrace(self + "	AssignActor: newActor=" + newActor)
	if newActor
		; if this is a bed, and has faction ownership OR actor base ownership, just keep it
		if IsBed() && ( IsOwnedBy(newActor) )
			; do nothing - editor-set faction ownership for double beds etc.
			;WorkshopParent.wsTrace(self + "	AssignActor: DO NOTHING - actor already owns this bed.")
		else
			SetActorRefOwner(newActor, true)
		endif
		;WorkshopParent.wsTrace(self + " AssignActor - " + GetActorRefOwner())
		; create furniture marker if necessary
		if FurnitureBase && myFurnitureMarkerRefs.Length == 0
			CreateFurnitureMarkers()
			UpdatePosition()
		endif
		if myFurnitureMarkerRefs.Length > 0
			SetFurnitureMarkerOwnership(newActor)
		endif

		; link actor to me if keyword
		if AssignedActorLinkKeyword
			newActor.SetLinkedRef(self, AssignedActorLinkKeyword)
		endif
	else
		SetActorRefOwner(none)
		; default ownership = player (so enemies will attack them if appropriate)
		SetActorOwner(Game.GetPlayer().GetActorBase())
		;WorkshopParent.wsTrace(self + " AssignActor: no owner, so assigning player ownership: " + GetActorOwner())
		if myFurnitureMarkerRefs.Length > 0
			; if marker placed on creation, just remove ownership
			if bPlaceMarkerOnCreation
				SetFurnitureMarkerOwnership(none)
			else
			; otherwise, delete markers when unassigned
				DeleteFurnitureMarkers()
			endif
		endif
	endif

	AssignActorCustom(newActor)
endFunction



Function Cleanup()
	thisOwnerNPC.RemoveFromFaction(GamesWorkshopDealersFaction)
	UnregisterForRemoteEvent(thisOwnerNPC, "OnDeath")
	thisOwnerNPC = None
EndFunction



