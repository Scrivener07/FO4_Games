ScriptName Games:Blackjack:Player extends Games:Blackjack:PlayerType Hidden
import Games
import Games:Blackjack
import Games:Papyrus:Log
import Games:Shared
import Games:Shared:Deck

Card[] Cards

SessionData Session
MatchData Match

MarkerValue Marker
WagerValue Wager
ChoiceValue Choice

bool Success = true const
bool Failure = false const


; Events
;---------------------------------------------

Event OnInit()
	Cards = new Card[0]
	Match = new MatchData
	Session = new SessionData
	Marker = new MarkerValue
	Wager = new WagerValue
	Choice = new ChoiceValue
EndEvent


; FSM - Finite State Machine
;---------------------------------------------

State Starting
	Event Starting()
		Session = new SessionData
		Marker = new MarkerValue
		self.SetMarkers(Marker)
		WriteLine(self, "Joined")
	EndEvent
EndState


State Wagering
	Event Wagering()
		Cards = new Card[0]
		Match = new MatchData
		Wager = new WagerValue

		self.SetWager(Wager)
		Session.Earnings -= Bet
		WriteLine(self, "Wagered a bet of "+Bet)
	EndEvent

	Event SetWager(WagerValue set)
		set.Bet = 5
	EndEvent

	Function IncreaseWager(int value)
		Wager.Bet += value
	EndFunction

	Function DecreaseWager(int value)
		Wager.Bet -= value
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
			self.PlayTurn(Match.Turn)

			If (Blackjack.Session.IsWin(Score))
				WriteLine(self, "Standing with 21.")
				next = Break

			ElseIf (Blackjack.Session.IsBust(Score))
				WriteLine(self, "Busted!")
				next = Break
			Else
				Choice = new ChoiceValue
				self.SetChoice(Choice)

				If (Choice.Selected == ChoiceHit)
					If (self.TryDraw())
						WriteLine(self, "Drew a card." + Hand[Last])
						next = Continue
					Else
						WriteMessage(self, "Error, problem drawing a card! "+self.ToString())
						next = Break
					EndIf

				ElseIf (Choice.Selected == ChoiceStand)
					WriteLine(self, "Chose to stand.")
					next = Break
				Else
					WriteLine(self, "Error, the play choice "+Choice.Selected+" was out of range. "+self.ToString())
					next = Break
				EndIf
			EndIf
		EndWhile
	EndEvent

	Event SetChoice(ChoiceValue set)
		If (Score <= 16)
			set.Selected = ChoiceHit
		Else
			set.Selected = ChoiceStand
		EndIf
	EndEvent
EndState


State Scoring
	Event Scoring()
		If (self is Players:Dealer)
			WriteLine(self, "Skipped dealer for scoring.")
		Else
			Player dealer = Blackjack.Session.Dealer

			If (Blackjack.Session.IsBust(Score))
				WriteLine(self, "Score of "+Score+" is a bust.")
				OnScore(ScoreLose)
			Else
				If (Blackjack.Session.IsBust(dealer.Score))
					WriteLine(self, "The dealer busted with "+dealer.Score+".")
					OnScore(ScoreWin)
				Else
					If (Score > dealer.Score)
						WriteLine(self, "Score of "+Score+" beats dealers "+dealer.Score+".")
						OnScore(ScoreWin)
					ElseIf (Score < dealer.Score)
						WriteLine(self, "Score of "+Score+" loses to dealers "+dealer.Score+".")
						OnScore(ScoreLose)
					ElseIf (Score == dealer.Score)
						WriteLine(self, "Score of "+Score+" pushes dealers "+dealer.Score+".")
						OnScore(ScorePush)
					Else
						WriteLine(self, "Error, problem handling score "+Score+" against dealers "+dealer.Score+".")
						OnScore(Invalid)
					EndIf
				EndIf
			EndIf
		EndIf
	EndEvent

	Event OnScore(int scoring)
		If (scoring == ScoreLose)
			DecreaseEarnings(Bet)
			WriteLine(self, "Lost "+Bet+" caps.")
		ElseIf (scoring == ScoreWin)
			int value = Bet * 2
			IncreaseEarnings(value)
			WriteLine(self, "Won "+value+" caps.")
		ElseIf (scoring == ScorePush)
			IncreaseEarnings(Bet)
			WriteLine(self, "Pushed "+Bet+" caps.")
		ElseIf (scoring == Invalid)
			IncreaseEarnings(Bet)
			WriteLine(self, "Something unexpected happened. Refunded "+Bet+" caps.")
		Else
			IncreaseEarnings(Bet)
			WriteLine(self, "The parameter 'OnScore.scoring' is out of range. Refunded "+Bet+" caps.")
		EndIf
	EndEvent

	Function IncreaseEarnings(int value)
		Session.Earnings += value
	EndFunction

	Function DecreaseEarnings(int value)
		Session.Earnings -= value
	EndFunction

	Function SessionRematch(bool value)
		Session.Rematch = value
	EndFunction
EndState


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


Function SetScore(int value)
	Match.Score = value
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
			return Wager.Bet
		EndFunction
	EndProperty

	int Property Earnings Hidden
		int Function Get()
			return Session.Earnings
		EndFunction
	EndProperty

	int Property Caps Hidden
		int Function Get()
			return GetBank()
		EndFunction
	EndProperty

	bool Property HasCaps Hidden
		bool Function Get()
			return Caps > 0
		EndFunction
	EndProperty

	bool Property CanDraw Hidden
		bool Function Get()
			return Blackjack.Session.IsInPlay(Score)
		EndFunction
	EndProperty

	bool Property Rematch Hidden
		bool Function Get()
			return Session.Rematch
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
EndGroup
