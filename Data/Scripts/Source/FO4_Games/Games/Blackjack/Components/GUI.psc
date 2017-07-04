ScriptName Games:Blackjack:Components:GUI extends Games:Blackjack:Component
import Games
import Games:Blackjack
import Games:Shared
import Games:Shared:Common
import Games:Shared:Deck


int OptionExit = 0 const
int OptionStart = 1 const

; Events
;---------------------------------------------

Event OnInit()
	StatusWidget.Widget()

	RegisterForPhaseEvent(BlackJack)
	RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
EndEvent


Event OnQuestInit()
	StatusWidget.Register()
EndEvent


Event Actor.OnPlayerLoadGame(Actor akSender)
	StatusWidget.Widget()
EndEvent


; Component
;---------------------------------------------

Event OnGamePhase(PhaseEventArgs e)
	WriteLine(self, e)

	If (e.Change == Begun)
		If (e.Name == WageringPhase)
			int OptionIncrease = 0 const
			int OptionDecrease = 1 const
			int selected = Prompt.Show(Games_Blackjack_Activate_Wager)

			If (selected == OptionIncrease)
				WriteMessage("Selected", "Increased Bet\nSelected:"+selected)
			EndIf
			If (selected == OptionDecrease)
				WriteMessage("Selected", "Decreased Bet\nSelected:"+selected)
			EndIf
		EndIf

		If (e.Name == PlayingPhase)
			int OptionHit = 0 const
			int OptionStay = 1 const
			int OptionDouble = 2 const
			int OptionSplit = 3 const
			int selected = Prompt.Show(Games_Blackjack_Activate_Turn)

			If (selected == OptionHit)
				WriteMessage("Selected", "Hit\nSelected:"+selected)
			EndIf
			If (selected == OptionStay)
				WriteMessage("Selected", "Stay\nSelected:"+selected)
			EndIf
			If (selected == OptionDouble)
				WriteMessage("Selected", "Double Down\nSelected:"+selected)
			EndIf
			If (selected == OptionSplit)
				WriteMessage("Selected", "Split\nSelected:"+selected)
			EndIf
		EndIf


		If (e.Name == ScoringPhase)
			int selected = Prompt.Show(Games_Blackjack_Activate_Replay)
			int OptionNo = 0 const
			int OptionYes = 1 const

			If (selected == OptionNo)
				WriteMessage("Selected", "Replay No\nSelected:"+selected)
			EndIf
			If (selected == OptionYes)
				WriteMessage("Selected", "Replay Yes\nSelected:"+selected)
			EndIf
		EndIf
	EndIf


	; If (e.Change == Ended)
	; 	If (e.Name == ScoringPhase)
	; 		Prompt.Hide()
	; 	EndIf
	; EndIf
EndEvent


State Starting
	Event OnBeginState(string asOldState)
		StatusWidget.Load()
		StatusWidget.Update()

		ReleaseThread()
	EndEvent
EndState


State Wagering
	Event OnBeginState(string asOldState)
		StatusWidget.Update()

		ReleaseThread()
	EndEvent
EndState


State Dealing
	Event OnBeginState(string asOldState)
		StatusWidget.Update()

		ReleaseThread()
	EndEvent
EndState


State Playing
	Event OnBeginState(string asOldState)
		StatusWidget.Update()

		ReleaseThread()
	EndEvent
EndState


State Scoring
	Event OnBeginState(string asOldState)
		StatusWidget.Update()

		ReleaseThread()
	EndEvent
EndState


State Exiting
	Event OnBeginState(string asOldState)
		StatusWidget.Unload()

		ReleaseThread()
	EndEvent
EndState


; Methods
;---------------------------------------------

bool Function PromptPlay()
	int selected = Games_Blackjack_MessagePlay.Show()

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


int Function PromptWager(Players:Human human)
	int selected = Games_Blackjack_MessageWager.Show(human.Caps, human.Winnings)
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


Function ShowWinner(float score)
	StatusWidget.Update()
	Games_Blackjack_MessageWinNatural.Show(score)
EndFunction


Function ShowLoser(float score)
	StatusWidget.Update()
	Games_Blackjack_MessageBust.Show(score)
EndFunction


Function ShowKickedEntry()
	StatusWidget.Update()
	WriteMessage("Kicked", "You dont have any caps to play Blackjack.")
EndFunction


Function ShowKickedWager()
	StatusWidget.Update()
	WriteMessage("Kicked", "Your all out of caps. Better luck next time.")
EndFunction


