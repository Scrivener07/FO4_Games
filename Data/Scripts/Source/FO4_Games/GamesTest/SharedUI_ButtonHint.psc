ScriptName GamesTest:SharedUI_ButtonHint extends GamesTest:Framework:Lilac
import Games
import Games:Papyrus:Log
import Games:Shared
import Games:Shared:UI:ButtonHint

; Console Command: StartQuest GamesTest


; Lilac
;---------------------------------------------

Function TestSuites()
	describe("When initializing a ButtonHint it", InitializingSuite())
	describe("When populating a ButtonHint it", PopulatingSuite())
;	describe("When showing a ButtonHint it", ShowingSuite())
;	describe("When hiding a ButtonHint it", HidingSuite())
EndFunction


; Suites
;---------------------------------------------

bool Function InitializingSuite()
	It("should be in the empty state", StateEmptyTest())
	It("should contain no buttons", ButtonCountZeroTest())
	It("should not use SelectOnce", SelectOnceDisabledTest())
	return Done
EndFunction


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


bool Function ShowingSuite()
	ButtonHint.Show()
	It("should be in the shown state", StateShownTest())
	return Done
EndFunction


bool Function HidingSuite()
	ButtonHint.Hide()
	It("should be in the empty state", StateShownTest())
	return Done
EndFunction


; Tests
;---------------------------------------------

bool Function StateEmptyTest()
	Expect(ButtonHint.GetState(), to, beEqualTo, "")
	return Done
EndFunction


bool Function StateShownTest()
	Expect(ButtonHint.GetState(), to, beEqualTo, "Shown")
	return Done
EndFunction


bool Function ButtonCountZeroTest()
	Expect(ButtonHint.Count, to, beEqualTo, 0)
	return Done
EndFunction


bool Function ButtonCountOneOrMoreTest()
	Expect(ButtonHint.Count, to, beGreaterThanOrEqualTo, 1)
	return Done
EndFunction


bool Function SelectOnceDisabledTest()
	Expect(ButtonHint.SelectOnce, to, beEqualTo, false)
	return Done
EndFunction


bool Function ButtonAddTest()
	ButtonHint.Clear()

	Button button1 = new Button
	button1.Text = "Button"
	button1.KeyCode = Keyboard.E

	Expect(ButtonHint.Add(button1), to, beEqualTo, true)
	Expect(ButtonHint.Count, to, beEqualTo, 1)
	return Done
EndFunction


bool Function ButtonAddDuplicateTest()
	ButtonHint.Clear()

	Button button1 = new Button
	button1.Text = "Button"
	button1.KeyCode = Keyboard.E

	Expect(ButtonHint.Add(button1), to, beEqualTo, true)
	Expect(ButtonHint.Add(button1), to, beEqualTo, false)
	Expect(ButtonHint.Count, to, beEqualTo, 1)
	return Done
EndFunction


bool Function ButtonAddDuplicateKeyTest()
	ButtonHint.Clear()

	Button button1 = new Button
	button1.Text = "Button"
	button1.KeyCode = Keyboard.E

	Button button2 = new Button
	button2.Text = "Button"
	button2.KeyCode = Keyboard.E

	Expect(ButtonHint.Add(button1), to, beEqualTo, true)
	Expect(ButtonHint.Add(button2), to, beEqualTo, false)
	Expect(ButtonHint.Count, to, beEqualTo, 1)
	return Done
EndFunction


bool Function ButtonAddDuplicateTextTest()
	ButtonHint.Clear()

	Button button1 = new Button
	button1.Text = "Button"
	button1.KeyCode = Keyboard.E

	Button button2 = new Button
	button2.Text = "Button"
	button2.KeyCode = Keyboard.R

	Expect(ButtonHint.Add(button1), to, beEqualTo, true)
	Expect(ButtonHint.Count, to, beEqualTo, 1)

	Expect(ButtonHint.Add(button2), to, beEqualTo, true)
	Expect(ButtonHint.Count, to, beEqualTo, 2)
	return Done
EndFunction


bool Function ButtonRemoveTest()
	ButtonHint.Clear()

	Button button1 = new Button
	button1.Text = "Button"
	button1.KeyCode = Keyboard.E

	Expect(ButtonHint.Add(button1), to, beEqualTo, true)
	Expect(ButtonHint.Count, to, beEqualTo, 1)

	Expect(ButtonHint.Remove(button1), to, beEqualTo, true)
	Expect(ButtonHint.Count, to, beEqualTo, 0)
	return Done
EndFunction


bool Function ButtonClearTest()
	ButtonHint.Clear()
	Expect(ButtonHint.Count, to, beEqualTo, 0)

	Button button1 = new Button
	button1.Text = "Button"
	button1.KeyCode = Keyboard.W

	Button button2 = new Button
	button2.Text = "Button"
	button2.KeyCode = Keyboard.A

	Button button3 = new Button
	button3.Text = "Button"
	button3.KeyCode = Keyboard.D

	Expect(ButtonHint.Add(button1), to, beEqualTo, true)
	Expect(ButtonHint.Count, to, beEqualTo, 1)

	Expect(ButtonHint.Add(button2), to, beEqualTo, true)
	Expect(ButtonHint.Count, to, beEqualTo, 2)

	Expect(ButtonHint.Add(button3), to, beEqualTo, true)
	Expect(ButtonHint.Count, to, beEqualTo, 3)

	Expect(ButtonHint.Clear(), to, beEqualTo, true)
	Expect(ButtonHint.Count, to, beEqualTo, 0)

	return Done
EndFunction


bool Function ShownTest()
	ButtonHint.Show()
	Expect(ButtonHint.Visible, To, BeTruthy)
	Expect(ButtonHint.Visible, To, BeTruthy)
	return Done
EndFunction


bool Function ClearTest()
	ButtonHint.Clear()
	Expect(ButtonHint.Count, to, beEqualTo, 0)
	return Done
EndFunction

bool Function hiddenTest()
	Expect(ButtonHint.Visible, To, BeTruthy)
	ButtonHint.Visible = false
	Expect(ButtonHint.Visible, To, BeFalsy)
	return Done
EndFunction


; Properties
;---------------------------------------------

Group ButtonHint
	UI:ButtonHint Property ButtonHint Auto Const Mandatory
	Shared:Keyboard Property Keyboard Auto Const Mandatory
EndGroup
