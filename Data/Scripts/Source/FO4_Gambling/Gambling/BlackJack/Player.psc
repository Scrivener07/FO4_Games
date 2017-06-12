ScriptName Gambling:BlackJack:Player extends Gambling:BlackJack:Component Hidden
import Gambling
import Gambling:BlackJack
import Gambling:Shared
import Gambling:Shared:Common
import Gambling:Shared:Deck


PlayData Player
SessionData Session
MarkerData Marker
Card[] Cards


Struct PlayData
	int Score = 0
	int Wager = 0
	int Turn = -1
EndStruct

Struct SessionData
	bool Abort = false
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
		Marker = GetMarkerData()
		Cards = new Deck:Card[0]
		WriteLine(self, "Has begun the starting state.")
		ReleaseThread()
	EndEvent
EndState


State Wagering
	Event OnBeginState(string asOldState)
		Player = new PlayData

		int bet = GetWager()
		If (bet > 0)
			Player.Wager = bet
			WriteLine(self, "Has chosen to wager "+bet)
		Else
			Player.Score = 0
			Session.Abort = true
			WriteLine(self, "Aborting, cannot wager "+bet)
		EndIf
		WriteLine(self, "Has begun the wagering state.")
		ReleaseThread()
	EndEvent
EndState


State Dealing
	Event OnBeginState(string asOldState)
		Draw()
		Draw()
		WriteLine(self, "Has begun the dealing state.")
		ReleaseThread()
	EndEvent
EndState


State Playing
	Event OnBeginState(string asOldState)
		BehaviorPlay()
		WriteLine(self, "Has begun the playing state.")
		ReleaseThread()
	EndEvent
EndState


; Player
;---------------------------------------------

MarkerData Function GetMarkerData()
	{Required}
	WriteMessage(self, "Error, I forgot to implement the GetMarkerData function!")
	return none
EndFunction


int Function GetWager()
	{Returns the amount of caps to wager.}
	int wagerDefault = 20 const
	WriteLine(self, "Has wagered the default of "+wagerDefault)
	return wagerDefault
EndFunction


Function Draw()
	Card value = BlackJack.Cards.Draw()
	Cards.Add(value)
	Player.Score = BlackJack.Rules.GetScore(Cards, Player.Score)

	If (value)
		If (value.Reference)
			If (Turn == 0)
				Motion.Translate(value.Reference, Marker.Card01)
			ElseIf (Turn == 1)
				Motion.Translate(value.Reference, Marker.Card02)
			ElseIf (Turn == 2)
				Motion.Translate(value.Reference, Marker.Card03)
			ElseIf (Turn == 3)
				Motion.Translate(value.Reference, Marker.Card04)
			ElseIf (Turn == 4)
				Motion.Translate(value.Reference, Marker.Card05)
			ElseIf (Turn == 5)
				Motion.Translate(value.Reference, Marker.Card06)
			ElseIf (Turn == 6)
				Motion.Translate(value.Reference, Marker.Card07)
			ElseIf (Turn == 7)
				Motion.Translate(value.Reference, Marker.Card08)
			ElseIf (Turn == 8)
				Motion.Translate(value.Reference, Marker.Card09)
			ElseIf (Turn == 9)
				Motion.Translate(value.Reference, Marker.Card10)
			ElseIf (Turn == 10)
				Motion.Translate(value.Reference, Marker.Card11)
			Else
				WriteLine(self, "The turn '"+Turn+"' is out of range.")
			EndIf
		Else
			WriteLine(self, "Cannot deal a none card reference.")
		EndIf
	Else
		WriteLine(self, "Cannot deal a none card.")
	EndIf
EndFunction


Function BehaviorPlay()
	int selected = BehaviorTurn()
	If (selected == OptionHit)
		WriteLine(self, "Has chosen to hit with "+Score)
		Draw()
		self.BehaviorPlay()
	EndIf
EndFunction


int Function BehaviorTurn()
	{Return th decision for this turn.}
	If (Player.Score <= 16)
		return OptionHit
	Else
		return OptionStand
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Object
	BlackJack:Game Property BlackJack Auto Const Mandatory
	Controllers:Motion Property Motion Auto Const Mandatory
EndGroup

Group Player
	Card[] Property Hand Hidden
		Card[] Function Get()
			return Cards
		EndFunction
	EndProperty

	int Property Turn Hidden
		int Function Get()
			{ TODO: not really the turn number}
			return Cards.Length - 1
		EndFunction
	EndProperty

	int Property Score Hidden
		int Function Get()
			return Player.Score
		EndFunction
	EndProperty

	int Property Wager Hidden
		int Function Get()
			return Player.Wager
		EndFunction
	EndProperty

	bool Property Abort Hidden
		bool Function Get()
			return Session.Abort
		EndFunction
	EndProperty
EndGroup

Group Turn
	int Property OptionHit = 0 AutoReadOnly
	int Property OptionStand = 1 AutoReadOnly
EndGroup
