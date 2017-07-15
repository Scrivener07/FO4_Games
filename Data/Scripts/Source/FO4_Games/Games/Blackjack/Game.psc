ScriptName Games:Blackjack:Game extends Games:Blackjack:Component
import Games
import Games:Shared:Common
import Games:Shared:Deck
import Games:Shared

ObjectReference Entry
Player[] Players
CustomEvent PhaseEvent

float TimeWait = 3.0 const


; Events
;---------------------------------------------

Event OnInit()
	Players = new Player[0]
	HUD.Widget()
	RegisterForPhaseEvent(self)
	RegisterForCustomEvent(Prompt, "OnSelected")
EndEvent


Event OnQuestInit()
	HUD.Register()
EndEvent


; Component
;---------------------------------------------

Event OnGamePhase(PhaseEventArgs e)
	WriteLine(self, e)
	HUD.Phase = e.Name

	If (e.Change == Begun)
		If (e.Name == WageringPhase)
			Prompt.Display(Games_Blackjack_ActivateMenu, Games_Blackjack_Activate_Wager)
		EndIf

		If (e.Name == PlayingPhase)
			Prompt.Display(Games_Blackjack_ActivateMenu, Games_Blackjack_Activate_Turn)
		EndIf

		If (e.Name == ScoringPhase)
			Prompt.Display(Games_Blackjack_ActivateMenu, Games_Blackjack_Activate_Replay)
		EndIf
	Else
		Prompt.Clear()
	EndIf
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
			HUD.Load()
			Table.CallAndWait(StartingPhase)
			Cards.CallAndWait(StartingPhase)

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
			ShowKickedWager()
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

			If (Human.Wager == Invalid)
				ChangeState(self, ExitingPhase)
			Else
				ChangeState(self, DealingPhase)
			EndIf
		Else
			ChangeState(self, ExitingPhase)
		EndIf
	EndEvent


	Function For(Player gambler)
		gambler.CallAndWait(WageringPhase)
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
		gambler.CallAndWait(DealingPhase)
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
		gambler.CallAndWait(PlayingPhase)
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
					If (PromptPlayAgain())
						ChangeState(self, WageringPhase)
					Else
						ChangeState(self, ExitingPhase)
					EndIf
				Else
					ChangeState(self, ExitingPhase)
					ShowKickedWager()
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
		If (gambler is Players:Dealer)
			WriteLine(Dealer, "Skipped for scoring.")
		Else
			If (IsBust(gambler.Score))
				HUD.Text = "Score of "+gambler.Score+" is a bust."
			Else
				If (IsBust(Dealer.Score))
					HUD.Text = "The dealer busted with "+Dealer.Score+"."
					gambler.WinWager()
				Else
					If (gambler.Score > Dealer.Score)
						HUD.Text = "Score of "+gambler.Score+" beats dealers "+Dealer.Score+"."
						gambler.WinWager()
					ElseIf (gambler.Score < Dealer.Score)
						HUD.Text = "Score of "+gambler.Score+" loses to dealers "+Dealer.Score+"."
					ElseIf (gambler.Score == Dealer.Score)
						HUD.Text = "Score of "+gambler.Score+" pushes dealers "+Dealer.Score+"."
						gambler.PushWager()
					Else
						; derp, i dont know what happened
						WriteLine(self, "Error, problem handling score "+gambler.Score+" against dealers "+dealer.Score+".")
					EndIf
				EndIf
			EndIf
		EndIf

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

			HUD.Unload()

			Table.CallAndWait(ExitingPhase)
			Cards.CallAndWait(ExitingPhase)

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


; HUD
;---------------------------------------------

