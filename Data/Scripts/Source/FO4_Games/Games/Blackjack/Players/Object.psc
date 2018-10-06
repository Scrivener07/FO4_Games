ScriptName Games:Blackjack:Players:Object extends Games:Blackjack:Players:ObjectType Hidden
import Games
import Games:Shared:Log
import Games:Shared:Papyrus


SessionData Session
MatchData Match


; Events
;---------------------------------------------

Event OnQuestInit()
	Hand.Create()
	Match = new MatchData
	Session = new SessionData
EndEvent


; States
;---------------------------------------------

State Starting
	Event OnState()
		OnQuestInit()
		Session = new SessionData
		WriteLine(ToString(), "Sitting")
	EndEvent
EndState


State Wagering
	Event OnState()
		Hand.Create()
		Match = new MatchData
		IntegerValue setter = new IntegerValue
		WagerSet(setter)
		Match.Bet = setter.Value
		WriteLine(ToString(), "Wagered a bet of "+Bet)
	EndEvent

	Function WagerSet(IntegerValue setter)
		{The default wager setter.}
		setter.Value = WagerMinimum
	EndFunction
EndState


State Dealing
	Event OnState()
		If (Hand.Draw())
			WriteLine(ToString(), "Dealt a card." + Hand.Drawn)
		EndIf
	EndEvent
EndState


State Playing
	Event OnState()
		{Play the turn until a continue is false.}
		BooleanValue continue = new BooleanValue
		continue.Value = true
		While (continue.Value)
			Match.Turn += 1
			OnTurn(continue)
		EndWhile
	EndEvent

	Event OnTurn(BooleanValue continue)
		{The default turn behavior.}
		If (Hand.IsWin)
			continue.Value = false
			WriteLine(ToString(), "Standing with 21.")
		ElseIf (Hand.IsBust)
			continue.Value = false
			WriteLine(ToString(), "Busted with "+Hand.Score)
		Else
			IntegerValue setter = new IntegerValue
			ChoiceSet(setter)
			Match.Choice = setter.Value

			If (Match.Choice == ChoiceHit)
				Hand.Draw()
				continue.Value = true
				WriteLine(ToString(), "Chose to hit.")
			ElseIf (Match.Choice == ChoiceStand)
				continue.Value = false
				WriteLine(ToString(), "Chose to stand.")
			ElseIf (Match.Choice == ChoiceDouble)
				Match.Bet *= 2
				Hand.Draw()
				continue.Value = false
				WriteLine(ToString(), "Chose to double down.")
			Else
				continue.Value = false
				WriteUnexpectedValue(ToString(), "Playing.OnTurn", "Match.Choice", "The play choice "+Match.Choice+" was out of range.")
			EndIf
		EndIf
	EndEvent

	Function ChoiceSet(IntegerValue setter)
		{The default choice setter.}
		If (Score <= 16)
			setter.Value = ChoiceHit
		Else
			setter.Value = ChoiceStand
		EndIf
	EndFunction
EndState


State Scoring
	Event OnState()
		If (Hand.IsBust)
			WriteLine(ToString(), "Score of "+Score+" is a bust.")
			OnScoring(ScoreLose)
		Else
			If (Blackjack.Dealer.Hand.IsBust)
				WriteLine(ToString(), "The dealer busted with "+Blackjack.Dealer.Score+".")
				OnScoring(ScoreWin)
			Else
				If (Score > Blackjack.Dealer.Score)
					WriteLine(ToString(), "Score of "+Score+" beats dealers "+Blackjack.Dealer.Score+".")
					If (Hand.IsBlackjack)
						OnScoring(ScoreBlackjack)
					Else
						OnScoring(ScoreWin)
					EndIf
				ElseIf (Score < Blackjack.Dealer.Score)
					WriteLine(ToString(), "Score of "+Score+" loses to dealers "+Blackjack.Dealer.Score+".")
					OnScoring(ScoreLose)
				ElseIf (Score == Blackjack.Dealer.Score)
					WriteLine(ToString(), "Score of "+Score+" pushes dealers "+Blackjack.Dealer.Score+".")
					OnScoring(ScorePush)
				Else
					WriteUnexpected(ToString(), "Scoring.OnState", "Encountered a problem handling score "+Score+" against dealers "+Blackjack.Dealer.Score+". Refunded "+Bet+" caps.")
					OnScoring(Invalid)
				EndIf
			EndIf
		EndIf
	EndEvent

	Event OnScoring(int scoring)
		If (scoring == Invalid)
			Match.Debt = 0
			WriteLine(ToString(), "No caps were won or lost.")
		ElseIf (scoring == ScorePush)
			Match.Debt = 0
			WriteLine(ToString(), "Pushed "+Bet+" caps.")
		ElseIf (scoring == ScoreLose)
			Match.Debt = Bet
			Session.Earnings -= Debt
			WriteLine(ToString(), "Lost "+Debt+" caps.")
		ElseIf (scoring == ScoreWin)
			Match.Debt = Bet
			Session.Earnings += Debt
			WriteLine(ToString(), "Won "+Debt+" caps.")
		ElseIf (scoring == ScoreBlackjack)
			Match.Debt = (Bet * 1.5) as int
			Session.Earnings += Debt
			WriteLine(ToString(), "Won "+Debt+" caps with a Blackjack.")
		Else
			WriteUnexpected(ToString(), "OnScoring", "Scoring of "+scoring+" was unhandled.")
		EndIf
	EndEvent
EndState


State Exiting
	Event OnState()
		{Exiting}
		WriteLine(ToString(), "Leaving")
	EndEvent
EndState


; Methods
;---------------------------------------------

bool Function Quit()
	Session.Quit = true
	return Session.Quit
EndFunction


bool Function IsValidWager(int value)
	{Returns true if the value is a valid wager.}
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


string Function ToString()
	{The string representation of this script.}
	return parent.ToString()+" "+Name+" "+Match+" "+Session
EndFunction


; Virtual
;---------------------------------------------

Event OnTurn(BooleanValue continue)
	WriteNotImplemented(ToString(), "OnTurn", "Not implemented in the empty state.")
EndEvent

Event OnScoring(int scoring)
	WriteNotImplemented(ToString(), "OnScoring", "Not implemented in the empty state.")
EndEvent

Function WagerSet(IntegerValue setter)
	{Set the amount of caps to wager.}
	setter.Value = Invalid
	WriteNotImplemented(ToString(), "WagerSet", "Not implemented in the empty state. Setting to invalid.")
EndFunction

Function ChoiceSet(IntegerValue setter)
	{Set the choice type for this turn.}
	setter.Value = Invalid
	WriteNotImplemented(ToString(), "ChoiceSet", "Not implemented in the empty state. Setting to invalid.")
EndFunction


; Properties
;---------------------------------------------

Group Scripts
	Blackjack:Main Property Blackjack Auto Const Mandatory
	Blackjack:Players:Hand Property Hand Auto Const Mandatory
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
			return Hand.Score
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

	bool Property Quit Hidden
		bool Function Get()
			return Session.Quit
		EndFunction
	EndProperty
EndGroup
