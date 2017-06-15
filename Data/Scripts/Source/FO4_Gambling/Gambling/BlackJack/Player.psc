ScriptName Gambling:BlackJack:Player extends Gambling:BlackJack:Component Hidden
import Gambling
import Gambling:BlackJack
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
		Hit()
		Hit()

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
EndState


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


bool Function PlayNext()
	{Plays the next turn, recursive.}
	Match.Turn += 1
	PlayBegin()
	If (PlayDefault())
		return PlayProcess()
	Else
		return Ended
	EndIf
EndFunction


Function PlayBegin()
	{Virtual}
EndFunction


bool Function PlayDefault()
	{Evaluates rules.}

	If (Turn == 1)
		If (BlackJack.Rules.IsWin(Match.Score))
			WriteMessage(Name, "Won a black jack!\n"+ToString())
			return Ended
		Else
			WriteMessage(Name, "Turn "+Turn+"..\n"+ToString())
			return Continue
		EndIf
	Else
		If (BlackJack.Rules.IsWin(Match.Score))
			WriteMessage(Name, "Won!\n"+ToString())
			return Ended

		ElseIf (BlackJack.Rules.IsBust(Score))
			WriteMessage(Name, "Busted!\n"+ToString())
			return Ended

		ElseIf (BlackJack.Rules.IsInPlay(Score))
			WriteMessage(Name, "Continuing with turn "+Turn+"..\n"+ToString())
			return Continue
		Else
			WriteMessage(Name, "Ended Unexpectedly!\n"+ToString())
			return Ended
		EndIf
	EndIf
EndFunction


bool Function PlayProcess()
	{The process that occurs when play happens.}
	int choice = PlayChoice()

	If (choice == ChoiceHit)
		If (Hit())
			WriteMessage(Name, "Chose to hit for another card.\n"+ToString())
			return self.PlayNext()
		Else
			WriteLine(self, "Problem hitting for another card!")
			return Ended
		EndIf
	ElseIf (choice == ChoiceStand)
		WriteMessage(Name, "Chose to stand.\n"+ToString())
		return Ended
	Else
		WriteMessage(Name, "The play choice "+choice+" was out of range.")
		return Ended
	EndIf
EndFunction


int Function PlayChoice()
	{Returns the choice for this play.}
	If (Match.Score <= 16)
		return ChoiceHit
	Else
		return ChoiceStand
	EndIf
EndFunction


bool Function Hit()
	If (CanHit)
		Card drawn = BlackJack.Cards.Draw()
		If (drawn)
			If (drawn.Reference)
				ObjectReference turnMarker = NextMarker()
				If (turnMarker)
					Cards.Add(drawn)
					Match.Score = BlackJack.Rules.GetScore(Cards, Match.Score)
					Motion.Translate(drawn.Reference, turnMarker)
					return Success
				Else
					WriteLine(self, "Cannot hit without a marker.")
					BlackJack.Cards.Collect(drawn)
					return Failure
				EndIf
			Else
				WriteLine(self, "Cannot deal a none card reference.")
				BlackJack.Cards.Collect(drawn)
				return Failure
			EndIf
		Else
			WriteLine(self, "Cannot deal a none card.")
			return Failure
		EndIf
	Else
		WriteLine(self, "Cannot hit for another card right now.")
		return Failure
	EndIf
EndFunction


; Functions
;---------------------------------------------

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
	BlackJack:Game Property BlackJack Auto Const Mandatory
	Controllers:Motion Property Motion Auto Const Mandatory
EndGroup

Group Player
	string Property Name Hidden
		string Function Get()
			return self.GetName()
		EndFunction
	EndProperty

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

	bool Property CanHit Hidden
		bool Function Get()
			return BlackJack.Rules.IsInPlay(Match.Score)
		EndFunction
	EndProperty
EndGroup

Group Choice
	int Property ChoiceHit = 0 AutoReadOnly
	int Property ChoiceStand = 1 AutoReadOnly
EndGroup
