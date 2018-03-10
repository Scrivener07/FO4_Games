Scriptname GamesTest:GameTesting extends Quest
{This is a developer only script.}

; Properties
;---------------------------------------------

Event OnQuestInit()
	GamesTest_ContainerReference.AddItem(Game.GetCaps(), 100, true)
	BarstoolGames()
EndEvent


Function BarstoolGames()
	string BarstoolGamesPlugin = "BarstoolGames.esp" const
	If (Game.IsPluginInstalled(BarstoolGamesPlugin))
		Book Games_Magazine01 = Game.GetFormFromFile(0x00001ED2, BarstoolGamesPlugin) as Book
		If (Games_Magazine01)
			GamesTest_ContainerReference.AddItem(Games_Magazine01, 25, true)
		EndIf
		Book Games_BlackjackTutDoc = Game.GetFormFromFile(0x0000990E, BarstoolGamesPlugin) as Book
		If (Games_BlackjackTutDoc)
			GamesTest_ContainerReference.AddItem(Games_BlackjackTutDoc, 25, true)
		EndIf
		MiscObject Games_CardDeck_Misc = Game.GetFormFromFile(0x00002671, BarstoolGamesPlugin) as MiscObject
		If (Games_CardDeck_Misc)
			GamesTest_ContainerReference.AddItem(Games_CardDeck_Misc, 25, true)
		EndIf
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	ObjectReference Property GamesTest_ContainerReference Auto Const Mandatory
EndGroup

Group Scripts
	Quest Property Games_Blackjack_Script Auto Const Mandatory
	Games:Blackjack:Main Property Blackjack Auto Const Mandatory
EndGroup
