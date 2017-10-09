ScriptName Games:Shared:UI:ButtonHint extends Games:Shared:UI:Display Default
import Games
import Games:Papyrus:Log
import Games:Papyrus:Script
import Games:Shared

Button[] Buttons
Button selectedLast
CustomEvent OnSelected


bool AutoHide = false
int Invalid = -1 const


Struct Button
	string Text = ""
	{The button text label.}
	int KeyCode = -1
	{The keyboard scancode.}
EndStruct


; Display
;---------------------------------------------

Event OnDisplayData(DisplayData display)
	display.Menu = "HUDMenu"
	display.Asset = "ButtonHint.swf"
	Buttons = new Button[0]
EndEvent


; Methods
;---------------------------------------------

bool Function Show()
	{Begin the shown task.}
	return TaskAwait(self, "Shown")
EndFunction


bool Function Hide()
	{End any running task.}
	return TaskEnd(self)
EndFunction


; Functions
;---------------------------------------------

bool Function Add(Button value)
	{Adds a button to the collection.}
	If (value)
		If (Contains(value) == false)
			If (ContainsKeyCode(value.KeyCode) == false)
				Buttons.Add(value)
				return true
			Else
				WriteLine(self, "The button array already contains a button with keycode '"+value.KeyCode+"'.")
				return false
			EndIf
		Else
			WriteLine(self, "The button array already contains '"+value+"'.")
			return false
		EndIf
	Else
		WriteLine(self, "Cannot add a none value to button array.")
		return false
	EndIf
EndFunction


bool Function Remove(Button value)
	{Removes the first occurrence of a button from the collection.}
	If (value)
		If (Contains(value))
			Buttons.Remove(IndexOf(value))
			return true
		Else
			WriteLine(self, "The button array does not contain '"+value+"'.")
			return false
		EndIf
	Else
		WriteLine(self, "Cannot remove a none value to button array.")
		return false
	EndIf
EndFunction


bool Function Clear()
	{Clears all buttons from the collection.}
	selectedLast = none
	If (Buttons.Length > 0)
		Buttons.Clear()
		return true
	Else
		WriteLine(self, "The button array is already cleared.")
		return false
	EndIf
EndFunction


int Function FindByKeyCode(int value)
	{Determines the index of a button with the given key code.}
	return Buttons.FindStruct("KeyCode", value)
EndFunction


bool Function ContainsKeyCode(int value)
	{Determines whether a button with the given key code is in the collection.}
	return FindByKeyCode(value) > Invalid
EndFunction


bool Function Contains(Button value)
	{Determines whether a button is in the collection.}
	return IndexOf(value) > Invalid
EndFunction


int Function IndexOf(Button value)
	{Determines the index of a specific button in the collection.}
	If (value)
		return Buttons.Find(value)
	Else
		return Invalid
	EndIf
EndFunction


bool Function RegisterForSelectedEvent(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "OnSelected")
		return true
	Else
		WriteLine(self, "Cannot register a none script for phase events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForSelectedEvent(Blackjack:Game script)
	If (script)
		script.UnregisterForCustomEvent(self, "OnSelected")
		return true
	Else
		WriteLine(self, "Cannot register a none script for phase events.")
		return false
	EndIf
EndFunction


Button Function GetSelectedEventArgs(var[] arguments)
	If (arguments)
		return arguments[0] as Button
	Else
		return none
	EndIf
EndFunction


; Tasks
;---------------------------------------------

State Shown
	Event OnBeginState(string asOldState)
		If (Buttons)
			var[] arguments = new var[0]
			int index = 0
			While (index < Buttons.Length)
				arguments.Add(Buttons[index])
				RegisterForKey(Buttons[index].KeyCode)
				index += 1
			EndWhile

			WriteLine(self, "Invoke: "+GetMember("SetButtons"))

			UI.Invoke(Menu, GetMember("SetButtons"), arguments)
			Visible = true
		Else
			WriteLine(self, "The button array is none or empty.")
			TaskEnd(self)
		EndIf
	EndEvent


	Event OnKeyDown(int keyCode)
		selectedLast = Buttons[FindByKeyCode(keyCode)]

		var[] arguments = new var[1]
		arguments[0] = selectedLast
		SendCustomEvent("OnSelected", arguments)

		If (AutoHide)
			Hide()
		EndIf
	EndEvent

	bool Function Show()
		{EMPTY}
		return false
	EndFunction

	bool Function Add(Button value)
		{EMPTY}
		return false
	EndFunction


	bool Function Remove(Button value)
		{EMPTY}
		return false
	EndFunction


	bool Function Clear()
		{EMPTY}
		return false
	EndFunction


	Event OnEndState(string asNewState)
		Visible = false

		int index = 0
		While (index < Buttons.Length)
			UnregisterForKey(Buttons[index].KeyCode)
			index += 1
		EndWhile
	EndEvent
EndState


; Properties
;---------------------------------------------

Group ButtonHint
	Button Property Selected Hidden
		Button Function Get()
			return selectedLast
		EndFunction
	EndProperty

	bool Property SelectOnce Hidden
		bool Function Get()
			return AutoHide
		EndFunction
		Function Set(bool value)
			AutoHide = value
		EndFunction
	EndProperty
EndGroup
