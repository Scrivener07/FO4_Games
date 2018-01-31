ScriptName Games:Blackjack:Player extends Games:Blackjack:PlayerType Hidden
import Games
import Games:Blackjack
import Games:Shared
import Games:Shared:Deck
import Games:Shared:Log

Card[] Cards

SessionData Session
MatchData Match

MarkerValue Marker

bool Success = true const
bool Failure = false const


; Events
;---------------------------------------------

Event OnInit()
	Cards = new Card[0]
	Match = new MatchData
	Session = new SessionData
	Marker = new MarkerValue
EndEvent


; FSM - Finite State Machine
;---------------------------------------------

State Starting
	Event Starting()
		Session = new SessionData
		Marker = IMarkers()
		WriteLine(self, "Joined")
	EndEvent
EndState


State Wagering
	Event Wagering()
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
	Event Dealing()
		TryDraw()
		WriteLine(self, "Dealt a card..")
	EndEvent
EndState


State Playing
	Event Playing()
		{Play the next turn until a stand.}
		bool Continue = true const
		bool Break = false const
		bool next = Continue

		While (next)
			Match.Turn += 1
			OnTurn(Match.Turn)

			If (Blackjack.Session.IsWin(Score))
				WriteLine(self, "Standing with 21.")
				next = Break

			ElseIf (Blackjack.Session.IsBust(Score))
				WriteLine(self, "Busted!")
				next = Break
			Else
				Match.TurnChoice = IChoice()

				If (Match.TurnChoice == ChoiceHit)
					If (TryDraw())
						WriteLine(self, "Drew a card." + Hand[Last])
						next = Continue
					Else
						WriteMessage(self, "Error, problem drawing a card! "+self.ToString())
						next = Break
					EndIf

				ElseIf (Match.TurnChoice == ChoiceStand)
					WriteLine(self, "Chose to stand.")
					next = Break
				Else
					WriteLine(self, "Error, the play choice "+Match.TurnChoice+" was out of range. "+self.ToString())
					next = Break
				EndIf
			EndIf
		EndWhile
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
	Event Scoring()
		If (self is Players:Dealer)
			WriteLine(self, "Skipped dealer for scoring.")
		Else
			Player dealer = Blackjack.Session.Dealer

			If (Blackjack.Session.IsBust(Score))
				WriteLine(self, "Score of "+Score+" is a bust.")
				OnScoreLose()
			Else
				If (Blackjack.Session.IsBust(dealer.Score))
					WriteLine(self, "The dealer busted with "+dealer.Score+".")
					OnScoreWin()
				Else
					If (Score > dealer.Score)
						WriteLine(self, "Score of "+Score+" beats dealers "+dealer.Score+".")
						OnScoreWin()
					ElseIf (Score < dealer.Score)
						WriteLine(self, "Score of "+Score+" loses to dealers "+dealer.Score+".")
						OnScoreLose()
					ElseIf (Score == dealer.Score)
						WriteLine(self, "Score of "+Score+" pushes dealers "+dealer.Score+".")
						OnScorePush()
					Else
						WriteLine(self, "Error, problem handling score "+Score+" against dealers "+dealer.Score+".")
						OnScoreError()
					EndIf
				EndIf
			EndIf
		EndIf
	EndEvent

	Event OnScoreLose()
		Session.Earnings -= Bet
		WriteLine(self, "Lost "+Bet+" caps.")
	EndEvent

	Event OnScoreWin()
		If (Score == 21 == Hand.Length == 2)
			Match.Winnings = Bet + (Bet * 1.5) as int
			Session.Earnings += Winnings
			WriteLine(self, "Won "+Winnings+" caps with a Blackjack.")
		Else
			Match.Winnings = Bet * 2
			Session.Earnings += Winnings
			WriteLine(self, "Won "+Winnings+" caps.")
		EndIf
	EndEvent

	Event OnScorePush()
		Match.Winnings = Bet
		Session.Earnings += Bet
		WriteLine(self, "Pushed "+Bet+" caps.")
	EndEvent

	Event OnScoreError()
		Match.Winnings = Bet
		Session.Earnings += Bet
		WriteLine(self, "Something unexpected happened. Refunded "+Bet+" caps.")
	EndEvent
