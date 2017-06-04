ScriptName Gambling:BlackJack:Components:Players extends Gambling:BlackJack:GameComponent
import Gambling
import Gambling:BlackJack
import Gambling:Common
import Gambling:Shared

; TODO: player allocation
; TODO: scoring for a player/dealer draw

Competitors:Seat[] Seats

int Invalid = -1 const
int OptionExit = 0 const
int OptionStart = 1 const


; Events
;---------------------------------------------

Event OnInitialize()
	Seats = new Competitors:Seat[0]
EndEvent


Event OnGamePhase(PhaseEventArgs e)
	If (e.Name == WageringPhase && e.Change == Ended)
		If (Human.Abort)
			If (Remove(Human))
				WriteLine(self, "The player has aborted the game.")
			EndIf
		EndIf
	EndIf
EndEvent


; Methods
;---------------------------------------------

bool Function Allocate()
	int selected = Gambling_BlackJack_MessagePlay.Show()

	If (selected == OptionStart)

		Add(Human)
		Add(PlayerB)
		Add(PlayerC)
		Add(PlayerD)
		Add(PlayerE)
		Add(Dealer)

		Startup()

		return true
	ElseIf (selected == OptionExit || selected == Invalid)
		WriteLine(self, "Chose not to play Black Jack.")
		return false
	Else
		WriteLine(self, "The option '"+selected+"' is unhandled.")
		return false
	EndIf
EndFunction


Function Startup()
	If (Seats)
		int index = 0
		While (index < Count)
			Seats[index].Startup()
			index += 1
		EndWhile
	Else
		WriteLine(self, "There are no seats to startup.")
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


Function Deal(Shared:Deck deck)
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

int Function IndexOf(Competitors:Seat seat)
	{Determines the index of a specific seat in the collection.}
	If (seat)
		return Seats.Find(seat)
	Else
		return Invalid
	EndIf
EndFunction


bool Function Contains(Competitors:Seat seat)
	{Determines whether a seat is in the collection.}
	return IndexOf(seat) > Invalid
EndFunction


bool Function Remove(Competitors:Seat seat)
	{Removes a seat from the collection.}
	int index = IndexOf(seat)

	If (index > Invalid)
		Seats.Remove(index)
		return true
	Else
		WriteLine(self, "Could not find player '"+seat+"' for abort.")
		return false
	EndIf
EndFunction


bool Function Add(Competitors:Seat seat)
	{Adds a seat to the collection.}
	If (seat)
		If (Contains(seat) == false)
			Seats.Add(seat)
			return true
		Else
			WriteLine(self, "The seats already contain the '"+seat+"' player.")
			return false
		EndIf
	Else
		WriteLine(self, "Cannot add a none seat.")
		return false
	EndIf
EndFunction


Function Clear()
	{Removes all seats from the collection.}
	If (Seats)
		Seats.Clear()
	Else
		WriteLine(self, "The seats are empty or none.")
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	Message Property Gambling_BlackJack_MessagePlay Auto Const Mandatory
EndGroup

Group Competitors
	Competitors:Dealer Property Dealer Auto Const Mandatory
	Competitors:Human Property Human Auto Const Mandatory
	Competitors:PlayerB Property PlayerB Auto Const Mandatory
	Competitors:PlayerC Property PlayerC Auto Const Mandatory
	Competitors:PlayerD Property PlayerD Auto Const Mandatory
	Competitors:PlayerE Property PlayerE Auto Const Mandatory
EndGroup

Group ReadOnly
	int Property Count Hidden
		int Function Get()
			return Seats.Length
		EndFunction
	EndProperty
EndGroup
