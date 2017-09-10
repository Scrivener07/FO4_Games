ScriptName Games:Shared:UI:ButtonHint extends Games:Shared:UI:Display Default
import Games:Papyrus:Log
import Games:Papyrus:Script
import Games:Shared

CustomEvent OnSelected
SelectionData Selected
Button[] Buttons

Struct Button
	string Text = ""
	{The button text label.}
	int KeyCode = -1
	{The keyboard scancode}
EndStruct

Struct SelectionData
	; depreciate
	int KeyCode = -1
EndStruct


; Events
;---------------------------------------------

Event OnInit()
	parent.OnInit()
	Buttons = new Button[0]
	Selected = new SelectionData ; unused
EndEvent


Event OnDisplayLoaded()
	WriteLine(self, Menu+" has loaded "+Asset)
	Show()
EndEvent


; Display
;---------------------------------------------

DisplayData Function GetDisplay()
	DisplayData display = new DisplayData
	display.Menu = "HUDMenu"
	display.Root = "root1"
	display.Asset = "ButtonHint.swf"
	return display
EndFunction


; Methods
;---------------------------------------------

bool Function Show()
	If (IsLoaded)
		return TaskAwait(self, "Shown")
	Else
		WriteLine(self, "Must be loaded before shown.")
		return false
	EndIf
EndFunction


bool Function Accept()
	{End the busy state.}
	return TaskEnd(self)
EndFunction


Function SetButton(Button value)
	string member = GetMember("SetButton")

	var[] argument = new var[1]
	argument[0] = value

	UI.Invoke(Menu, member, argument)
	WriteLine(self, "UI.Invoke::"+member+"("+argument+")")
EndFunction


Function SetButtons(Button[] array)
	string member = GetMember("SetButtons")

	var[] argument = new var[0]
	int index = 0
	While (index < array.Length)
		argument.Add(array[index])
		index += 1
	EndWhile

	UI.Invoke(Menu, member, argument)
	WriteLine(self, "UI.Invoke::"+member+"("+argument+")")
EndFunction


; Tasks
;---------------------------------------------

State Shown
	Event OnBeginState(string asOldState)
		WriteLine(self, "The shown task has begun.")
		RegisterForCustomEvent(self, "OnSelected")

		int index = 0
		While (index < Buttons.Length)
			Button element = Buttons[index]
			RegisterForKey(element.KeyCode) ; register for button keys
			index += 1
		EndWhile
	EndEvent


	Event OnKeyDown(int keyCode)
		SendCustomEvent("OnSelected", none)
	EndEvent

	Event Games:Shared:UI:ButtonHint.OnSelected(Games:Shared:UI:ButtonHint akSender, var[] arguments)
		WriteLine(self, "Selected:"+arguments)
	EndEvent

	Function SetButtons(Button[] array)
		{EMPTY}
	EndFunction


	Event OnEndState(string asNewState)
		UnregisterForCustomEvent(self, "OnSelected")

		int index = 0
		While (index < Buttons.Length)
			Button element = Buttons[index]
			UnregisterForKey(element.KeyCode) ; unregister for button keys
			index += 1
		EndWhile
	EndEvent
EndState


Event Games:Shared:UI:ButtonHint.OnSelected(Games:Shared:UI:ButtonHint akSender, var[] arguments)
	{EMPTY}
EndEvent
