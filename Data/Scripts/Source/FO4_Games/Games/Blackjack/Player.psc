ScriptName Games:Blackjack:Player extends Games:Blackjack:Component Hidden
import Games
import Games:Blackjack
import Games:Shared
import Games:Shared:Common
import Games:Shared:Deck


MatchData Match
SessionData Session
MarkerData Marker
Card[] Cards

bool Success = true const
bool Failure = false const

Struct MatchData
	int Turn = 0
	int Score = 0
	int Wager = 0
EndStruct

Struct SessionData
	int Winnings = 0
EndStruct

Struct MarkerData
	ObjectReference Card01
	ObjectReference Card02
	ObjectReference Card03
	ObjectReference Card04
	ObjectReference Card05
	ObjectReference Card06
	ObjectReference Card07
	ObjectReference Card08
	ObjectReference Card09
	ObjectReference Card10
	ObjectReference Card11
EndStruct


; Component
;---------------------------------------------

State Starting
	Event OnBeginState(string asOldState)
		Session = new SessionData
		Marker = GetMarkers()

		Blackjack.HUD.Text = "Joined"
		Blackjack.HUD.Update(self)

		ReleaseThread()
	EndEvent
EndState


State Wagering
	Event OnBeginState(string asOldState)
		Cards = new Card[0]
		Match = new MatchData
		Match.Wager = GetWager()

		PayWager()

		If (Wager != Invalid)
			Blackjack.HUD.Text = "Wagered a bet of "+Wager
			Blackjack.HUD.Update(self)
		EndIf

		ReleaseThread()
	EndEvent
EndState


State Dealing
	Event OnBeginState(string asOldState)
		TryDraw()

		Blackjack.HUD.Text = "Dealt a card.."
		Blackjack.HUD.Update(self)

		ReleaseThread()
	EndEvent
EndState


State Playing
	Event OnBeginState(string asOldState)
		{Play the next turn until a stand.}
		bool Continue = true const
		bool Break = false const

		bool next = Continue
		While (next)
			Match.Turn += 1

			self.PlayBegin()

			If (Blackjack.IsWin(Match.Score))
				Blackjack.HUD.Text = "Standing with 21."
				next = Break

			ElseIf (Blackjack.IsBust(Score))
				Blackjack.HUD.Text = "Busted!"
				next = Break
			Else
				int choice = self.GetPlay()

				If (choice == ChoiceHit)
					If (self.TryDraw())
						Blackjack.HUD.Text = "Drew a card." + Hand[Last]
						Blackjack.HUD.Update(self)
						next = Continue
					Else
						WriteLine(self, "Error, problem hitting for another card. "+self.ToString())
						next = Break
					EndIf
				ElseIf (choice == ChoiceStand)
					Blackjack.HUD.Text = "Chose to stand."
					next = Break
				Else
					WriteLine(self, "Error, the play choice "+choice+" was out of range. "+self.ToString())
					next = Break
				EndIf
			EndIf
		EndWhile

		Blackjack.HUD.Update(self)

		ReleaseThread()
	EndEvent
EndState


; Player
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


; Virtual
;---------------------------------------------

int Function GetBank()
	{The amount of caps the player has to play with.}
	return 1000
EndFunction


MarkerData Function GetMarkers()
	{Required - Destination markers for motion.}
	WriteMessage(self, "Error, I forgot to implement the GetMarkers function!")
	return none
EndFunction


int Function GetWager()
	{Returns the amount of caps to wager.}
	return 5
EndFunction


Function PlayBegin()
	{What happens when a turn begins.}
EndFunction


int Function GetPlay()
	{Returns the choice for this play.}
	If (Match.Score <= 16)
		return ChoiceHit
	Else
		return ChoiceStand
	EndIf
EndFunction


; Functions
;---------------------------------------------

Function PayWager()
	Session.Winnings -= Wager

	If (self is Players:Human)
		Game.RemovePlayerCaps(Wager)
		Blackjack.HUD.Text = "Bet "+Wager+" caps."
	EndIf
EndFunction


Function WinWager()
	int value = Wager * 2
	Session.Winnings += value

	If (self is Players:Human)
		Game.GivePlayerCaps(value)
		Blackjack.HUD.Text = "Won "+value+" caps."
	EndIf
EndFunction


Function PushWager()
	Session.Winnings += Wager

	If (self is Players:Human)
		Game.GivePlayerCaps(Wager)
		Blackjack.HUD.Text = "Refunded "+Wager+" caps."
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
	Controllers:Motion Property Motion Auto Const Mandatory
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

	int Property Wager Hidden
		int Function Get()
			return Match.Wager
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

Group Choice
	int Property ChoiceHit = 0 AutoReadOnly
	int Property ChoiceStand = 1 AutoReadOnly
EndGroup
