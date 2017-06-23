ScriptName Gambling:Blackjack:Components:Wager extends Gambling:Blackjack:Component
import Gambling
import Gambling:Blackjack
import Gambling:Shared:Common


int Worth = 0

bool busy = false
string InventoryMenu = "ContainerMenu" const


; Component
;---------------------------------------------

State Wagering
	Event OnBeginState(string asOldState)
		busy = true
		Worth = 0

		RegisterForMenuOpenCloseEvent(InventoryMenu)
		Gambling_Blackjack_Actor.OpenInventory(true)

		Wait()

		Worth = Gambling_Blackjack_Actor.GetInventoryValue()
		UnregisterForMenuOpenCloseEvent(InventoryMenu)

		ReleaseThread()
	EndEvent



	Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
		If (abOpening)
			WriteNotification(asMenuName, "Opened..")
		Else
			busy = false
			WriteNotification(asMenuName, "Closed..")
		EndIf
	EndEvent
EndState


; Functions
;---------------------------------------------

Function Wait()
	While (busy)
		Utility.Wait(0.1)
	EndWhile
EndFunction


; Properties
;---------------------------------------------

Group Wager
	Actor Property Gambling_Blackjack_Actor Auto Const Mandatory

	int Property Bet Hidden
		int Function Get()
			return Worth
		EndFunction
	EndProperty
EndGroup
