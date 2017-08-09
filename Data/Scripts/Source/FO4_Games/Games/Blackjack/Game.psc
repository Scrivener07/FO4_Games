ScriptName Games:Blackjack:Game extends Games:Blackjack:Object
import Games
import Games:Papyrus:Log
import Games:Papyrus:Script
import Games:Shared
import Games:Shared:Deck

ObjectReference Entry
Player[] Players
CustomEvent PhaseEvent

float TimeWait = 3.0 const


; Events
;---------------------------------------------

Event OnInit()
	Players = new Player[0]
	Display.Setup()
	Choice.Setup()
	RegisterForPhaseEvent(self)
EndEvent


Event OnQuestInit()
	Display.Register()
EndEvent


; Object
;---------------------------------------------

Event OnGamePhase(PhaseEventArgs e)
	WriteLine(self, e)
	Display.Phase = e.Name
EndEvent


State Starting
	Event OnBeginState(string asOldState)
		{Session Begin}
		WriteLine("Phase", "Starting")

		If (Human.HasCaps == false)
			ChangeState(self, IdlePhase)
			WriteMessage("Kicked", "You dont have any caps to play Blackjack.")
			return
		EndIf

		If (SendPhase(self, StartingPhase, Begun))
			Display.Load()
			Table.Await(StartingPhase)
			Cards.Await(StartingPhase)

			Add(Abraham)
			Abraham.Await(StartingPhase)

			Add(Baxter)
			Baxter.Await(StartingPhase)

			Add(Human)
			Human.Await(StartingPhase)

			Add(Chester)
			Chester.Await(StartingPhase)

			Add(Dewey)
			Dewey.Await(StartingPhase)

			Add(Dealer)
			Dealer.Await(StartingPhase)

			ChangeState(self, WageringPhase)
		Else
			ChangeState(self, ExitingPhase)
		EndIf
	EndEvent

	Event OnEndState(string asNewState)
		If (asNewState == WageringPhase)
			SendPhase(self, StartingPhase, Ended)
		EndIf
	EndEvent
EndState


State Wagering
	Event OnBeginState(string asOldState)
		{Game State}
		WriteLine("Phase", "Wagering")

		If (Human.HasCaps == false)
			ChangeState(self, ExitingPhase)
			Prompt.ShowKicked()
			return
		EndIf

		If (SendPhase(self, WageringPhase, Begun))
			Utility.Wait(TimeWait)

			If (Players)
				int index = 0
				While (index < Count)
					For(Players[index])
					Utility.Wait(TimeWait)
					index += 1
				EndWhile
			Else
				WriteLine(self, "There are no players to wager.")
			EndIf

			If (Human.Bet == Invalid)
				ChangeState(self, ExitingPhase)
			Else
				ChangeState(self, DealingPhase)
			EndIf
		Else
			ChangeState(self, ExitingPhase)
		EndIf
	EndEvent


	Function For(Player gambler)
		gambler.Await(WageringPhase)
	EndFunction


	Event OnEndState(string asNewState)
		SendPhase(self, WageringPhase, Ended)
	EndEvent
EndState


State Dealing
	Event OnBeginState(string asOldState)
		{Game State}
		WriteLine("Phase", "Dealing")

		If (SendPhase(self, DealingPhase, Begun))
			Utility.Wait(TimeWait)

			Cards.Shuffle()

			If (Players)
				int index = 0
				While (index < Count)
					For(Players[index])
					index += 1
				EndWhile

				index = 0
				While (index < Count)
					For(Players[index])
					index += 1
				EndWhile
			Else
				WriteLine(self, "There are no players to deal.")
			EndIf

			ChangeState(self, PlayingPhase)
		Else
			ChangeState(self, ExitingPhase)
		EndIf
	EndEvent


	Function For(Player gambler)
		gambler.Await(DealingPhase)
	EndFunction


	Event OnEndState(string asNewState)
		SendPhase(self, DealingPhase, Ended)
	EndEvent
EndState


State Playing
	Event OnBeginState(string asOldState)
		{Game State}
		WriteLine("Phase", "Playing")

		If (SendPhase(self, PlayingPhase, Begun))
			Utility.Wait(TimeWait)

			If (Players)
				int index = 0
				While (index < Count)
					For(Players[index])
					Utility.Wait(TimeWait)
					index += 1
				EndWhile
			Else
				WriteLine(self, "There are no players to play.")
			EndIf

			ChangeState(self, ScoringPhase)
		Else
			ChangeState(self, ExitingPhase)
		EndIf
	EndEvent


	Function For(Player gambler)
		gambler.Await(PlayingPhase)
	EndFunction


	Event OnEndState(string asNewState)
		SendPhase(self, PlayingPhase, Ended)
	EndEvent
