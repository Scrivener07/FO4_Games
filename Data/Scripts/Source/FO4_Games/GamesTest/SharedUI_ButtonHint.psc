ScriptName GamesTest:SharedUI_ButtonHint extends GamesTest:Framework:Lilac
import Games:Papyrus:Log
import Games:Shared
import Games:Shared:UI:ButtonHint


; Events
;---------------------------------------------

Event Games:Shared:UI:Display.OnLoaded(UI:Display akSender, var[] arguments)
	Button HelloButton = new Button
	HelloButton.Text = "Hello World"
	HelloButton.KeyCode = 69

	ButtonHint.SetButton(HelloButton)
	ButtonHint.Show() ; waits for thread
EndEvent


Event Games:Shared:UI:ButtonHint.OnSelected(UI:ButtonHint akSender, var[] arguments)
	; I need button arguments!
EndEvent


; Lilac
;---------------------------------------------

Function TestSuites()
	describe("Shared UI ButtonHint", ButtonHintSuite())
EndFunction


Function beforeEach()
	RegisterForCustomEvent(ButtonHint, "OnLoaded")
	RegisterForCustomEvent(ButtonHint, "OnSelected")
EndFunction


Function afterEach()
	UnregisterForCustomEvent(ButtonHint, "OnLoaded")
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
	Expect(ButtonHint.IsLoaded, To, BeFalsy)
	ButtonHint.Load()
	Expect(ButtonHint.IsLoaded, To, BeTruthy)
	return true
EndFunction


bool Function shownTest()
	ButtonHint.Show()
	Expect(ButtonHint.Visible, To, BeTruthy)
	return true
EndFunction


bool Function hiddenTest()
	ButtonHint.Hide()
	Expect(ButtonHint.Visible, To, BeFalsy)
	return true
EndFunction


; Properties
;---------------------------------------------

Group ButtonHint
	UI:ButtonHint Property ButtonHint Auto Const Mandatory
EndGroup
