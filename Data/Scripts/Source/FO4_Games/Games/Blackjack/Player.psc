ScriptName Games:Blackjack:Player extends Games:Blackjack:PlayerType Hidden
import Games
import Games:Blackjack
import Games:Shared
import Games:Shared:papyrus
import Games:Shared:Deck
import Games:Shared:Log


Card[] Cards
SessionData Session
MatchData Match

bool Success = true const
bool Failure = false const
int Win = 21 const


; Events
;---------------------------------------------

Event OnQuestInit()
	Cards = new Card[0]
	Match = new MatchData
	Session = new SessionData
EndEvent


; States
;---------------------------------------------

State Starting
	Event OnState()
		Session = new SessionData
		WriteLine(self, "Sitting, "+Seating)
	EndEvent
EndState


State Wagering
	Event OnState()
		Cards = new Card[0]
		Match = new MatchData
		Match.Bet = IWager()
		WriteLine(self, "Wagered a bet of "+Bet)
	EndEvent

	int Function IWager()
		return WagerMinimum
	EndFunction
EndState


State Dealing
	Event OnState()
		Blackjack.Deck.DrawFor(self)
	EndEvent

	Event OnDrawn(Card drawn, ObjectReference marker)
		Motion.Translate(drawn.Reference, marker)
		WriteLine(self, "Dealt a card." + drawn)
	EndEvent
EndState


State Playing
	Event OnState()
		{Play the next turn until a stand.}
		bool move = true const
		bool break = false const
		bool next = move
		While (next)
			Match.Turn += 1
			OnTurn(Match.Turn)
			If (IsWin(Score))
				WriteLine(self, "Standing with 21.")
				next = break
			ElseIf (IsBust(Score))
				WriteLine(self, "Busted!")
				next = break
			Else
				Match.TurnChoice = IChoice()

				If (Match.TurnChoice == ChoiceHit)
					next = Blackjack.Deck.DrawFor(self)

				ElseIf (Match.TurnChoice == ChoiceStand)
					WriteLine(self, "Chose to stand.")
					next = break

				ElseIf (Match.TurnChoice == ChoiceDouble)
					WriteMessage(self, "Double Down", "Chose to double down.")

					; double the wager  and commit to drawing one more card.
					; must be the first turn
					;/
						; Match.Double = true
						; Match.Bet *= 2
						; Hand.Draw()
						; next = break
						; WriteLine(ToString(), "Chose to double down.")
					/;

					next = Blackjack.Deck.DrawFor(self)
					next = move ; TODO: Treat double as a hit and just move on for now..
				Else
					WriteUnexpectedValue(self, "Playing.OnState", "Match.TurnChoice", "The play choice "+Match.TurnChoice+" was out of range.")
					next = break
				EndIf
			EndIf
		EndWhile
	EndEvent

	Event OnDrawn(Card drawn, ObjectReference marker)
		Motion.Translate(drawn.Reference, marker)
		WriteLine(self, "Drew a card." + drawn)
	EndEvent

	int Function IChoice()
		If (Score <= 16)
			return ChoiceHit
		Else
			return ChoiceStand
		EndIf
	EndFunction
EndState


State Scoring
	Event OnState()
		If (self is Players:Dealer)
			WriteLine(self, "Skipped dealer for scoring.")
		Else
			If (IsBust(Score))
				WriteLine(self, "Score of "+Score+" is a bust.")
				OnScoring(ScoreLose)
			Else
				If (IsBust(Blackjack.Dealer.Score))
					WriteLine(self, "The dealer busted with "+Blackjack.Dealer.Score+".")
					OnScoring(ScoreWin)
				Else
					If (Score > Blackjack.Dealer.Score)
						WriteLine(self, "Score of "+Score+" beats dealers "+Blackjack.Dealer.Score+".")
						If (HasBlackjack())
							OnScoring(ScoreBlackjack)
						Else
							OnScoring(ScoreWin)
						EndIf
					ElseIf (Score < Blackjack.Dealer.Score)
						WriteLine(self, "Score of "+Score+" loses to dealers "+Blackjack.Dealer.Score+".")
						OnScoring(ScoreLose)
					ElseIf (Score == Blackjack.Dealer.Score)
						WriteLine(self, "Score of "+Score+" pushes dealers "+Blackjack.Dealer.Score+".")
						OnScoring(ScorePush)
					Else
						WriteUnexpected(self, "Scoring.OnState", "Encountered a problem handling score "+Score+" against dealers "+Blackjack.Dealer.Score+". Refunded "+Bet+" caps.")
						OnScoring(Invalid)
					EndIf
				EndIf
			EndIf
		EndIf
	EndEvent

	Event OnScoring(int scoring)
		If (scoring == Invalid)
			Match.Debt = 0
			WriteLine(self, "No caps were won or lost.")
		ElseIf (scoring == ScorePush)
			Match.Debt = 0
			WriteLine(self, "Pushed "+Bet+" caps.")
		ElseIf (scoring == ScoreLose)
			Match.Debt = Bet
			Session.Earnings -= Debt
			WriteLine(self, "Lost "+Debt+" caps.")
		ElseIf (scoring == ScoreWin)
			Match.Debt = Bet
			Session.Earnings += Debt
			WriteLine(self, "Won "+Debt+" caps.")
		ElseIf (scoring == ScoreBlackjack)
			Match.Debt = (Bet * 1.5) as int
			Session.Earnings += Debt
			WriteLine(self, "Won "+Debt+" caps with a Blackjack.")
		Else
			WriteUnexpected(self, "OnScoring", "Scoring of "+scoring+" was unhandled.")
		EndIf
	EndEvent
