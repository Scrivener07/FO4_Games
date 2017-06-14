ScriptName Gambling:BlackJack:Components:Players extends Gambling:BlackJack:Component
import Gambling
import Gambling:BlackJack
import Gambling:BlackJack:Players
import Gambling:Shared:Common

Player[] Players


; Events
;---------------------------------------------

Event OnInit()
	Players = new Player[0]
EndEvent


; Component
;---------------------------------------------

State Starting
	Event OnBeginState(string asOldState)
		Add(Human)
		Human.StartAndWait()

		Add(BotWhale)
		BotWhale.StartAndWait()

		Add(BotSwatter)
		BotSwatter.StartAndWait()

		Add(BotC)
		BotC.StartAndWait()

		Add(BotD)
		BotD.StartAndWait()

		Add(Dealer)
		Dealer.StartAndWait()

		ReleaseThread()
	EndEvent
EndState


State Wagering
	Event OnBeginState(string asOldState)
		If (Players)
			int index = 0
			While (index < Count)
				Player gambler = Players[index]
				gambler.WagerAndWait()
				WriteLine(self, "Has chosen to wager "+gambler.Wager)
				index += 1
			EndWhile
		Else
			WriteLine(self, "There are no players to wager.")
		EndIf

		ReleaseThread()
	EndEvent
EndState


State Dealing
	Event OnBeginState(string asOldState)
		If (Players)
			int index = 0
			While (index < Count)
				Players[index].DealAndWait()
				index += 1
			EndWhile
		Else
			WriteLine(self, "There are no players to deal.")
		EndIf

		ReleaseThread()
	EndEvent
EndState


State Playing
	Event OnBeginState(string asOldState)
		If (Players)
			int index = 0
			While (index < Count)
				Players[index].PlayAndWait()
				index += 1
			EndWhile
		Else
			WriteLine(self, "There are no players to play.")
		EndIf

		ReleaseThread()
	EndEvent
EndState


State Exiting
	Event OnBeginState(string asOldState)
		Clear()
		ReleaseThread()
	EndEvent
EndState


State Scoring
	Event OnBeginState(string asOldState)
		If (Players)
			int index = 0
			While (index < Count)
				Player gambler = Players[index]
				gambler.ScoreAndWait()

				; after the player has taken all of their turns
				If (gambler is Human)
					int score = gambler.Score

					If (BlackJack.Rules.IsWin(score))
						WriteLine(self, "Player final score of "+score+" is a winner.")
						BlackJack.GUI.ShowWinner(score)

					ElseIf (BlackJack.Rules.IsBust(score))
						WriteLine(self, "Player final score of "+score+" is a loser.")
						BlackJack.GUI.ShowLoser(score)
					EndIf
				EndIf

				index += 1
			EndWhile
		Else
			WriteLine(self, "There are no players to score.")
		EndIf

		ReleaseThread()
	EndEvent
EndState


; Functions
;---------------------------------------------

int Function IndexOf(Player value)
	{Determines the index of a specific player in the collection.}
	If (value)
		return Players.Find(value)
	Else
		return Invalid
	EndIf
EndFunction


bool Function Contains(Player value)
	{Determines whether a player is in the collection.}
	return IndexOf(value) > Invalid
EndFunction


bool Function Remove(Player value)
	{Removes a player from the collection.}
	int index = IndexOf(value)

	If (index > Invalid)
		Players.Remove(index)
		return true
	Else
		WriteLine(self, "Could not find the '"+value+"' player for abort.")
		return false
	EndIf
EndFunction


bool Function Add(Player value)
	{Adds a player to the collection.}
	If (value)
		If (Contains(value) == false)
			Players.Add(value)
			return true
		Else
			WriteLine(self, "The players already contain '"+value+"'.")
			return false
		EndIf
	Else
		WriteLine(self, "Cannot add a none value.")
		return false
	EndIf
EndFunction


Function Clear()
	{Removes all players from the collection.}
	If (Players)
		Players.Clear()
	Else
		WriteLine(self, "Cannot clear empty or none players.")
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Object
	BlackJack:Game Property BlackJack Auto Const Mandatory
EndGroup

Group Players
	Players:BotWhale Property BotWhale Auto Const Mandatory
	Players:BotSwatter Property BotSwatter Auto Const Mandatory
	Players:BotC Property BotC Auto Const Mandatory
	Players:BotD Property BotD Auto Const Mandatory
	Players:Human Property Human Auto Const Mandatory
	Players:Dealer Property Dealer Auto Const Mandatory
EndGroup

Group ReadOnly
	int Property Count Hidden
		int Function Get()
			return Players.Length
		EndFunction
	EndProperty
EndGroup
