ScriptName GamesTest:Vanilla:Menus extends Quest
import Games:Papyrus:Log

; Events
;---------------------------------------------

Event OnInit()
	RegisterForMenuOpenCloseEvent(BarterMenu)
	RegisterForMenuOpenCloseEvent(BookMenu)
	RegisterForMenuOpenCloseEvent(BSOverlayMenu)
	RegisterForMenuOpenCloseEvent(CompanionMenu)
	RegisterForMenuOpenCloseEvent(Console)
	RegisterForMenuOpenCloseEvent(ConsoleNativeUIMenu)
	RegisterForMenuOpenCloseEvent(ContainerMenu)
	RegisterForMenuOpenCloseEvent(CookingMenu)
	RegisterForMenuOpenCloseEvent(CreditsMenu)
	RegisterForMenuOpenCloseEvent(CursorMenu)
	RegisterForMenuOpenCloseEvent(DebugTextMenu)
	RegisterForMenuOpenCloseEvent(DialogueMenu)
	RegisterForMenuOpenCloseEvent(ExamineMenu)
	RegisterForMenuOpenCloseEvent(FaderMenu)
	RegisterForMenuOpenCloseEvent(FavoritesMenu)
	RegisterForMenuOpenCloseEvent(GenericMenu)
	RegisterForMenuOpenCloseEvent(GiftMenu)
	RegisterForMenuOpenCloseEvent(HUDMenu)
	RegisterForMenuOpenCloseEvent(InventoryMenu)
	RegisterForMenuOpenCloseEvent(LevelUpMenu)
	RegisterForMenuOpenCloseEvent(LoadingMenu)
	RegisterForMenuOpenCloseEvent(LockpickingMenu)
	RegisterForMenuOpenCloseEvent(LooksMenu)
	RegisterForMenuOpenCloseEvent(MagicMenu)
	RegisterForMenuOpenCloseEvent(MainMenu)
	RegisterForMenuOpenCloseEvent(MessageBoxMenu)
	RegisterForMenuOpenCloseEvent(MultiActivateMenu)
	RegisterForMenuOpenCloseEvent(PauseMenu)
	RegisterForMenuOpenCloseEvent(PipboyMenu)
	RegisterForMenuOpenCloseEvent(PromptMenu)
	RegisterForMenuOpenCloseEvent(QuantityMenu)
	RegisterForMenuOpenCloseEvent(ScopeMenu)
	RegisterForMenuOpenCloseEvent(SitWaitMenu)
	RegisterForMenuOpenCloseEvent(SleepWaitMenu)
	RegisterForMenuOpenCloseEvent(SPECIALMenu)
	RegisterForMenuOpenCloseEvent(StatsMenu)
	RegisterForMenuOpenCloseEvent(SWFLoaderMenu)
	RegisterForMenuOpenCloseEvent(TerminalHolotapeMenu)
	RegisterForMenuOpenCloseEvent(TerminalMenu)
	RegisterForMenuOpenCloseEvent(VATSMenu)
	RegisterForMenuOpenCloseEvent(VignetteMenu)
	RegisterForMenuOpenCloseEvent(WorkshopMenu)
	RegisterForMenuOpenCloseEvent(Workshop_CaravanMenu)
	WriteLine(self, "Registered for vanilla menus.")
EndEvent


Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	WriteLine(self, "OnMenuOpenCloseEvent: asMenuName='"+asMenuName+"', abOpening='"+abOpening+"'")
EndEvent


; Properties
;---------------------------------------------

Group Menus
	string Property BarterMenu = "BarterMenu" AutoReadOnly
	string Property BookMenu = "BookMenu" AutoReadOnly
	string Property BSOverlayMenu = "BSOverlayMenu" AutoReadOnly
	string Property CompanionMenu = "CompanionMenu" AutoReadOnly
	string Property Console = "Console" AutoReadOnly
	string Property ConsoleNativeUIMenu = "ConsoleNativeUIMenu" AutoReadOnly
	string Property ContainerMenu = "ContainerMenu" AutoReadOnly
	string Property CookingMenu = "CookingMenu" AutoReadOnly
	string Property CreditsMenu = "CreditsMenu" AutoReadOnly
	string Property CursorMenu = "CursorMenu" AutoReadOnly
	string Property DebugTextMenu = "DebugTextMenu" AutoReadOnly
	string Property DialogueMenu = "DialogueMenu" AutoReadOnly
	string Property ExamineMenu = "ExamineMenu" AutoReadOnly
	string Property FaderMenu = "FaderMenu" AutoReadOnly
	string Property FavoritesMenu = "FavoritesMenu" AutoReadOnly
	string Property GenericMenu = "GenericMenu" AutoReadOnly
	string Property GiftMenu = "GiftMenu" AutoReadOnly
	string Property HUDMenu = "HUDMenu" AutoReadOnly
	string Property InventoryMenu = "InventoryMenu" AutoReadOnly
	string Property LevelUpMenu = "LevelUpMenu" AutoReadOnly
	string Property LoadingMenu = "LoadingMenu" AutoReadOnly
	string Property LockpickingMenu = "LockpickingMenu" AutoReadOnly
	string Property LooksMenu = "LooksMenu" AutoReadOnly
	string Property MagicMenu = "MagicMenu" AutoReadOnly
	string Property MainMenu = "MainMenu" AutoReadOnly
	string Property MessageBoxMenu = "MessageBoxMenu" AutoReadOnly
	string Property MultiActivateMenu = "MultiActivateMenu" AutoReadOnly
	string Property PauseMenu = "PauseMenu" AutoReadOnly
	string Property PipboyMenu = "PipboyMenu" AutoReadOnly
	string Property PromptMenu = "PromptMenu" AutoReadOnly
	string Property QuantityMenu = "QuantityMenu" AutoReadOnly
	string Property ScopeMenu = "ScopeMenu" AutoReadOnly
	string Property SitWaitMenu = "SitWaitMenu" AutoReadOnly
	string Property SleepWaitMenu = "SleepWaitMenu" AutoReadOnly
	string Property SPECIALMenu = "SPECIALMenu" AutoReadOnly
	string Property StatsMenu = "StatsMenu" AutoReadOnly
	string Property SWFLoaderMenu = "SWFLoaderMenu" AutoReadOnly
	string Property TerminalHolotapeMenu = "TerminalHolotapeMenu" AutoReadOnly
	string Property TerminalMenu = "TerminalMenu" AutoReadOnly
	string Property VATSMenu = "VATSMenu" AutoReadOnly
	string Property VignetteMenu = "VignetteMenu" AutoReadOnly
	string Property WorkshopMenu = "WorkshopMenu" AutoReadOnly
	string Property Workshop_CaravanMenu = "Workshop_CaravanMenu" AutoReadOnly
EndGroup