EndState


State Exiting
	Event OnState()
		{Exiting}
		WriteLine(self, "Leaving")
	EndEvent
EndState


; Methods
;---------------------------------------------

Function SetScore(int value)
	{Set the players match score.}
	Match.Score = value
EndFunction


bool Function Quit()
	Session.Continue = false
	return true
EndFunction


string Function ToString()
	return Match + " " + Session
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


bool Function HasBlackjack()
	return (Score == 21 && Hand.Length == 2)
EndFunction


bool Function IsValidWager(int value)
	If (value == Match.Bet)
		return false
	ElseIf (value <= 0)
		return false
	ElseIf (value < WagerMinimum)
		return false
	ElseIf (value > WagerMaximum)
		return false
	ElseIf (value > Bank)
		return false
	Else
		return true
	EndIf
EndFunction


int Function GetBank()
	{The amount of caps the player has to gamble with.}
	return 1000
EndFunction


; Virtual
;---------------------------------------------

int Function IWager()
	{Ask the amount of caps to wager.}
	WriteNotImplemented(self, "IWager", "Not implemented in the empty state.")
	return Invalid
EndFunction

int Function IChoice()
	{Ask the choice type for this turn.}
	WriteNotImplemented(self, "IChoice", "Not implemented in the empty state.")
	return Invalid
EndFunction

Event OnDrawn(Card drawn, ObjectReference marker)
	WriteNotImplemented(self, "OnDrawn", "Not implemented in the empty state.")
EndEvent

Event OnTurn(int number)
	WriteNotImplemented(self, "OnTurn", "Not implemented in the empty state.")
EndEvent

Event OnScoring(int scoring)
	WriteNotImplemented(self, "OnScoring", "Not implemented in the empty state.")
EndEvent


; Properties
;---------------------------------------------

Group Scripts
	Blackjack:Main Property Blackjack Auto Const Mandatory
	Shared:Motion Property Motion Auto Const Mandatory
EndGroup

Group Seat
	Seat Property Seating Auto Hidden
EndGroup

Group Player
	string Property Name Hidden
		string Function Get()
			return self.GetName()
		EndFunction
	EndProperty

	int Property Turn Hidden
		int Function Get()
			return Match.Turn
		EndFunction
	EndProperty

	int Property Score Hidden
		int Function Get()
			return Match.Score
		EndFunction
	EndProperty

	int Property Bet Hidden
		int Function Get()
			return Match.Bet
		EndFunction
	EndProperty

	int Property Debt Hidden
		int Function Get()
			return Match.Debt
		EndFunction
	EndProperty

	int Property Earnings Hidden
		int Function Get()
			return Session.Earnings
		EndFunction
	EndProperty

	int Property Bank Hidden
		int Function Get()
			return GetBank()
		EndFunction
	EndProperty

	bool Property HasCaps Hidden
		bool Function Get()
			return Bank > 0
		EndFunction
	EndProperty

	bool Property Continue Hidden
		bool Function Get()
			return Session.Continue
		EndFunction
	EndProperty
EndGroup

Group Hand
	Card[] Property Hand Hidden
		Card[] Function Get()
			return Cards
		EndFunction
	EndProperty

	int Property HandSize Hidden
		int Function Get()
			return Cards.Length
		EndFunction
	EndProperty

	int Property HandLast Hidden
		int Function Get()
			return Cards.Length - 1
		EndFunction
	EndProperty

	bool Property CanDraw Hidden
		bool Function Get()
			return IsInPlay(Score)
		EndFunction
	EndProperty
EndGroup
