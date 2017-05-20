ScriptName Gambling:BlackJack:Players extends Quest
import Gambling
import Gambling:Common
import Gambling:BlackJack
import Gambling:BlackJack:Main

; TODO: player allocation
; TODO: give feedback to player about play results
; TODO: check for difference in win or natural win
; TODO: scoring for a player/dealer draw

Competitors:Seat[] Seats

int Invalid = -1 const
int OptionExit = 0 const
int OptionStart = 1 const


; Events
;---------------------------------------------

Event OnInit()
	Seats = new Competitors:Seat[0]
	RegisterForCustomEvent(BlackJack, "OnPhase")
EndEvent


Event Gambling:BlackJack:Main.OnPhase(BlackJack:Main akSender, var[] arguments)
	PhaseEventArgs e = GetPhaseEventArgs(arguments)
	If (e)
		If (e.Name == akSender.WageringState && e.Begun)
			If (PlayerA.Abort)
				If (Remove(PlayerA))
					WriteLine(self, "The player has aborted the game.")
				EndIf
			EndIf
		ElseIf (e.Name == akSender.ScoringState && e.Begun)
			WriteLine(self, "Your final score is "+PlayerA.Score+".")

			If (BlackJack.IsWin(PlayerA.Score))
				Gambling_BlackJack_MessageWinNatural.Show(PlayerA.Score)
			EndIf

			If (BlackJack.IsBust(PlayerA.Score))
				Gambling_BlackJack_MessageBust.Show(PlayerA.Score)
			EndIf
		EndIf
	Else
		WriteLine(self, "Invalid phase event arguments.")
	EndIf
EndEvent


; Methods
;---------------------------------------------

bool Function Allocate()
	int selected = Gambling_BlackJack_MessagePlay.Show()
	If (selected == OptionStart)
		Add(PlayerA)
		Add(PlayerB)
		Add(PlayerC)
		Add(PlayerD)
		Add(PlayerE)
		Add(Dealer)

		int index = 0
		While (index < Count)
			Seats[index].Startup()
			index += 1
		EndWhile
		return true
	ElseIf (selected == OptionExit || selected == Invalid)
		WriteLine(self, "Chose not to play Black Jack.")
		return false
	Else
		WriteLine(self, "The option '"+selected+"' is unhandled.")
		return false
	EndIf
EndFunction


Function Wager()
	If (Seats)
		int index = 0
		While (index < Count)
			Seats[index].Wager()
			index += 1
		EndWhile
	Else
		WriteLine(self, "There are no seats to wager.")
	EndIf
EndFunction


Function Deal(Gambling:Deck deck)
	If (Seats)
		int index = 0
		While (index < Count)
			Seats[index].Deal(deck.Draw())
			Seats[index].Deal(deck.Draw())
			index += 1
		EndWhile
	Else
		WriteLine(self, "There are no seats to deal.")
	EndIf
EndFunction


Function Play()
	If (Seats)
		int index = 0
		While (index < Count)
			Seats[index].Play()
			index += 1
		EndWhile
	Else
		WriteLine(self, "There are no seats to play.")
	EndIf
EndFunction


Function Deallocate()
	If (Seats)
		int index = 0
		While (index < Count)
			Seats[index].Shutdown()
			index += 1
		EndWhile

		Clear()
	Else
		WriteLine(self, "There are no seats to deallocate.")
	EndIf
EndFunction


; Functions
;---------------------------------------------

bool Function Remove(Competitors:Seat seat)
	int index = Seats.Find(seat)
	If (index > -1)
		Seats.Remove(index)
		return true
	Else
		WriteLine(self, "Could not find player '"+seat+"' for abort.")
		return false
	EndIf
EndFunction


bool Function Add(Competitors:Seat seat)
	If (seat)
		Seats.Add(seat)
		return true
	Else
		WriteLine(self, "Cannot register a none seat.")
		return false
	EndIf
EndFunction


Function Clear()
	If (Seats)
		Seats.Clear()
	Else
		WriteLine(self, "The seats are empty or none.")
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	BlackJack:Main Property BlackJack Auto Const Mandatory
	Competitors:Dealer Property Dealer Auto Const Mandatory
	Competitors:PlayerA Property PlayerA Auto Const Mandatory
	Competitors:PlayerB Property PlayerB Auto Const Mandatory
	Competitors:PlayerC Property PlayerC Auto Const Mandatory
	Competitors:PlayerD Property PlayerD Auto Const Mandatory
	Competitors:PlayerE Property PlayerE Auto Const Mandatory

	Message Property Gambling_BlackJack_MessagePlay Auto Const Mandatory
	Message Property Gambling_BlackJack_MessageBust Auto Const Mandatory
	Message Property Gambling_BlackJack_MessageWin Auto Const Mandatory
	Message Property Gambling_BlackJack_MessageWinNatural Auto Const Mandatory
EndGroup

Group ReadOnly
	bool Property Count Hidden
		bool Function Get()
			return Seats.Length
		EndFunction
	EndProperty

	bool Property HasHuman Hidden
		bool Function Get()
			return Seats.Find(PlayerA) > -1
		EndFunction
	EndProperty
EndGroup