EndState


State Exiting
	Event Exiting()
		{Exiting}
		WriteLine(self, "Leaving")
	EndEvent
EndState


; Abstract
;---------------------------------------------

Event OnTurn(int aTurn)
	WriteNotImplemented(self, "OnTurn", "Not implemented in the empty state.")
EndEvent

Event OnScoreLose()
	WriteNotImplemented(self, "OnScoreLose", "Not implemented in the empty state.")
EndEvent

Event OnScoreWin()
	WriteNotImplemented(self, "OnScoreWin", "Not implemented in the empty state.")
EndEvent

Event OnScorePush()
	WriteNotImplemented(self, "OnScorePush", "Not implemented in the empty state.")
EndEvent

Event OnScoreError()
	WriteNotImplemented(self, "OnScoreError", "Not implemented in the empty state.")
EndEvent


; Interface
;---------------------------------------------

MarkerValue Function IMarkers()
	{Required - Destination markers for motion.}
	WriteNotImplemented(self, "IMarkers", "Not implemented in the empty state.")
	return new MarkerValue
EndFunction

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


; Virtual
;---------------------------------------------

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


Function SetScore(int value)
	Match.Score = value
EndFunction


Function Rematch(bool value)
	Match.Rematch = value
EndFunction


; Functions
;---------------------------------------------

bool Function TryDraw()
	If (CanDraw)
		Card drawn = Blackjack.Cards.Draw()
		If (drawn)
			If (drawn.Reference)
				ObjectReference turnMarker = NextMarker()
				If (turnMarker)
					Cards.Add(drawn)
					SetScore(Blackjack.Session.Score(self))
					Motion.Translate(drawn.Reference, turnMarker)
					return Success
				Else
					WriteLine(Name, "Cannot draw without a marker.")
					Blackjack.Cards.Collect(drawn)
					return Failure
				EndIf
			Else
				WriteLine(Name, "Cannot draw a none card reference.")
				Blackjack.Cards.Collect(drawn)
				return Failure
			EndIf
		Else
			WriteLine(Name, "Cannot draw a none card.")
			return Failure
		EndIf
	Else
		WriteLine(Name, "Cannot draw another card right now.")
		return Failure
	EndIf
EndFunction


ObjectReference Function NextMarker()
	If (Marker)
		If (Last == Invalid)
			return Marker.Card01
		ElseIf (Last == 0)
			return Marker.Card02
		ElseIf (Last == 1)
			return Marker.Card03
		ElseIf (Last == 2)
			return Marker.Card04
		ElseIf (Last == 3)
			return Marker.Card05
		ElseIf (Last == 4)
			return Marker.Card06
		ElseIf (Last == 5)
			return Marker.Card07
		ElseIf (Last == 6)
			return Marker.Card08
		ElseIf (Last == 7)
			return Marker.Card09
		ElseIf (Last == 8)
			return Marker.Card10
		ElseIf (Last == 9)
			return Marker.Card11
		Else
			WriteLine(self, "The next marker "+Last+" is out of range.")
			return none
		EndIf
	Else
		WriteLine(self, "Cannot get a none marker.")
		return none
	EndIf
EndFunction


string Function ToString()
	return Match + " " + Session
EndFunction


; Properties
;---------------------------------------------

Group Object
	Blackjack:Game Property Blackjack Auto Const Mandatory
	Shared:Motion Property Motion Auto Const Mandatory
EndGroup

Group Player
	string Property Name Hidden
		string Function Get()
			return self.GetName()
		EndFunction
	EndProperty

	bool Property Rematch Hidden
		bool Function Get()
			return Match.Rematch
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

	int Property Winnings Hidden
		int Function Get()
			return Match.Winnings
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
EndGroup

Group Hand
	Card[] Property Hand Hidden
		Card[] Function Get()
			return Cards
		EndFunction
	EndProperty

	int Property Last Hidden
		int Function Get()
			return Cards.Length - 1
		EndFunction
	EndProperty

	bool Property CanDraw Hidden
		bool Function Get()
			return Blackjack.Session.IsInPlay(Score)
		EndFunction
	EndProperty
EndGroup
