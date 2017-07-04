ScriptName Games:Shared:Controllers:Prompt extends Games:Shared:Controller
import Games:Shared:Common

; TODO: auiEntryID, is this an index or ID?
; TODO: Support for multi-input such as the bet increase would use.

Actor Player
Perk Menu
int Choice = -1


; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
EndEvent


; Methods
;---------------------------------------------

int Function Show(Perk aMenu)
	If (aMenu)
		Menu = aMenu
		Player.AddPerk(aMenu)
		RegisterForRemoteEvent(aMenu, "OnEntryRun")
		self.WaitFor(BusyState)
		return Selected
	Else
		WriteLine(self, "Cannot show a none activate menu perk.")
		return -1
	EndIf
EndFunction


Function Hide()
	If (Menu)
		Player.RemovePerk(Menu)
		UnregisterForRemoteEvent(Menu, "OnEntryRun")
		Menu = none
	EndIf

	self.WaitEnd()
EndFunction


; Controller
;---------------------------------------------

State Busy
	Event OnBeginState(string asOldState)
		WriteLine(self,  "Began the busy state.")
	EndEvent

	Event Perk.OnEntryRun(Perk akSender, int auiEntryID, ObjectReference akTarget, Actor akOwner)
		WriteLine(self, akSender+" perk has run the entryID "+auiEntryID)
		Choice = auiEntryID
		self.WaitEnd()
	EndEvent


	Event OnEndState(string asNewState)
		Player.RemovePerk(Menu)
		UnregisterForRemoteEvent(Menu, "OnEntryRun")
		Menu = none
	EndEvent


	int Function Show(Perk aMenu)
		{EMPTY}
		return -1
	EndFunction
EndState


Event Perk.OnEntryRun(Perk akSender, int auiEntryID, ObjectReference akTarget, Actor akOwner)
	{EMPTY}
EndEvent


; Properties
;---------------------------------------------

Group Prompt
	int Property Selected Hidden
		int Function Get()
			return Choice
		EndFunction
	EndProperty
EndGroup
