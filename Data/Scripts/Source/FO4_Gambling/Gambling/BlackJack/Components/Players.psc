ScriptName Gambling:BlackJack:Components:Players extends Gambling:BlackJack:Component
import Gambling
import Gambling:BlackJack
import Gambling:Shared:Common


Player[] Players



; Events
;---------------------------------------------

Event OnInit()
	Players = new Player[0]
	RegisterForPhaseEvent(BlackJack)
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


Event OnAllocate()
	; TODO: variable player count, do we have enough players to play?

	If !(Players)
		Add(Human)
		Human.OnAllocate()

		Add(BotA)
		BotA.OnAllocate()

		Add(BotB)
		BotB.OnAllocate()

		Add(BotC)
		BotC.OnAllocate()

		Add(BotD)
		BotD.OnAllocate()

		Add(Dealer)
		Dealer.OnAllocate()
	Else
		WriteLine(self, "Players are already allocated.")
	EndIf
EndEvent


Event OnWager()
	If (Players)
		int index = 0
		While (index < Count)
			Players[index].OnWager()
			index += 1
		EndWhile
	Else
		WriteLine(self, "There are no players to wager.")
	EndIf
EndEvent


Event OnDeal()
	If (Players)
		int index = 0
		While (index < Count)
			Player gambler = Players[index]

			gambler.OnDeal()
			gambler.OnDeal()

			; BlackJack.Cards.Draw(gambler)
			; BlackJack.Cards.Draw(gambler)
			index += 1
		EndWhile
	Else
		WriteLine(self, "There are no players to deal.")
	EndIf
EndEvent


Event OnPlay()
	If (Players)
		int index = 0
		While (index < Count)
			Players[index].OnPlay()
			index += 1
		EndWhile
	Else
		WriteLine(self, "There are no players to play.")
	EndIf
EndEvent


Event OnDeallocate()
	If (Players)
		int index = 0
		While (index < Count)
			Players[index].OnDeallocate()
			index += 1
		EndWhile

		Clear()
	Else
		WriteLine(self, "There are no players to deallocate.")
	EndIf
EndEvent


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
		WriteLine(self, "The seats are empty or none.")
	EndIf
EndFunction


; Properties
;---------------------------------------------
Group Game
	BlackJack:Game Property BlackJack Auto Const Mandatory
EndGroup

Group Players
	Players:BotA Property BotA Auto Const Mandatory
	Players:BotB Property BotB Auto Const Mandatory
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
