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
	Choice = new ChoiceValue
	Marker = new MarkerValue
	Match = new MatchData
	Session = new SessionData
	Wager = new WagerValue
EndEvent


; Starting
;---------------------------------------------

State Starting
	Event Starting()
		Session = new SessionData
		Marker = new MarkerValue

		self.SetMarkers(Marker)
		self.StartBegin()

		Blackjack.Display.Text = "Joined"
		Blackjack.Display.Player(self)
	EndEvent
EndState


; Wagering
;---------------------------------------------

State Wagering
	Event Wagering()
		Cards = new Card[0]
		Match = new MatchData
		Wager = new WagerValue

		self.SetWager(Wager)
		self.WagerBegin()

		Session.Winnings -= Bet

		Blackjack.Display.Text = "Wagered a bet of "+Bet
		Blackjack.Display.Player(self)
	EndEvent


	Event SetWager(WagerValue set)
		set.Bet = 5
	EndEvent


	Function IncreaseWager(int value)
		Wager.Bet += value
		Blackjack.Display.Bet = Bet
	EndFunction


	Function DecreaseWager(int value)
		Wager.Bet -= value
		Blackjack.Display.Bet = Bet
	EndFunction
EndState


; Dealing
;---------------------------------------------

State Dealing
	Event Dealing()
		TryDraw()
		self.DealBegin()

		Blackjack.Display.Text = "Dealt a card.."
		Blackjack.Display.Player(self)
	EndEvent
EndState


; Playing
;---------------------------------------------

State Playing
	Event Playing()
		{Play the next turn until a stand.}

		bool Continue = true const
		bool Break = false const
		bool next = Continue

		While (next)
			Match.Turn += 1
			self.PlayBegin(Match.Turn)

			If (Blackjack.IsWin(Match.Score))
				Blackjack.Display.Text = "Standing with 21."
				next = Break

			ElseIf (Blackjack.IsBust(Score))
				Blackjack.Display.Text = "Busted!"
				next = Break
			Else
				Choice = new ChoiceValue
				self.SetChoice(Choice)

				If (Choice.Selected == ChoiceHit)
					If (self.TryDraw())
						Blackjack.Display.Text = "Drew a card." + Hand[Last]
						Blackjack.Display.Player(self)
						next = Continue
					Else
						WriteMessage(self, "Error, problem drawing a card! "+self.ToString())
						next = Break
					EndIf

				ElseIf (Choice.Selected == ChoiceStand)
					Blackjack.Display.Text = "Chose to stand."
					next = Break
				Else
					WriteLine(self, "Error, the play choice "+Choice.Selected+" was out of range. "+self.ToString())
					next = Break
				EndIf
			EndIf
		EndWhile

		Blackjack.Display.Player(self)
	EndEvent


	Event SetChoice(ChoiceValue set)
		If (Score <= 16)
			set.Selected = ChoiceHit
		Else
			set.Selected = ChoiceStand
		EndIf
	EndEvent
EndState


; Scoring
;---------------------------------------------

State Scoring
	Event Scoring()
		self.ScoreBegin()

		Player dealer = Blackjack.Dealer

		If (self is Players:Dealer)
			WriteLine(self, "Skipped dealer for scoring.")
		Else
			If (Blackjack.IsBust(Score))
				Blackjack.Display.Text = "Score of "+Score+" is a bust."
			Else
				If (Blackjack.IsBust(dealer.Score))
					Blackjack.Display.Text = "The dealer busted with "+dealer.Score+"."
					WinWager()
				Else
					If (Score > dealer.Score)
						Blackjack.Display.Text = "Score of "+Score+" beats dealers "+dealer.Score+"."
						WinWager()

					ElseIf (Score < dealer.Score)
						Blackjack.Display.Text = "Score of "+Score+" loses to dealers "+dealer.Score+"."

					ElseIf (Score == dealer.Score)
						Blackjack.Display.Text = "Score of "+Score+" pushes dealers "+dealer.Score+"."
						PushWager()
					Else
						; derp, i dont know what happened
						WriteLine(self, "Error, problem handling score "+Score+" against dealers "+dealer.Score+".")
					EndIf
				EndIf
			EndIf
		EndIf

		Blackjack.Display.Player(self)
	EndEvent
EndState


Function WinWager()
	int value = Bet * 2
	Session.Winnings += value

	If (self is Players:Human)
		Game.GivePlayerCaps(value)
		Blackjack.Display.Text = "Won "+value+" caps."
	EndIf
EndFunction


Function PushWager()
	Session.Winnings += Bet

	If (self is Players:Human)
		Game.GivePlayerCaps(Bet)
		Blackjack.Display.Text = "Refunded "+Bet+" caps."
	EndIf
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
					Match.Score = Blackjack.Score(self)
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
			return self.GetName() ; F4SE
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

	int Property Winnings Hidden
		int Function Get()
			return Session.Winnings
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
			return Blackjack.IsInPlay(Match.Score)
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
