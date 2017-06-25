ScriptName Gambling:Blackjack:Components:GUI extends Gambling:Blackjack:Component
import Gambling
import Gambling:Blackjack
import Gambling:Shared:Common


int OptionExit = 0 const
int OptionStart = 1 const


; Methods
;---------------------------------------------

bool Function PromptPlay()
	int selected = Gambling_Blackjack_MessagePlay.Show()

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
	return Gambling_Blackjack_MessagePlayAgain.Show() == 1
EndFunction


int Function PromptWager(Players:Human human)
	int selected = Gambling_Blackjack_MessageWager.Show(human.Caps, human.Winnings)
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
	return Gambling_Blackjack_MessageTurn.Show(card1, card2, score)
EndFunction


int Function ShowTurnDealt(float card, float score)
	return Gambling_Blackjack_MessageTurnDealt.Show(card, score)
EndFunction


Function ShowWinner(float score)
	Gambling_Blackjack_MessageWinNatural.Show(score)
EndFunction


Function ShowLoser(float score)
	Gambling_Blackjack_MessageBust.Show(score)
EndFunction


Function ShowKicked()
	WriteMessage("Sorry", "Your all out of caps. Better luck next time.")
EndFunction


Function PlayerBusted(Player gambler)
	WriteMessage(gambler.Name, "Loser\nScore of "+gambler.Score+" is a bust.")
EndFunction


Function DealerBusted(Player gambler, Player dealer)
	WriteMessage(gambler.Name, "Winner\nThe dealer busted with "+dealer.Score+".")
EndFunction


Function PlayersWins(Player gambler, Player dealer)
	WriteMessage(gambler.Name, "Winner\nScore of "+gambler.Score+" beats dealers "+dealer.Score+".")
EndFunction


Function PlayerLoses(Player gambler, Player dealer)
	WriteMessage(gambler.Name, "Loser\nScore of "+gambler.Score+" loses to dealers "+dealer.Score+".")
EndFunction


Function PlayerPushed(Player gambler, Player dealer)
	WriteMessage(gambler.Name, "Push\nScore of "+gambler.Score+" pushes dealers "+dealer.Score+".")
EndFunction


Function WagerPaid(Player gambler)
	WriteMessage(gambler.Name, "Bet "+gambler.Wager+" caps.")
EndFunction


Function WagerWon(Player gambler, int caps)
	WriteMessage(gambler.Name, "Won "+caps+" caps.")
EndFunction


Function WagerRefunded(Player gambler)
	WriteMessage(gambler.Name, "Refunded "+gambler.Wager+" caps.")
EndFunction


; Properties
;---------------------------------------------

Group Messages
	Message Property Gambling_Blackjack_MessageWager Auto Const Mandatory
	Message Property Gambling_Blackjack_MessageTurn Auto Const Mandatory
	Message Property Gambling_Blackjack_MessageTurnDealt Auto Const Mandatory
	Message Property Gambling_Blackjack_MessagePlay Auto Const Mandatory
	Message Property Gambling_Blackjack_MessagePlayAgain Auto Const Mandatory
	Message Property Gambling_Blackjack_MessageWin Auto Const Mandatory
	Message Property Gambling_Blackjack_MessageWinNatural Auto Const Mandatory
	Message Property Gambling_Blackjack_MessageBust Auto Const Mandatory
EndGroup
