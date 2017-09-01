ScriptName Games:Blackjack:UI:Choice extends Games:Shared:UI:Menu
import Games:Papyrus:Log

;/
	-Add Button
	-Remove Button
	-Set Buttons
/;


CustomEvent OnSelected


Button[] Buttons_field
Struct Button
	string Text = ""
	{The button text label.}

	int KeyCode = -1
	{The keyboard scancode}

	string PC = "" 		; depreciate
	string PSN = "" 	; depreciate
	string Xenon = "" 	; depreciate
EndStruct


; Menu
;---------------------------------------------

MenuData Function GetMenuData()
	MenuData menu = new MenuData
	menu.Name = "HUDMenu"
	menu.Root = "root1"
	menu.Load = "Choice.swf"
	WriteLine(self, "MenuData:"+menu)
	return menu
EndFunction


Event OnMenuLoaded()
	WriteLine(self, Name+" has loaded "+Load)
	; now we can invoke
EndEvent


; Methods
;---------------------------------------------

Function SetButtons(Button[] buttons)
	string member = GetMember("SetButtons")
	var[] argument = new var[0]

	int index = 0
	While (index < buttons.Length)
		argument.Add(buttons[index])
		index += 1
	EndWhile

	UI.Invoke(Name, member, argument)
	WriteLine(self, "UI.Invoke::"+member+"("+argument+")")
EndFunction