Function ScoreWarning(Player gambler, Player dealer)
	StatusWidget.Update()
	WriteMessage(gambler.Name, "Warning\nProblem handling score "+gambler.Score+" against dealers "+dealer.Score+".")
EndFunction


;--------------


Function PlayersWins(Player gambler, Player dealer)
	StatusWidget.Update()
	WriteMessage(gambler.Name, "Winner\nScore of "+gambler.Score+" beats dealers "+dealer.Score+".")
EndFunction


Function DealerBusted(Player gambler, Player dealer)
	StatusWidget.Update()
	WriteMessage(gambler.Name, "Winner\nThe dealer busted with "+dealer.Score+".")
EndFunction


Function PlayerBusted(Player gambler)
	StatusWidget.Update()
	WriteMessage(gambler.Name, "Loser\nScore of "+gambler.Score+" is a bust.")
EndFunction


Function PlayerLoses(Player gambler, Player dealer)
	StatusWidget.Update()
	WriteMessage(gambler.Name, "Loser\nScore of "+gambler.Score+" loses to dealers "+dealer.Score+".")
EndFunction


Function PlayerPushed(Player gambler, Player dealer)
	StatusWidget.Update()
	WriteMessage(gambler.Name, "Push\nScore of "+gambler.Score+" pushes dealers "+dealer.Score+".")
EndFunction


;--------------


Function WagerPaid(Player gambler)
	StatusWidget.Update()
	WriteMessage(gambler.Name, "Bet "+gambler.Wager+" caps.")
EndFunction


Function WagerWon(Player gambler, int caps)
	StatusWidget.Update()
	WriteMessage(gambler.Name, "Won "+caps+" caps.")
EndFunction


Function WagerRefunded(Player gambler)
	StatusWidget.Update()
	WriteMessage(gambler.Name, "Refunded "+gambler.Wager+" caps.")
EndFunction


;--------------


int Function ShowTurn(float card1, float card2, float score)
	return Games_Blackjack_MessageTurn.Show(card1, card2, score)
EndFunction


int Function ShowTurnDealt(float card, float score)
	return Games_Blackjack_MessageTurnDealt.Show(card, score)
EndFunction


Function TurnStanding(Player gambler)
	StatusWidget.Update()
	WriteMessage(gambler.Name, "Standing with 21.\n"+gambler.ToString())
EndFunction


Function TurnBusted(Player gambler)
	StatusWidget.Update()
	WriteMessage(gambler.Name, "Busted!\n"+gambler.ToString())
EndFunction


Function TurnDrew(Player gambler, Card last)
	StatusWidget.Update()
	WriteMessage(gambler.Name, "Drew a card.\n"+last)
EndFunction


Function TurnStand(Player gambler)
	StatusWidget.Update()
	WriteMessage(gambler.Name, "Chose to stand.\n"+gambler.ToString())
EndFunction


Function TurnDrawWarning(Player gambler)
	StatusWidget.Update()
	WriteMessage(gambler.Name, "Warning\nStanding, problem hitting for another card!\n"+gambler.ToString())
EndFunction


Function TurnChoiceWarning(Player gambler, int choice)
	StatusWidget.Update()
	WriteMessage(gambler.Name, "Warning\nStanding, the play choice "+choice+" was out of range.\n"+gambler.ToString())
EndFunction


; Properties
;---------------------------------------------

Group Object
	Blackjack:Game Property Blackjack Auto Const Mandatory
	BlackJack:StatusWidget Property StatusWidget Auto Const Mandatory
EndGroup

Group Prompts
	Controllers:Prompt Property Prompt Auto Const Mandatory
	ObjectReference Property Games_Blackjack_ActivateMenu Auto Const Mandatory
	Perk Property Games_Blackjack_Activate_Replay Auto Const Mandatory
	Perk Property Games_Blackjack_Activate_Turn Auto Const Mandatory
	Perk Property Games_Blackjack_Activate_Wager Auto Const Mandatory
EndGroup

Group Messages
	Message Property Games_Blackjack_MessageWager Auto Const Mandatory
	Message Property Games_Blackjack_MessageTurn Auto Const Mandatory
	Message Property Games_Blackjack_MessageTurnDealt Auto Const Mandatory
	Message Property Games_Blackjack_MessagePlay Auto Const Mandatory
	Message Property Games_Blackjack_MessagePlayAgain Auto Const Mandatory
	Message Property Games_Blackjack_MessageWin Auto Const Mandatory
	Message Property Games_Blackjack_MessageWinNatural Auto Const Mandatory
	Message Property Games_Blackjack_MessageBust Auto Const Mandatory
EndGroup
