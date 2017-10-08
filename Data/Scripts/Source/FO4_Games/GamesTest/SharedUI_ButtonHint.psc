ScriptName GamesTest:SharedUI_ButtonHint extends GamesTest:Framework:Lilac
import Games:Papyrus:Log
import Games:Shared
import Games:Shared:UI:ButtonHint

Button button1
Button button2

; Events
;---------------------------------------------

Function Derp()
	button1 = new Button
	button1.Text = "One"
	button1.KeyCode = 49

	button2 = new Button
	button2.Text = "Two"
	button2.KeyCode = 50

	ButtonHint.Clear()
	ButtonHint.Add(button1)
	ButtonHint.Add(button2)
	ButtonHint.Show() ; waits for thread
EndFunction


; Event Games:Shared:UI:Display.OnLoaded(UI:Display akSender, var[] arguments)
; EndEvent


Event Games:Shared:UI:ButtonHint.OnSelected(UI:ButtonHint akSender, var[] arguments)
	Button selected = akSender.GetSelectedEventArgs(arguments)
	If (selected == button1)
		WriteLine(self, "Selected the "+selected.Text+" button.")
	ElseIf (selected == button2)
		WriteLine(self, "Selected the "+selected.Text+" button.")
	Else
		WriteLine(self, "The "+selected+" button was unhandled.")
	EndIf

	akSender.Hide()
EndEvent


; Lilac
;---------------------------------------------

Function TestSuites()
	describe("Shared UI ButtonHint", ButtonHintSuite())
EndFunction


Function beforeEach()
	; RegisterForCustomEvent(ButtonHint, "OnLoaded")
	RegisterForCustomEvent(ButtonHint, "OnSelected")
EndFunction


Function afterEach()
	; UnregisterForCustomEvent(ButtonHint, "OnLoaded")
	UnregisterForCustomEvent(ButtonHint, "OnSelected")
EndFunction


; Test Suites
;---------------------------------------------

bool Function ButtonHintSuite()
	It("should be able To load", loadTest())
	It("should be able To be shown", shownTest())
	It("should be able To be hidden", hiddenTest())
	return true
EndFunction


bool Function loadTest()
	; Expect(ButtonHint.IsLoaded, To, BeFalsy)
	; ButtonHint.Load()
	; Expect(ButtonHint.IsLoaded, To, BeTruthy)
	return true
EndFunction


bool Function shownTest()
	ButtonHint.Show()
	Expect(ButtonHint.Visible, To, BeTruthy)
	return true
EndFunction


bool Function hiddenTest()
	Expect(ButtonHint.Visible, To, BeTruthy)
	ButtonHint.Visible = false
	Expect(ButtonHint.Visible, To, BeFalsy)
	return true
EndFunction


; Properties
;---------------------------------------------

Group ButtonHint
	UI:ButtonHint Property ButtonHint Auto Const Mandatory
EndGroup
