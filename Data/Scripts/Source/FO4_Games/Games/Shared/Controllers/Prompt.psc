ScriptName Games:Shared:Controllers:Prompt extends Games:Shared:Controller
import Games:Shared:Common

; TODO: auiEntryID, is this an index or ID?
; TODO: Support for multi-input such as the bet increase would use. (OnSelected)

Actor Player
CustomEvent OnSelected

Perk MenuValue
int SelectedValue = -1
ObjectReference ActivatorValue

; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
EndEvent


; Methods
;---------------------------------------------

bool Function Display(ObjectReference aActivator, Perk aMenu)
	{Displays a perk activation menu.}
	If (aMenu)
		Clear()

		MenuValue = aMenu
		ActivatorValue = aActivator

		Player.AddPerk(aMenu)
		RegisterForRemoteEvent(aActivator, "OnActivate")
		RegisterForRemoteEvent(aMenu, "OnEntryRun")

		self.WaitFor(BusyState)
		return true
	Else
		WriteLine(self, "Cannot show a none activate menu perk.")
		return false
	EndIf
EndFunction


Function Clear()
	{Clears the last displayed perk activation menu.}
	If (MenuValue)
		Player.RemovePerk(MenuValue)
		UnregisterForRemoteEvent(ActivatorValue, "OnActivate")
		UnregisterForRemoteEvent(MenuValue, "OnEntryRun")
		ActivatorValue = none
		MenuValue = none
	EndIf

	self.WaitEnd()
EndFunction


; Controller
;---------------------------------------------

State Busy
	Event OnBeginState(string asOldState)
		WriteLine(self,  "Began the busy state.")
	EndEvent

	Event ObjectReference.OnActivate(ObjectReference akSender, ObjectReference akActionRef)
		SelectedValue = 0
		SendCustomEvent("OnSelected")
	EndEvent


	Event Perk.OnEntryRun(Perk akSender, int auiEntryID, ObjectReference akTarget, Actor akOwner)
		WriteLine(self, akSender+" perk has run the entryID "+auiEntryID)

		SelectedValue = auiEntryID
		SendCustomEvent("OnSelected")
	EndEvent


	Event OnEndState(string asNewState)
		Player.RemovePerk(MenuValue)
		UnregisterForRemoteEvent(ActivatorValue, "OnActivate")
		UnregisterForRemoteEvent(MenuValue, "OnEntryRun")
		ActivatorValue = none
		MenuValue = none
	EndEvent


	; bool Function Display(ObjectReference aActivator, Perk aMenu)
	; 	return false
	; EndFunction
EndState


Event ObjectReference.OnActivate(ObjectReference akSender, ObjectReference akActionRef)
	{EMPTY}
EndEvent

Event Perk.OnEntryRun(Perk akSender, int auiEntryID, ObjectReference akTarget, Actor akOwner)
	{EMPTY}
EndEvent


; Properties
;---------------------------------------------

Group Prompt
	Perk Property Menu Hidden
		Perk Function Get()
			return MenuValue
		EndFunction
	EndProperty

	int Property Selected Hidden
		int Function Get()
			return SelectedValue
		EndFunction
	EndProperty
EndGroup
