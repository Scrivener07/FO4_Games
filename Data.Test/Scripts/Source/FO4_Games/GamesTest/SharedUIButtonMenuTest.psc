ScriptName GamesTest:SharedUIButtonMenuTest extends GamesTest:Lilac
import Games
import Games:Shared
import Games:Shared:Log
import Games:Shared:UI:ButtonMenu

; Console Command: StartQuest GamesTest_SharedUIButtonMenu

; Lilac
;---------------------------------------------

Function TestSuites()
	describe("When initializing a ButtonMenu it", InitializingSuite())
	describe("When populating a ButtonMenu it", PopulatingSuite())
	describe("When showing a ButtonMenu it", ShowingSuite())
EndFunction


Function BeforeEach()
	GotoState("")
	ButtonMenu.Hide()
	ButtonMenu.Clear()
EndFunction


; Initializing
;---------------------------------------------

bool Function InitializingSuite()
	It("should be in the empty state", StateEmptyTest())
	It("should contain no buttons", ButtonCountZeroTest())
	It("should not use SelectOnce", SelectOnceDisabledTest())
	return Done
EndFunction


bool Function StateEmptyTest()
	Expect(ButtonMenu.GetState(), To, BeEqualTo, "")
	return Done
EndFunction


bool Function ButtonCountZeroTest()
	Expect(ButtonMenu.Count, To, BeEqualTo, 0)
	return Done
EndFunction


bool Function ButtonCountOneOrMoreTest()
	Expect(ButtonMenu.Count, To, BeGreaterThanOrEqualTo, 1)
	return Done
EndFunction


bool Function SelectOnceDisabledTest()
	Expect(ButtonMenu.SelectOnce, To, BeEqualTo, false)
	return Done
EndFunction


; Populating
;---------------------------------------------

bool Function PopulatingSuite()
	It("should be in the empty state", StateEmptyTest())
	It("should contain no buttons", ButtonCountZeroTest())
	It("should be able to add a button", ButtonAddTest())
	It("should not add duplicate buttons", ButtonAddDuplicateTest())
	It("should not add duplicate button keycodes", ButtonAddDuplicateKeyTest())
	It("should be able to add buttons with the same text", ButtonAddDuplicateTextTest())
	It("should be able to remove a button", ButtonRemoveTest())
	It("should be able to clear all buttons", ButtonClearTest())
	return Done
EndFunction


bool Function ButtonAddTest()
	Button button1 = new Button
	button1.Text = "Press"
	button1.KeyCode = Keyboard.E

	Expect(ButtonMenu.Add(button1), To, BeEqualTo, true)
	Expect(ButtonMenu.Count, To, BeEqualTo, 1)
	return Done
EndFunction


bool Function ButtonAddDuplicateTest()
	Button button1 = new Button
	button1.Text = "Press"
	button1.KeyCode = Keyboard.E

	Expect(ButtonMenu.Add(button1), To, BeEqualTo, true)
	Expect(ButtonMenu.Add(button1), To, BeEqualTo, false)
	Expect(ButtonMenu.Count, To, BeEqualTo, 1)
	return Done
EndFunction


bool Function ButtonAddDuplicateKeyTest()
	Button button1 = new Button
	button1.Text = "Press"
	button1.KeyCode = Keyboard.E

	Button button2 = new Button
	button2.Text = "Press"
	button2.KeyCode = Keyboard.E

	Expect(ButtonMenu.Add(button1), To, BeEqualTo, true)
	Expect(ButtonMenu.Add(button2), To, BeEqualTo, false)
	Expect(ButtonMenu.Count, To, BeEqualTo, 1)
	return Done
EndFunction


