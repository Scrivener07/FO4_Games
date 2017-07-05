ScriptName Games:Blackjack:Components:GUI extends Games:Blackjack:Component
import Games
import Games:Blackjack
import Games:Shared
import Games:Shared:Common
import Games:Shared:Deck


int OptionExit = 0 const
int OptionStart = 1 const



Function UpdateWidgets(Player gambler, string turnText = "")
	{TODO: TEMP ONLY}

	StatusWidget.Bet = Blackjack.Human.Wager
	StatusWidget.Caps = Blackjack.Human.Caps
	StatusWidget.Earnings = Blackjack.Human.Winnings
	StatusWidget.Score = Blackjack.Human.Score
	StatusWidget.Phase = Blackjack.GetState()

	PlayerWidget.Name = gambler.Name
	PlayerWidget.Turn = turnText
	PlayerWidget.Score = gambler.Score
	PlayerWidget.Bet = gambler.Wager
	PlayerWidget.Earnings = gambler.Winnings
EndFunction


; Events
;---------------------------------------------

Event OnInit()
	StatusWidget.Widget()
	PlayerWidget.Widget()
	RegisterForPhaseEvent(BlackJack)

	RegisterForCustomEvent(Prompt, "OnSelected")
	RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
EndEvent


Event OnQuestInit()
	StatusWidget.Register()
	PlayerWidget.Register()
EndEvent


Event Actor.OnPlayerLoadGame(Actor akSender)
	StatusWidget.Widget()
	PlayerWidget.Widget()
EndEvent


; Component
;---------------------------------------------

Event OnGamePhase(PhaseEventArgs e)
	WriteLine(self, e)

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
	EndIf
EndEvent


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


; Starting
;---------------------------------------------

State Starting
	Event OnBeginState(string asOldState)
		StatusWidget.Load()
		PlayerWidget.Load()

		UpdateWidgets(Blackjack.Dealer)

		ReleaseThread()
	EndEvent
EndState


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


Function ShowKickedEntry()
	UpdateWidgets(Blackjack.Dealer, "Kicking")
	WriteMessage("Kicked", "You dont have any caps to play Blackjack.")
EndFunction


; Wagering
;---------------------------------------------

State Wagering
	Event OnBeginState(string asOldState)
		UpdateWidgets(Blackjack.Dealer, "Dealing")

		ReleaseThread()
	EndEvent
EndState


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


Function WagerPaid(Player gambler)
	string msg = "Bet "+gambler.Wager+" caps."
	UpdateWidgets(gambler, msg)
	; WriteMessage(gambler.Name, msg)
EndFunction


Function ShowKickedWager()
	UpdateWidgets(Blackjack.Dealer, "Kicking")
	; WriteMessage("Kicked", "Your all out of caps. Better luck next time.")
EndFunction


; Dealing
;---------------------------------------------

State Dealing
	Event OnBeginState(string asOldState)
		UpdateWidgets(Blackjack.Dealer)

		ReleaseThread()
	EndEvent
EndState


; Playing
;---------------------------------------------

State Playing
	Event OnBeginState(string asOldState)
		UpdateWidgets(Blackjack.Dealer)

		ReleaseThread()
	EndEvent
EndState


Function TurnStanding(Player gambler)
	string msg = "Standing with 21."
	UpdateWidgets(gambler, msg)
	; WriteMessage(gambler.Name, msg+"\n"+gambler.ToString())
EndFunction


Function TurnBusted(Player gambler)
	string msg = "Busted!"
	UpdateWidgets(gambler, msg)
	; WriteMessage(gambler.Name, msg+"\n"+gambler.ToString())
EndFunction


Function TurnDrew(Player gambler, Card last)
	string msg = "Drew a card."
	UpdateWidgets(gambler, msg)
	; WriteMessage(gambler.Name, msg+"\n"+last)
EndFunction


Function TurnStand(Player gambler)
	string msg = "Chose to stand."
	UpdateWidgets(gambler, msg)
	; WriteMessage(gambler.Name, msg+"\n"+gambler.ToString())
EndFunction