Event Games:Shared:Controllers:Prompt.OnSelected(Controllers:Prompt akSender, var[] arguments)
	If (akSender.Menu == Games_Blackjack_Activate_Wager)
		int OptionIncrease = 0 const
		int OptionDecrease = 1 const
		int OptionContinue = 2 const

		If (akSender.Selected == OptionIncrease)
			WriteMessage("Selected", "Increased Bet\nSelected:"+akSender.Selected)
		EndIf
		If (akSender.Selected == OptionDecrease)
			WriteMessage("Selected", "Decreased Bet\nSelected:"+akSender.Selected)
		EndIf
		If (akSender.Selected == OptionContinue)
			WriteMessage("Selected", "Continue with Bet\nSelected:"+akSender.Selected)
		EndIf
	EndIf

	If (akSender.Menu == Games_Blackjack_Activate_Turn)
		int OptionHit = 0 const
		int OptionStay = 1 const
		int OptionDouble = 2 const
		int OptionSplit = 3 const

		If (akSender.Selected == OptionHit)
			WriteMessage("Selected", "Hit\nSelected:"+akSender.Selected)
		EndIf
		If (akSender.Selected == OptionStay)
			WriteMessage("Selected", "Stay\nSelected:"+akSender.Selected)
		EndIf
		If (akSender.Selected == OptionDouble)
			WriteMessage("Selected", "Double Down\nSelected:"+akSender.Selected)
		EndIf
		If (akSender.Selected == OptionSplit)
			WriteMessage("Selected", "Split\nSelected:"+akSender.Selected)
		EndIf
	EndIf

	If (akSender.Menu == Games_Blackjack_Activate_Replay)
		int OptionNo = 0 const
		int OptionYes = 1 const

		If (akSender.Selected == OptionNo)
			WriteMessage("Selected", "Replay No\nSelected:"+akSender.Selected)
		EndIf
		If (akSender.Selected == OptionYes)
			WriteMessage("Selected", "Replay Yes\nSelected:"+akSender.Selected)
		EndIf
	EndIf
EndEvent


bool Function PromptPlay()
	int selected = Games_Blackjack_MessagePlay.Show()
	int OptionExit = 0 const
	int OptionStart = 1 const

	If (selected == OptionStart)
		return true

	ElseIf (selected == OptionExit || selected == Invalid)
		WriteLine(self, "Chose not to play Blackjack.")
		return false
	Else
		WriteLine(self, "The option '"+selected+"' is unhandled.")
		return false
	EndIf
EndFunction


bool Function PromptPlayAgain()
	return Games_Blackjack_MessagePlayAgain.Show() == 1
EndFunction


int Function PromptWager()
	int selected = Games_Blackjack_MessageWager.Show(Human.Caps, Human.Winnings)
	int OptionExit = 0 const
	int OptionWager1 = 1 const
	int OptionWager5 = 2 const
	int OptionWager10 = 3 const
	int OptionWager20 = 4 const
	int OptionWager50 = 5 const
	int OptionWager100 = 6 const

	If (selected == OptionExit || selected == Invalid)
		return Invalid
	ElseIf (selected == OptionWager1)
		return 1
	ElseIf (selected == OptionWager5)
		return 5
	ElseIf (selected == OptionWager10)
		return 10
	ElseIf (selected == OptionWager20)
		return 20
	ElseIf (selected == OptionWager50)
		return 50
	ElseIf (selected == OptionWager100)
		return 100
	Else
		WriteLine(self, "The option '"+selected+"' is unhandled.")
		return Invalid
	EndIf
EndFunction


int Function ShowTurn(float card1, float card2, float score)
	return Games_Blackjack_MessageTurn.Show(card1, card2, score)
EndFunction


int Function ShowTurnDealt(float card, float score)
	return Games_Blackjack_MessageTurnDealt.Show(card, score)
EndFunction


Function ShowKickedWager()
	; dummy for `Message`
	WriteMessage("Kicked", "Your all out of caps. Better luck next time.")
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
	Components:HUD Property HUD Auto Const Mandatory
	Components:Table Property Table Auto Const Mandatory
	Components:Cards Property Cards Auto Const Mandatory
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

Group HUD
	Controllers:Prompt Property Prompt Auto Const Mandatory

	ObjectReference Property Games_Blackjack_ActivateMenu Auto Const Mandatory
	Perk Property Games_Blackjack_Activate_Replay Auto Const Mandatory
	Perk Property Games_Blackjack_Activate_Turn Auto Const Mandatory
	Perk Property Games_Blackjack_Activate_Wager Auto Const Mandatory

	Message Property Games_Blackjack_MessageWager Auto Const Mandatory
	Message Property Games_Blackjack_MessageTurn Auto Const Mandatory
	Message Property Games_Blackjack_MessageTurnDealt Auto Const Mandatory
	Message Property Games_Blackjack_MessagePlay Auto Const Mandatory
	Message Property Games_Blackjack_MessagePlayAgain Auto Const Mandatory
	Message Property Games_Blackjack_MessageWin Auto Const Mandatory
	Message Property Games_Blackjack_MessageBust Auto Const Mandatory
EndGroup

Group Scoring
	int Property Win = 21 AutoReadOnly
EndGroup
