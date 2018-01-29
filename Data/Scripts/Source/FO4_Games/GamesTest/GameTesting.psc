Scriptname GamesTest:GameTesting extends Quest
{This is a developer only script.}


Event OnQuestInit()
    GamesTest_ContainerReference.AddItem(Game.GetCaps(), 100, true)
EndEvent

Group Properties
	ObjectReference Property GamesTest_ContainerReference Auto Const Mandatory
EndGroup

