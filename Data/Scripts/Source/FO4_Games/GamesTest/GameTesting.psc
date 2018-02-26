Scriptname GamesTest:GameTesting extends Quest
{This is a developer only script.}

Event OnQuestInit()
	Debug.StartStackRootProfiling("Games:Blackjack:Main", Games_Blackjack_Script)
	Debug.StartScriptProfiling("Games:Shared:Papyrus")
	GamesTest_ContainerReference.AddItem(Game.GetCaps(), 100, true)
EndEvent

Group Properties
	ObjectReference Property GamesTest_ContainerReference Auto Const Mandatory
EndGroup


Group Scripts
	Quest Property Games_Blackjack_Script Auto Const Mandatory
	Games:Blackjack:Main Property Blackjack Auto Const Mandatory
EndGroup
