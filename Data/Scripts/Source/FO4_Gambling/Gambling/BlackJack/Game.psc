ScriptName Gambling:BlackJack:Game extends Gambling:BlackJack:Component
import Gambling
import Gambling:BlackJack
import Gambling:BlackJack:Players
import Gambling:Shared
import Gambling:Shared:Common


CustomEvent PhaseEvent

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
		{Session Begin}
		WriteLine(self, "Starting")
		SendPhase(self, StartingPhase, Begun)

		If (GUI.PromptPlay())

			If (Table.StartAndWait())
				WriteLine(self, "Table component has finished the Starting thread.")
			EndIf
			If (Cards.StartAndWait())
				WriteLine(self, "Cards component has finished the Starting thread.")
			EndIf

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
		WriteLine(self, "Wagering")
		SendPhase(self, WageringPhase, Begun)

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

		ChangeState(self, DealingPhase)
	EndEvent

	Event OnEndState(string asNewState)
		SendPhase(self, WageringPhase, Ended)
	EndEvent
EndState


State Dealing
	Event OnBeginState(string asOldState)
		{Game State}
		WriteLine(self, "Dealing")
		SendPhase(self, DealingPhase, Begun)

		Cards.Shuffle()
		If (Players)
			int index = 0
			While (index < Count)
				Players[index].DealAndWait()
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
		WriteLine(self, "Playing")
		SendPhase(self, PlayingPhase, Begun)

		If (Players)
			int index = 0
			While (index < Count)
				Players[index].PlayAndWait()
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
		WriteLine(self, "Scoring")
		SendPhase(self, ScoringPhase, Begun)

		If (Players)
			int index = 0
			While (index < Count)
				Player gambler = Players[index]
				gambler.ScoreAndWait()

				; after the player has taken all of their turns
				If (gambler is Human)
					int score = gambler.Score

					If (Rules.IsWin(score))
						WriteLine(self, "Player final score of "+score+" is a winner.")
						GUI.ShowWinner(score)

					ElseIf (Rules.IsBust(score))
						WriteLine(self, "Player final score of "+score+" is a loser.")
						GUI.ShowLoser(score)
					EndIf
				EndIf

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
		WriteLine(self, "Exiting")
		SendPhase(self, ExitingPhase, Begun)

		If (Table.ExitAndWait())
			WriteLine(self, "Table component has finished the Exiting thread.")
		EndIf
		If (Cards.ExitAndWait())
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

Function SendPhase(BlackJack:Game sender, string name, bool change) Global
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

	Players:BotWhale Property BotWhale Auto Const Mandatory
	Players:BotSwatter Property BotSwatter Auto Const Mandatory
	Players:BotC Property BotC Auto Const Mandatory
	Players:BotD Property BotD Auto Const Mandatory
	Players:Human Property Human Auto Const Mandatory
	Players:Dealer Property Dealer Auto Const Mandatory
EndGroup
