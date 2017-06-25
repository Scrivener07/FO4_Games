ScriptName Gambling:Blackjack:Player extends Gambling:Blackjack:Component Hidden
import Gambling
import Gambling:Blackjack
import Gambling:Shared
import Gambling:Shared:Common
import Gambling:Shared:Deck


MatchData Match
SessionData Session
MarkerData Marker
Card[] Cards

bool Success = true const
bool Failure = false const

bool Continue = true const
bool Stay = false const


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
		Marker = CreateMarkers()

		ReleaseThread()
	EndEvent
EndState


State Wagering
	Event OnBeginState(string asOldState)
		Cards = new Card[0]
		Match = new MatchData
		Match.Wager = AskWager()

		WriteLine(self, "Has completed the wagering state "+ToString())
		ReleaseThread()
	EndEvent
EndState


State Dealing
	Event OnBeginState(string asOldState)
		TryDraw()

		WriteLine(self, "Has completed the dealing state with "+ToString())
		ReleaseThread()
	EndEvent
EndState


State Playing
	Event OnBeginState(string asOldState)
		PlayNext()

		WriteLine(self, "Has completed the playing state with "+ToString())
		ReleaseThread()
	EndEvent


	bool Function PlayNext()
		{Recursively play the next turn until a stand.}
		Match.Turn += 1

		PlayBegin()

		If (Blackjack.IsWin(Match.Score))
			WriteMessage(Name, "Standing with 21.\n"+ToString())
			return Stay

		ElseIf (Blackjack.IsBust(Score))
			WriteMessage(Name, "Busted!\n"+ToString())
			return Stay
		Else
			int choice = AskChoice()

			If (choice == ChoiceHit)
				If (TryDraw())
					WriteMessage(Name, "Drew a card.\n"+Hand[Last])
					return self.PlayNext()
				Else
					WriteMessage(Name, "Warning\nStanding, problem hitting for another card!\n"+ToString())
					return Stay
				EndIf
			ElseIf (choice == ChoiceStand)
				WriteMessage(Name, "Chose to stand.\n"+ToString())
				return Stay
			Else
				WriteMessage(Name, "Warning\nStanding, the play choice "+choice+" was out of range.\n"+ToString())
				return Stay
			EndIf
		EndIf
	EndFunction
EndState


bool Function PlayNext()
	{Private}
	return false
EndFunction


; Personality
;---------------------------------------------

MarkerData Function CreateMarkers()
	{Required - Destination markers for motion.}
	WriteMessage(self, "Error, I forgot to implement the CreateMarkers function!")
	return none
EndFunction


int Function AskWager()
	{Returns the amount of caps to wager.}
	return 20
EndFunction


Function PlayBegin()
	{What happens when a turn begins.}
EndFunction


int Function AskChoice()
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
	EndIf

	WriteMessage(Name, "Bet "+Wager+" caps.")
EndFunction


Function WinWager()
	int winAmount = Wager * 2
	Session.Winnings += winAmount
	If (self is Players:Human)
		Game.GivePlayerCaps(winAmount)
	EndIf

	WriteMessage(Name, "Won "+winAmount+" caps.")
EndFunction


Function PushWager()
	Session.Winnings += Wager
	If (self is Players:Human)
		Game.GivePlayerCaps(Wager)
	EndIf

	WriteMessage(Name, "Won "+Wager+" caps.")
EndFunction


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
	Controllers:Motion Property Motion Auto Const Mandatory
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