EndState


State Scoring
	Event OnBeginState(string asOldState)
		{Game State}
		WriteLine("Phase", "Scoring")

		If (SendPhase(self, ScoringPhase, Begun))
			Utility.Wait(TimeWait)

			If (Players)
				int index = 0
				While (index < Count)
					For(Players[index])
					index += 1
				EndWhile

				If (Human.HasCaps)
					If (Prompt.PlayAgain())
						ChangeState(self, WageringPhase)
					Else
						ChangeState(self, ExitingPhase)
					EndIf
				Else
					ChangeState(self, ExitingPhase)
					Prompt.ShowKicked()
				EndIf

			Else
				WriteLine(self, "There are no players to score.")
				ChangeState(self, ExitingPhase)
			EndIf
		Else
			ChangeState(self, ExitingPhase)
		EndIf
	EndEvent


	Function For(Player gambler)
		gambler.Await(ScoringPhase) ; refactor to Player.psc
		Cards.CollectFrom(gambler)
	EndFunction


	Event OnEndState(string asNewState)
		SendPhase(self, ScoringPhase, Ended)
	EndEvent
EndState


State Exiting
	Event OnBeginState(string asOldState)
		{Session End}
		WriteLine("Phase", "Exiting")

		If (SendPhase(self, ExitingPhase, Begun))
			Utility.Wait(TimeWait)

			Display.Unload()

			Table.Await(ExitingPhase)
			Cards.Await(ExitingPhase)

			Clear()
		EndIf

		ChangeState(self, IdlePhase)
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, ExitingPhase, Ended)
	EndEvent
EndState


bool Function SendPhase(Blackjack:Game sender, string name, bool change) Global
	If (sender.StateName == name)

		PhaseEventArgs phase = new PhaseEventArgs
		phase.Name = name
		phase.Change = change

		var[] arguments = new var[1]
		arguments[0] = phase

		WriteLine(sender, "Sending phase event:" + phase)
		sender.SendCustomEvent("PhaseEvent", arguments)
		return true
	Else
		WriteLine(sender, "Cannot not send the phase '"+name+"' while in the '"+sender.StateName+"' state.")
		return false
	EndIf
EndFunction


Function For(Player gambler)
	{EMPTY}
EndFunction




; Methods
;---------------------------------------------

bool Function Play(ObjectReference aEntryPoint)
	If (Idling)
		If (aEntryPoint)
			Entry = aEntryPoint
			return ChangeState(self, StartingPhase)
		Else
			WriteLine(self, "The game needs an entry point reference to play.")
			return false
		EndIf
	Else
		WriteLine(self, "The game is not ready to play right now.")
		return false
	EndIf
EndFunction


; Functions
;---------------------------------------------

bool Function IsWin(int aScore)
	return aScore == Win
EndFunction


bool Function IsInPlay(int aScore)
	return aScore < Win
EndFunction


bool Function IsBust(int aScore)
	return aScore > Win
EndFunction


int Function Score(Player gambler)
	int score = 0

	int index = 0
	While (index < gambler.Hand.Length)
		Card item = gambler.Hand[index]

		If (item.Rank == Cards.Deck.Ace)
			score += 11
		ElseIf (Cards.Deck.IsFaceCard(item))
			score += 10
		Else
			score += item.Rank
		EndIf

		index += 1
	EndWhile

	index = 0
	While (index < gambler.Hand.Length)
		Card item = gambler.Hand[index]

		If (item.Rank == Cards.Deck.Ace)
			If (IsBust(score))
				score -= 10
			EndIf
		EndIf

		index += 1
	EndWhile

	return score
EndFunction


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
	Objects:Table Property Table Auto Const Mandatory
	Objects:Cards Property Cards Auto Const Mandatory
EndGroup

Group UI
	UI:Display Property Display Auto Const Mandatory
	UI:Choice Property Choice Auto Const Mandatory
	UI:Prompt Property Prompt Auto Const Mandatory
EndGroup

Group Actions
	ObjectReference Property EntryPoint Hidden
		ObjectReference Function Get()
			return Entry
		EndFunction
	EndProperty
EndGroup

Group Players
	int Property Count Hidden
		int Function Get()
			return Players.Length
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