bool Function ButtonAddDuplicateTextTest()
	Button button1 = new Button
	button1.Text = "Press"
	button1.KeyCode = Keyboard.E

	Button button2 = new Button
	button2.Text = "Button"
	button2.KeyCode = Keyboard.R

	Expect(ButtonMenu.Add(button1), To, BeEqualTo, true)
	Expect(ButtonMenu.Count, To, BeEqualTo, 1)

	Expect(ButtonMenu.Add(button2), To, BeEqualTo, true)
	Expect(ButtonMenu.Count, To, BeEqualTo, 2)
	return Done
EndFunction


bool Function ButtonRemoveTest()
	Button button1 = new Button
	button1.Text = "Press"
	button1.KeyCode = Keyboard.E

	Expect(ButtonMenu.Add(button1), To, BeEqualTo, true)
	Expect(ButtonMenu.Count, To, BeEqualTo, 1)

	Expect(ButtonMenu.Remove(button1), To, BeEqualTo, true)
	Expect(ButtonMenu.Count, To, BeEqualTo, 0)
	return Done
EndFunction


bool Function ButtonClearTest()
	Expect(ButtonMenu.Count, To, BeEqualTo, 0)

	Button button1 = new Button
	button1.Text = "Press"
	button1.KeyCode = Keyboard.W

	Button button2 = new Button
	button2.Text = "Press"
	button2.KeyCode = Keyboard.A

	Button button3 = new Button
	button3.Text = "Press"
	button3.KeyCode = Keyboard.D

	Expect(ButtonMenu.Add(button1), To, BeEqualTo, true)
	Expect(ButtonMenu.Count, To, BeEqualTo, 1)

	Expect(ButtonMenu.Add(button2), To, BeEqualTo, true)
	Expect(ButtonMenu.Count, To, BeEqualTo, 2)

	Expect(ButtonMenu.Add(button3), To, BeEqualTo, true)
	Expect(ButtonMenu.Count, To, BeEqualTo, 3)

	Expect(ButtonMenu.Clear(), To, BeEqualTo, true)
	Expect(ButtonMenu.Count, To, BeEqualTo, 0)

	return Done
EndFunction


; Showing / Hiding
;---------------------------------------------

bool Function ShowingSuite()
	It("should not show without any buttons", ShownNoButtonTest())
	It("should show with at least one button", ShownButtonTest())
	return Done
EndFunction


bool Function ShownNoButtonTest()
	GotoState("ShownNoButtonTest")
	ButtonMenu.RegisterForShownEvent(self)
	ButtonMenu.Show()
	ButtonMenu.UnregisterForShownEvent(self)
	return Done
EndFunction
State ShownNoButtonTest
	Event Games:Shared:UI:ButtonMenu.OnShown(UI:ButtonMenu akSender, var[] arguments)
		WriteLine(self, "ShownNoButtonTest::Games:Shared:UI:ButtonMenu.OnShown:"+akSender.GetShownEventArgs(arguments))
		akSender.Hide()
	EndEvent
EndState


bool Function ShownButtonTest()
	GotoState("ShownButtonTest")
	Button button1 = new Button
	button1.Text = "Button"
	button1.KeyCode = Keyboard.E
	ButtonMenu.Add(button1)

	ButtonMenu.RegisterForShownEvent(self)
	ButtonMenu.Show()
	ButtonMenu.UnregisterForShownEvent(self)
	return Done
EndFunction
State ShownButtonTest
	Event Games:Shared:UI:ButtonMenu.OnShown(UI:ButtonMenu akSender, var[] arguments)
		WriteLine(self, "ShownButtonTest::Games:Shared:UI:ButtonMenu.OnShown:"+akSender.GetShownEventArgs(arguments))
		akSender.Hide()
	EndEvent
EndState


; Empty
;---------------------------------------------

Event Games:Shared:UI:ButtonMenu.OnShown(UI:ButtonMenu akSender, var[] arguments)
	{EMPTY}
EndEvent


; Properties
;---------------------------------------------

Group ButtonMenu
	UI:ButtonMenu Property ButtonMenu Auto Const Mandatory
	Shared:Keyboard Property Keyboard Auto Const Mandatory
EndGroup