Function TurnDrawWarning(Player gambler)
	string msg = "Error Drawing"
	UpdateWidgets(gambler, msg)
	; WriteMessage(gambler.Name, msg+"\nStanding, problem hitting for another card!\n"+gambler.ToString())
EndFunction


Function TurnChoiceWarning(Player gambler, int choice)
	string msg = "Error Turn"
	UpdateWidgets(gambler, msg)
	; WriteMessage(gambler.Name, msg+"\nStanding, the play choice "+choice+" was out of range.\n"+gambler.ToString())
EndFunction


; Scoring
;---------------------------------------------

State Scoring
	Event OnBeginState(string asOldState)
		UpdateWidgets(Blackjack.Dealer)

		ReleaseThread()
	EndEvent
EndState


; Function ShowWinner(float score)
; 	UpdateWidgets(Blackjack.Dealer)
; 	Games_Blackjack_MessageWinNatural.Show(score)
; EndFunction


; Function ShowLoser(float score)
; 	UpdateWidgets(Blackjack.Dealer)
; 	Games_Blackjack_MessageBust.Show(score)
; EndFunction


Function WagerWon(Player gambler, int caps)
	string msg = "Won "+caps+" caps."
	UpdateWidgets(gambler, msg)
	; WriteMessage(gambler.Name, msg)
EndFunction


Function WagerRefunded(Player gambler)
	string msg = "Refunded "+gambler.Wager+" caps."
	UpdateWidgets(gambler, msg)
	; WriteMessage(gambler.Name, msg)
EndFunction


bool Function PromptPlayAgain()
	return Games_Blackjack_MessagePlayAgain.Show() == 1
EndFunction


Function ScoreWarning(Player gambler, Player dealer)
	string msg = "Error Scoring"
	UpdateWidgets(gambler, msg)
	; WriteMessage(gambler.Name, msg+"\nProblem handling score "+gambler.Score+" against dealers "+dealer.Score+".")
EndFunction


Function PlayersWins(Player gambler, Player dealer)
	string msg = "Winner"
	UpdateWidgets(gambler, msg)
	; WriteMessage(gambler.Name, msg+"\nScore of "+gambler.Score+" beats dealers "+dealer.Score+".")
EndFunction


Function DealerBusted(Player gambler, Player dealer)
	string msg = "Winner"
	UpdateWidgets(gambler, msg)
	; WriteMessage(gambler.Name, msg+"\nThe dealer busted with "+dealer.Score+".")
EndFunction


Function PlayerBusted(Player gambler)
	string msg = "Loser"
	UpdateWidgets(gambler, msg)
	; WriteMessage(gambler.Name, msg+"\nScore of "+gambler.Score+" is a bust.")
EndFunction


Function PlayerLoses(Player gambler, Player dealer)
	string msg = "Loser"
	UpdateWidgets(gambler, msg)
	; WriteMessage(gambler.Name, msg+"\nScore of "+gambler.Score+" loses to dealers "+dealer.Score+".")
EndFunction


Function PlayerPushed(Player gambler, Player dealer)
	string msg = "Push"
	UpdateWidgets(gambler, msg)
	; WriteMessage(gambler.Name, msg+"\nScore of "+gambler.Score+" pushes dealers "+dealer.Score+".")
EndFunction


; Exiting
;---------------------------------------------

State Exiting
	Event OnBeginState(string asOldState)
		StatusWidget.Unload()

		ReleaseThread()
	EndEvent
EndState


; HUMAN ONLY
;---------------------------------------------

int Function ShowTurn(float card1, float card2, float score)
	return Games_Blackjack_MessageTurn.Show(card1, card2, score)
EndFunction


int Function ShowTurnDealt(float card, float score)
	return Games_Blackjack_MessageTurnDealt.Show(card, score)
EndFunction


; Properties
;---------------------------------------------

Group Object
	Blackjack:Game Property Blackjack Auto Const Mandatory
	BlackJack:StatusWidget Property StatusWidget Auto Const Mandatory
	BlackJack:PlayerWidget Property PlayerWidget Auto Const Mandatory
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
;	Message Property Games_Blackjack_MessageWinNatural Auto Const Mandatory
	Message Property Games_Blackjack_MessageBust Auto Const Mandatory
EndGroup
