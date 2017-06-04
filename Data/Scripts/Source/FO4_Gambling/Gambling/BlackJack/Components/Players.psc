ScriptName Gambling:BlackJack:Components:Players extends Gambling:BlackJack:GameComponent
import Gambling
import Gambling:BlackJack
import Gambling:BlackJack:Players
import Gambling:Common
import Gambling:Shared


Player[] Players
int Invalid = -1 const


; Events
;---------------------------------------------

Event OnInitialize()
	Players = new Player[0]
EndEvent


Event OnGamePhase(PhaseEventArgs e)
	If (e.Name == WageringPhase && e.Change == Ended)
		If (Human.Abort)
			If (Remove(Human))
				WriteLine(self, "The human has aborted the game.")
			Else
				WriteLine(self, "The human could not abort the game.")
			EndIf
		EndIf
	EndIf
EndEvent


; Methods
;---------------------------------------------

bool Function Allocate()
	Add(Human)
	Add(GamblerA)
	Add(GamblerB)
	Add(GamblerC)
	Add(GamblerD)
	Add(Dealer)
	return true
EndFunction


Function Startup()
	If (Players)
		int index = 0
		While (index < Count)
			Players[index].Startup()
			index += 1
		EndWhile
	Else
		WriteLine(self, "There are no seats to startup.")
	EndIf
EndFunction


Function Wager()
	If (Players)
		int index = 0
		While (index < Count)
			Players[index].Wager()
			index += 1
		EndWhile
	Else
		WriteLine(self, "There are no seats to wager.")
	EndIf
EndFunction


Function Deal(Shared:Deck deck)
	If (Players)
		int index = 0
		While (index < Count)
			Players[index].Deal(deck.Draw())
			Players[index].Deal(deck.Draw())
			index += 1
		EndWhile
	Else
		WriteLine(self, "There are no seats to deal.")
	EndIf
EndFunction


Function Play()
	If (Players)
		int index = 0
		While (index < Count)
			Players[index].Play()
			index += 1
		EndWhile
	Else
		WriteLine(self, "There are no seats to play.")
	EndIf
EndFunction


Function Deallocate()
	If (Players)
		int index = 0
		While (index < Count)
			Players[index].Shutdown()
			index += 1
		EndWhile

		Clear()
	Else
		WriteLine(self, "There are no seats to deallocate.")
	EndIf
EndFunction


; Functions
;---------------------------------------------

int Function IndexOf(Player aPlayer)
	{Determines the index of a specific player in the collection.}
	If (aPlayer)
		return Players.Find(aPlayer)
	Else
		return Invalid
	EndIf
EndFunction


bool Function Contains(Player aPlayer)
	{Determines whether a player is in the collection.}
	return IndexOf(aPlayer) > Invalid
EndFunction


bool Function Remove(Player aPlayer)
	{Removes a player from the collection.}
	int index = IndexOf(aPlayer)

	If (index > Invalid)
		Players.Remove(index)
		return true
	Else
		WriteLine(self, "Could not find aPlayer '"+aPlayer+"' for abort.")
		return false
	EndIf
EndFunction


bool Function Add(Player aPlayer)
	{Adds a player to the collection.}
	If (aPlayer)
		If (Contains(aPlayer) == false)
			Players.Add(aPlayer)
			return true
		Else
			WriteLine(self, "The seats already contain the '"+aPlayer+"' aPlayer.")
			return false
		EndIf
	Else
		WriteLine(self, "Cannot add a none aPlayer.")
		return false
	EndIf
EndFunction


Function Clear()
	{Removes all players from the collection.}
	If (Players)
		Players.Clear()
	Else
		WriteLine(self, "The seats are empty or none.")
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Players
	Players:Dealer Property Dealer Auto Const Mandatory
	Players:Human Property Human Auto Const Mandatory
	Players:GamblerA Property GamblerA Auto Const Mandatory
	Players:GamblerB Property GamblerB Auto Const Mandatory
	Players:GamblerC Property GamblerC Auto Const Mandatory
	Players:GamblerD Property GamblerD Auto Const Mandatory
EndGroup

Group ReadOnly
	int Property Count Hidden
		int Function Get()
			return Players.Length
		EndFunction
	EndProperty
EndGroup
