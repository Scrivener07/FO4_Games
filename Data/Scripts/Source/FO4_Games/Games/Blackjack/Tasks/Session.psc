ScriptName Games:Blackjack:Tasks:Session extends Games:Blackjack:GameType
import Games
import Games:Blackjack
import Games:Shared
import Games:Papyrus:Log
import Games:Papyrus:Script

Player[] Players
float TimeWait = 3.0 const


;/ Player Slots
	Dealer  1x (Required)
	Human   2x (Required)
	Gambler 4x (Optional)
/;


; Events
;---------------------------------------------

Event OnInit()
	Players = new Player[0]
EndEvent


; Methods
;---------------------------------------------

int Function Score(Player gambler)
	int score = 0

	int index = 0
	While (index < gambler.Hand.Length)
		Deck:Card card = gambler.Hand[index]

		If (card.Rank == Blackjack.Cards.Deck.Ace)
			score += 11
		ElseIf (Blackjack.Cards.Deck.IsFaceCard(card))
			score += 10
		Else
			score += card.Rank
		EndIf

		index += 1
	EndWhile

	index = 0
	While (index < gambler.Hand.Length)
		Deck:Card card = gambler.Hand[index]

		If (card.Rank == Blackjack.Cards.Deck.Ace)
			If (IsBust(score))
				score -= 10
			EndIf
		EndIf

		index += 1
	EndWhile

	return score
EndFunction


; Tasks
;---------------------------------------------

State Starting
	Event Starting()
		{Allocate players for this session.}
		Add(Human)
		TaskAwait(Human, StartingTask)

		Add(Abraham)
		TaskAwait(Abraham, StartingTask)

		Add(Baxter)
		TaskAwait(Baxter, StartingTask)

		Add(Chester)
		TaskAwait(Chester, StartingTask)

		Add(Dewey)
		TaskAwait(Dewey, StartingTask)

		Add(Dealer)
		TaskAwait(Dealer, StartingTask)
	EndEvent

	bool Function Add(Player value)
		{Adds a player to the collection.}
		If (value)
			If (Contains(value) == false)
				Players.Add(value)
				return true
			Else
				WriteLine(self, "The player array already contains '"+value+"'.")
				return false
			EndIf
		Else
			WriteLine(self, "Cannot add a none value to player array.")
			return false
		EndIf
	EndFunction
EndState


State Wagering
	Event Wagering()
		For(Players)
	EndEvent

	Function Each(Player gambler)
		TaskRun(gambler, WageringTask)
		Utility.Wait(TimeWait)
	EndFunction
EndState


State Dealing
	Event Dealing()
		For(Players)
	EndEvent

	bool Function For(Player[] array)
		If (array)
			int index = 0
			While (index < array.Length)
				Each(array[index])
				index += 1
			EndWhile

			index = 0
			While (index < array.Length)
				Each(array[index])
				index += 1
			EndWhile
			return true
		Else
			WriteLine(self, "The array is empty or none.")
			return false
		EndIf
	EndFunction

	Function Each(Player gambler)
		TaskAwait(gambler, DealingTask)
	EndFunction
EndState


State Playing
	Event Playing()
		For(Players)
	EndEvent

	Function Each(Player gambler)
		TaskAwait(gambler, PlayingTask)
		Utility.Wait(TimeWait)
	EndFunction
EndState


State Scoring
	Event Scoring()
		For(Players)
		If (Human.HasCaps)
			If (Blackjack.Dialog.PlayAgain())
				ChangeState(Blackjack, WageringTask)
			Else
				ChangeState(Blackjack, ExitingTask)
			EndIf
		Else
			ChangeState(Blackjack, ExitingTask)
			Blackjack.Dialog.ShowKicked()
		EndIf
	EndEvent

	Function Each(Player gambler)
		TaskAwait(gambler, ScoringTask)
		Blackjack.Cards.CollectFrom(gambler)
	EndFunction
EndState


State Exiting
	Event Exiting()
		Clear()
	EndEvent

	Function Clear()
		{Removes all players from the collection.}
		If (Players)
			Players.Clear()
		Else
			WriteLine(self, "Cannot clear empty or none player array.")
		EndIf
	EndFunction
EndState


bool Function For(Player[] array)
	If (array)
		int index = 0
		While (index < array.Length)
			Each(array[index])
			index += 1
		EndWhile
		return true
	Else
		WriteLine(self, "Cannot iterate an empty or none player array.")
		return false
	EndIf
EndFunction


Function Each(Player gambler)
	{EMPTY}
EndFunction


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


bool Function Add(Player value)
	{EMPTY}
	return false
EndFunction


Function Clear()
	{EMPTY}
EndFunction


bool Function IsWin(int aScore)
	return aScore == Win
EndFunction


bool Function IsInPlay(int aScore)
	return aScore < Win
EndFunction


bool Function IsBust(int aScore)
	return aScore > Win
EndFunction


; Properties
;---------------------------------------------

Group Object
	Blackjack:Game Property Blackjack Auto Const Mandatory
EndGroup

Group Players
	int Property Count Hidden
		int Function Get()
			return Players.Length
		EndFunction
	EndProperty

	bool Property HasPlayers Hidden
		bool Function Get()
			return Count > 0
		EndFunction
	EndProperty

	bool Property HasHuman Hidden
		bool Function Get()
			return Contains(Human)
		EndFunction
	EndProperty

	Players:Human Property Human Auto Const Mandatory
	Players:Dealer Property Dealer Auto Const Mandatory
	Players:Abraham Property Abraham Auto Const Mandatory
	Players:Baxter Property Baxter Auto Const Mandatory
	Players:Chester Property Chester Auto Const Mandatory
	Players:Dewey Property Dewey Auto Const Mandatory
EndGroup

Group Scoring
	int Property Win = 21 AutoReadOnly
EndGroup
