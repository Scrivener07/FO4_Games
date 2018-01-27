ScriptName GamesTest:SharedUIButtonHintTest extends GamesTest:Lilac
import Games
import Games:Shared
import Games:Shared:Log
import Games:Shared:UI:ButtonHint

; Console Command: StartQuest GamesTest

; Lilac
;---------------------------------------------

Function TestSuites()
	describe("When initializing a ButtonHint it", InitializingSuite())
	describe("When populating a ButtonHint it", PopulatingSuite())
	describe("When showing a ButtonHint it", ShowingSuite())
EndFunction


Function BeforeEach()
	GotoState("")
	ButtonHint.Hide()
	ButtonHint.Clear()
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
	Expect(ButtonHint.GetState(), To, BeEqualTo, "")
	return Done
EndFunction


bool Function ButtonCountZeroTest()
	Expect(ButtonHint.Count, To, BeEqualTo, 0)
	return Done
EndFunction


bool Function ButtonCountOneOrMoreTest()
	Expect(ButtonHint.Count, To, BeGreaterThanOrEqualTo, 1)
	return Done
EndFunction


bool Function SelectOnceDisabledTest()
	Expect(ButtonHint.SelectOnce, To, BeEqualTo, false)
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

	Expect(ButtonHint.Add(button1), To, BeEqualTo, true)
	Expect(ButtonHint.Count, To, BeEqualTo, 1)
	return Done
EndFunction


bool Function ButtonAddDuplicateTest()
	Button button1 = new Button
	button1.Text = "Press"
	button1.KeyCode = Keyboard.E

	Expect(ButtonHint.Add(button1), To, BeEqualTo, true)
	Expect(ButtonHint.Add(button1), To, BeEqualTo, false)
	Expect(ButtonHint.Count, To, BeEqualTo, 1)
	return Done
EndFunction


bool Function ButtonAddDuplicateKeyTest()
	Button button1 = new Button
	button1.Text = "Press"
	button1.KeyCode = Keyboard.E

	Button button2 = new Button
	button2.Text = "Press"
	button2.KeyCode = Keyboard.E

	Expect(ButtonHint.Add(button1), To, BeEqualTo, true)
	Expect(ButtonHint.Add(button2), To, BeEqualTo, false)
	Expect(ButtonHint.Count, To, BeEqualTo, 1)
	return Done
EndFunction


bool Function ButtonAddDuplicateTextTest()
	Button button1 = new Button
	button1.Text = "Press"
	button1.KeyCode = Keyboard.E

	Button button2 = new Button
	button2.Text = "Button"
	button2.KeyCode = Keyboard.R

	Expect(ButtonHint.Add(button1), To, BeEqualTo, true)
	Expect(ButtonHint.Count, To, BeEqualTo, 1)

	Expect(ButtonHint.Add(button2), To, BeEqualTo, true)
	Expect(ButtonHint.Count, To, BeEqualTo, 2)
	return Done
EndFunction


bool Function ButtonRemoveTest()
	Button button1 = new Button
	button1.Text = "Press"
	button1.KeyCode = Keyboard.E

	Expect(ButtonHint.Add(button1), To, BeEqualTo, true)
	Expect(ButtonHint.Count, To, BeEqualTo, 1)

	Expect(ButtonHint.Remove(button1), To, BeEqualTo, true)
	Expect(ButtonHint.Count, To, BeEqualTo, 0)
	return Done
EndFunction


bool Function ButtonClearTest()
	Expect(ButtonHint.Count, To, BeEqualTo, 0)

	Button button1 = new Button
	button1.Text = "Press"
	button1.KeyCode = Keyboard.W

	Button button2 = new Button
	button2.Text = "Press"
	button2.KeyCode = Keyboard.A

	Button button3 = new Button
	button3.Text = "Press"
	button3.KeyCode = Keyboard.D

	Expect(ButtonHint.Add(button1), To, BeEqualTo, true)
	Expect(ButtonHint.Count, To, BeEqualTo, 1)

	Expect(ButtonHint.Add(button2), To, BeEqualTo, true)
	Expect(ButtonHint.Count, To, BeEqualTo, 2)

	Expect(ButtonHint.Add(button3), To, BeEqualTo, true)
	Expect(ButtonHint.Count, To, BeEqualTo, 3)

	Expect(ButtonHint.Clear(), To, BeEqualTo, true)
	Expect(ButtonHint.Count, To, BeEqualTo, 0)

	return Done
EndFunction


; Showing / Hiding
;---------------------------------------------

bool Function ShowingSuite()
;	It("should not show without any buttons", ShownNoButtonTest())
	It("should show with at least one button", ShownButtonTest())
	return Done
EndFunction


bool Function ShownNoButtonTest()
	ButtonHint.RegisterForShownEvent(self)
	ButtonHint.Show()
	ButtonHint.UnregisterForShownEvent(self)
	return Done
EndFunction


bool Function ShownButtonTest()
	GotoState("ShownButtonTest")

	Button button1 = new Button
	button1.Text = "Button"
	button1.KeyCode = Keyboard.E
	ButtonHint.Add(button1)

	ButtonHint.RegisterForSelectedEvent(self)
	ButtonHint.RegisterForShownEvent(self)
	ButtonHint.Show()
	ButtonHint.UnregisterForShownEvent(self)
	ButtonHint.UnregisterForSelectedEvent(self)

	return Done
EndFunction


State ShownButtonTest
	Event Games:Shared:UI:ButtonHint.OnShown(UI:ButtonHint akSender, var[] arguments)
		Expect(akSender.GetState(), To, BeEqualTo, "Shown")
		; Expect(akSender.Visible, To, BeTruthy)
		; akSender.Hide()
	EndEvent


	Event Games:Shared:UI:ButtonHint.OnSelected(UI:ButtonHint akSender, var[] arguments)
		Expect(akSender.GetState(), To, BeEqualTo, "Shown")
		; Expect(akSender.Visible, To, BeTruthy)
		akSender.Hide()
	EndEvent
EndState





; @ShownButtonTest
Event Games:Shared:UI:ButtonHint.OnSelected(UI:ButtonHint akSender, var[] arguments)
	{EMPTY}
	; Expect(akSender.GetState(), To, BeEqualTo, "Shown")
	; Expect(akSender.Visible, To, BeTruthy)
	; akSender.Hide()
EndEvent


Event Games:Shared:UI:ButtonHint.OnShown(UI:ButtonHint akSender, var[] arguments)
	{EMPTY}
EndEvent


; Properties
;---------------------------------------------

Group ButtonHint
	UI:ButtonHint Property ButtonHint Auto Const Mandatory
	Shared:Keyboard Property Keyboard Auto Const Mandatory
EndGroup
