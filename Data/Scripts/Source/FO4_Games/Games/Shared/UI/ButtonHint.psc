ScriptName Games:Shared:UI:ButtonHint extends Games:Shared:UI:Menu Default
import Games
import Games:Shared
import Games:Shared:Log
import Games:Shared:Papyrus

Button[] Buttons
Button selectedLast
CustomEvent OnShown
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

DisplayData Function NewDisplay()
	DisplayData display = new DisplayData
	display.Menu = "ButtonHintMenu"
	display.Asset = "ButtonHint"
	display.Root = "root1.Menu"
	Buttons = new Button[0]
	return display
EndFunction


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


;---------------------------------------------


bool Function Add(Button value)
	{Adds a button to the collection.}
	If (value)
		If (Contains(value) == false)
			If (ContainsKeyCode(value.KeyCode) == false)
				Buttons.Add(value)
				return true
			Else
				WriteUnexpected(self, "Add", "The button array already contains a button with keycode '"+value.KeyCode+"'.")
				return false
			EndIf
		Else
			WriteUnexpected(self, "Add", "The button array already contains '"+value+"'.")
			return false
		EndIf
	Else
		WriteUnexpectedValue(self, "Add", "value", "Cannot add a none value to button array.")
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
			WriteUnexpected(self, "Remove", "The button array does not contain '"+value+"'.")
			return false
		EndIf
	Else
		WriteUnexpectedValue(self, "Remove", "value", "Cannot remove a none value from button array.")
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
		WriteUnexpected(self, "Clear", "The button array is already cleared.")
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


;---------------------------------------------


bool Function RegisterForSelectedEvent(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "OnSelected")
		return true
	Else
		WriteUnexpectedValue(self, "RegisterForSelectedEvent", "script", "Cannot register a none script for selection events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForSelectedEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "OnSelected")
		return true
	Else
		WriteUnexpectedValue(self, "UnregisterForSelectedEvent", "script", "Cannot register a none script for selection events.")
		return false
	EndIf
EndFunction


Button Function GetSelectedEventArgs(var[] arguments)
	If (arguments)
		return arguments[0] as Button
	Else
		WriteUnexpectedValue(self, "GetSelectedEventArgs", "arguments", "The selection event arguments are empty or none.")
		return none
	EndIf
EndFunction


;---------------------------------------------


Struct ShownEventArgs
	bool Showing = false
EndStruct


bool Function RegisterForShownEvent(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "OnShown")
		return true
	Else
		WriteUnexpectedValue(self, "RegisterForShownEvent", "script", "Cannot register a none script for shown events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForShownEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "OnShown")
		return true
	Else
		WriteUnexpectedValue(self, "UnregisterForShownEvent", "script", "Cannot register a none script for shown events.")
		return false
	EndIf
EndFunction


ShownEventArgs Function GetShownEventArgs(var[] arguments)
	If (arguments)
		return arguments[0] as ShownEventArgs
	Else
		WriteUnexpectedValue(self, "GetShownEventArgs", "arguments", "The shown event arguments are empty or none.")
		return none
	EndIf
EndFunction


; Tasks
;---------------------------------------------

State Shown
	Event OnBeginState(string asOldState)
		If (Open())
			If (Buttons)
				var[] arguments = new var[0]
				int index = 0
				While (index < Buttons.Length)
					arguments.Add(Buttons[index])
					RegisterForKey(Buttons[index].KeyCode)
					index += 1
				EndWhile

				string member = GetMember("SetButtons")
				UI.Invoke(Menu, member, arguments)

				ShownEventArgs e = new ShownEventArgs
				e.Showing = true
				var[] shownArguments = new var[1]
				shownArguments[0] = e
				SendCustomEvent("OnShown", shownArguments)

				WriteLine(self, "Showing button press hints. Invoke: "+Menu+"."+member+"("+arguments+")")
			Else
				WriteUnexpected(self, "Shown.OnBeginState", "The button array is none or empty.")
				TaskEnd(self)
			EndIf
		Else
			WriteUnexpected(self, "Shown.OnBeginState", "Could not open menu for '"+GetState()+"' state.")
			TaskEnd(self)
		EndIf
	EndEvent


	Event OnKeyDown(int keyCode)
		selectedLast = Buttons[FindByKeyCode(keyCode)]

		var[] arguments = new var[1]
		arguments[0] = selectedLast
		SendCustomEvent("OnSelected", arguments)

		If (AutoHide)
			WriteLine(self, "Automatically hiding for first selection.")
			TaskEnd(self)
		EndIf
	EndEvent


	bool Function Show()
		{EMPTY}
		WriteNotImplemented(self, "Show", "Not implemented in the '"+GetState()+"' state.")
		return false
	EndFunction


	bool Function Add(Button value)
		{EMPTY}
		WriteNotImplemented(self, "Add", "Not implemented in the '"+GetState()+"' state.")
		return false
	EndFunction


	bool Function Remove(Button value)
		{EMPTY}
		WriteNotImplemented(self, "Remove", "Not implemented in the '"+GetState()+"' state.")
		return false
	EndFunction


	bool Function Clear()
		{EMPTY}
		WriteNotImplemented(self, "Clear", "Not implemented in the '"+GetState()+"' state.")
		return false
	EndFunction


	Event OnEndState(string asNewState)
		WriteLine(self, "Ending the '"+GetState()+"' state.")
		Close()

		int index = 0
		While (index < Buttons.Length)
			UnregisterForKey(Buttons[index].KeyCode)
			index += 1
		EndWhile

		ShownEventArgs e = new ShownEventArgs
		e.Showing = false
		var[] arguments = new var[1]
		arguments[0] = e
		SendCustomEvent("OnShown", arguments)
	EndEvent
EndState


; Properties
;---------------------------------------------

Group ButtonHint
	int Property Count Hidden
		int Function Get()
			return Buttons.Length
		EndFunction
	EndProperty

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
