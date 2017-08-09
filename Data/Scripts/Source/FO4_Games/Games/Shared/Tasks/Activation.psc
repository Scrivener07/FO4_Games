ScriptName Games:Shared:Tasks:Activation extends Games:Shared:Task
import Games:Shared
import Games:Papyrus:Log

;/ TODO:
- The argument auiEntryID, is this an index or ID?
/;

;/ Perk Choices (4)
|--------------------------------------------------------|
|  Entry  | Control | Priority | Position | Entry Point  |
|--------------------------------------------------------|
|    1    |    A    |   100    | Bottom   |   Set Text   |
|    2    |    B    |   90     | Right    | Add Activate |
|    3    |    X    |   80     | Left     | Add Activate |
|    4    |    Y    |   70     | Top      | Add Activate |
|--------------------------------------------------------|
|   [4]   |   [Y]   |                                    |
| [3] [2] | [X] [B] |                                    |
|   [1]   |   [A]   |                                    |
|---------------------------------------------------------
/;

;/ Perk Choices (2)
|--------------------------------------------------------|
|  Entry  | Control | Priority | Position | Entry Point  |
|--------------------------------------------------------|
|    1    |    A    |   100    | Left     |   Set Text   |
|    2    |    B    |   90     | Right    | Add Activate |
|--------------------------------------------------------|
| [1] [2] | [A] [B] |                                    |
|---------------------------------------------------------
/;

;/ Menus
|--------- Wagering ---------|
|----------------------------|
|           [???]            |
|   [Increase] [Decrease]    |
|          [Accept]          |
|----------------------------|


|--------- Playing ----------|
|----------------------------|
|           [More]           |
|        [Hit] [Stay]        |
|         [Continue]         |
|----------------------------|
|----------------------------|
|           [More]           |
|      [Split]  [Double]     |
|         [Continue]         |
|----------------------------|

-All selections in playing will trigger an "accept".
/;


Actor Player

CustomEvent OnSelected
ActivationData Data

Struct ActivationData
	ObjectReference Reference
	Perk Menu
	int Selected = -1
EndStruct


; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
	Data = new ActivationData
EndEvent


; Methods
;---------------------------------------------

bool Function Show(ObjectReference aReference, Perk aMenu)
	{Shows the activation menu for the given reference.}
	If (IsBusy)
		WriteLine(self, "Activation menu is already shown.")
		return Incomplete
	Else
		If (aReference)
			If (aMenu)
				Data = new ActivationData
				Data.Menu = aMenu
				Data.Reference = aReference
				return self.Await()
			Else
				WriteLine(self, "Cannot show a none activate menu perk.")
				return Incomplete
			EndIf
		Else
			WriteLine(self, "Cannot show activate menu on a none reference.")
			return Incomplete
		EndIf
	EndIf
EndFunction


Function Accept()
	{Clears the activation menu on the given reference.}
	self.AwaitEnd()
EndFunction


; Task
;---------------------------------------------

State Busy
	Event OnBeginState(string asOldState)
		RegisterForRemoteEvent(Reference, "OnActivate")
		RegisterForRemoteEvent(Menu, "OnEntryRun")
		Player.AddPerk(Menu)
	EndEvent


	Event ObjectReference.OnActivate(ObjectReference akSender, ObjectReference akActionRef)
		Data.Selected = 0
		SendCustomEvent("OnSelected")
	EndEvent


	Event Perk.OnEntryRun(Perk akSender, int auiEntryID, ObjectReference akTarget, Actor akOwner)
		Data.Selected = auiEntryID
		SendCustomEvent("OnSelected")
	EndEvent


	Event Games:Shared:Tasks:Activation.OnSelected(Tasks:Activation akSender, var[] arguments)
		WriteLine(self, "Selected "+akSender.Selected)
	EndEvent


	Event OnEndState(string asNewState)
		UnregisterForRemoteEvent(Reference, "OnActivate")
		UnregisterForRemoteEvent(Menu, "OnEntryRun")
		Player.RemovePerk(Menu)
	EndEvent
EndState


Event ObjectReference.OnActivate(ObjectReference akSender, ObjectReference akActionRef)
	{EMPTY}
EndEvent

Event Perk.OnEntryRun(Perk akSender, int auiEntryID, ObjectReference akTarget, Actor akOwner)
	{EMPTY}
EndEvent

Event Games:Shared:Tasks:Activation.OnSelected(Tasks:Activation akSender, var[] arguments)
	{EMPTY}
EndEvent


; Properties
;---------------------------------------------

Group Activation
	ObjectReference Property Reference Hidden
		ObjectReference Function Get()
			return Data.Reference
		EndFunction
	EndProperty

	Perk Property Menu Hidden
		Perk Function Get()
			return Data.Menu
		EndFunction
	EndProperty

	int Property Selected Hidden
		int Function Get()
			return Data.Selected
		EndFunction
	EndProperty
EndGroup
