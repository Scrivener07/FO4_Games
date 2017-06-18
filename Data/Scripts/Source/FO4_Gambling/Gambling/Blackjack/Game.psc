ScriptName Gambling:Blackjack:Game extends Gambling:Blackjack:Component
import Gambling
import Gambling:Blackjack
import Gambling:Blackjack:Players
import Gambling:Shared
import Gambling:Shared:Common


Player[] Players
CustomEvent PhaseEvent


; Events
;---------------------------------------------

Event OnInit()
	Players = new Player[0]
EndEvent


; Component
;---------------------------------------------

State Starting
	Event OnBeginState(string asOldState)
		{Session Begin}
		WriteLine("Phase", "Starting")
		SendPhase(self, StartingPhase, Begun)

		If (GUI.PromptPlay())

			If (Table.CallAndWait(StartingPhase))
				WriteLine(self, "Table component has finished the Starting thread.")
			EndIf
			If (Cards.CallAndWait(StartingPhase))
				WriteLine(self, "Cards component has finished the Starting thread.")
			EndIf

			Add(Human)
			Human.CallAndWait(StartingPhase)

			Add(Abraham)
			Abraham.CallAndWait(StartingPhase)

			Add(Baxter)
			Baxter.CallAndWait(StartingPhase)

			Add(Chester)
			Chester.CallAndWait(StartingPhase)

			Add(Dewey)
			Dewey.CallAndWait(StartingPhase)

			Add(Dealer)
			Dealer.CallAndWait(StartingPhase)

			ChangeState(self, WageringPhase)
		Else
			ChangeState(self, IdlePhase)
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
		SendPhase(self, WageringPhase, Begun)

		If (Players)
			int index = 0
			While (index < Count)
				Player gambler = Players[index]
				gambler.CallAndWait(WageringPhase)
				WriteLine(self, gambler.Name+" has chosen to wager "+gambler.Wager)
				index += 1
			EndWhile
		Else
			WriteLine(self, "There are no players to wager.")
		EndIf

		ChangeState(self, DealingPhase)
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, WageringPhase, Ended)
	EndEvent
EndState


State Dealing
	Event OnBeginState(string asOldState)
		{Game State}
		WriteLine("Phase", "Dealing")
		SendPhase(self, DealingPhase, Begun)

		Cards.Shuffle()
		If (Players)
			int index = 0
			While (index < Count)
				Players[index].CallAndWait(DealingPhase)
				index += 1
			EndWhile

			index = 0
			While (index < Count)
				Players[index].CallAndWait(DealingPhase)
				index += 1
			EndWhile
		Else
			WriteLine(self, "There are no players to deal.")
		EndIf

		ChangeState(self, PlayingPhase)

	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, DealingPhase, Ended)
	EndEvent
EndState


State Playing
	Event OnBeginState(string asOldState)
		{Game State}
		WriteLine("Phase", "Playing")
		SendPhase(self, PlayingPhase, Begun)

		If (Players)
			int index = 0
			While (index < Count)
				Players[index].CallAndWait(PlayingPhase)
				index += 1
			EndWhile
		Else
			WriteLine(self, "There are no players to play.")
		EndIf

		ChangeState(self, ScoringPhase)
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, PlayingPhase, Ended)
	EndEvent
EndState


State Scoring
	Event OnBeginState(string asOldState)
		{Game State}
		WriteLine("Phase", "Scoring")
		SendPhase(self, ScoringPhase, Begun)

		If (Players)
			bool houseWins = Rules.IsWin(Dealer.Score)

			int index = 0
			While (index < Count)
				Player gambler = Players[index]

				If (gambler is Players:Dealer)
					WriteLine(Dealer, "Skipping, already scored.")
				Else


					If (houseWins)
						WriteMessage(gambler.Name, "The house wins with "+Dealer.Score)
					Else

						If (Rules.IsWin(gambler.Score))
							WriteMessage(gambler.Name, "Final score of "+gambler.Score+" is a winner.")
						;	GUI.ShowWinner(gambler.Score)

						ElseIf (Rules.IsBust(gambler.Score))
							WriteMessage(gambler.Name, "Final score of "+gambler.Score+" is a bust.")
						;	GUI.ShowLoser(gambler.Score)

						ElseIf (gambler.Score > Dealer.Score)
							WriteMessage(gambler.Name, "Final score of "+gambler.Score+" beats dealers "+Dealer.Score+".")
						Else
							WriteMessage(gambler.Name, "Warning, cannot determine score!")
						EndIf
					EndIf



				EndIf

				Cards.CollectFrom(gambler)
				index += 1
			EndWhile
		Else
			WriteLine(self, "There are no players to score.")
		EndIf

		If (GUI.PromptPlayAgain())
			ChangeState(self, WageringPhase)
		Else
			ChangeState(self, ExitingPhase)
		EndIf
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, ScoringPhase, Ended)
	EndEvent
EndState


State Exiting
	Event OnBeginState(string asOldState)
		{Session End}
		WriteLine("Phase", "Exiting")
		SendPhase(self, ExitingPhase, Begun)

		If (Table.CallAndWait(ExitingPhase))
			WriteLine(self, "Table component has finished the Exiting thread.")
		EndIf
		If (Cards.CallAndWait(ExitingPhase))
			WriteLine(self, "Cards component has finished the Exiting thread.")
		EndIf

		Clear()

		ChangeState(self, IdlePhase)
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, ExitingPhase, Ended)
	EndEvent
EndState


; Methods
;---------------------------------------------

bool Function Play(Actions:Play playAction)
	If (Idling)
		If (playAction)
			Table.PlayAction = playAction
		EndIf
		return ChangeState(self, StartingPhase)
	Else
		WriteLine(self, "The game is not ready to play right now.")
		return false
	EndIf
EndFunction


; Functions
;---------------------------------------------

Function SendPhase(Blackjack:Game sender, string name, bool change) Global
	string stateName = sender.GetState()
	If (stateName == name)

		PhaseEventArgs phase = new PhaseEventArgs
		phase.Name = name
		phase.Change = change

		var[] arguments = new var[1]
		arguments[0] = phase

		WriteLine(sender, "Sending phase event:" + phase)
		sender.SendCustomEvent("PhaseEvent", arguments)
	Else
		WriteLine(sender, "Cannot not send the phase '"+name+"' while in the '"+stateName+"' state.")
	EndIf
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

Group Game
	Components:Rules Property Rules Auto Const Mandatory
	Components:GUI Property GUI Auto Const Mandatory
	Components:Table Property Table Auto Const Mandatory
	Components:Cards Property Cards Auto Const Mandatory
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