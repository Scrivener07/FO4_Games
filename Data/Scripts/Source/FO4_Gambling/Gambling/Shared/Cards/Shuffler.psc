ScriptName Gambling:Shared:Cards:Shuffler extends ObjectReference
{0x00003E0F}
import Gambling:Shared


Cards:Shoe Owner


int Last
; The total amount of cards to consider shuffling

int Shuffle
; The next order in the shuffle

int Draw
; The current position of the top of the deck


; Constructor
;---------------------------------------------

Function Initialize(Cards:Shoe aOwner)
	Owner = aOwner
	Last = 0
	Shuffle = 0
	Draw = 0
EndFunction


; Functions
;---------------------------------------------

Function Calculate()
	int iRange = Owner.GetCount()
	Shuffle = 0
	Draw = iRange
	Last = iRange
EndFunction


int Function NextShuffle()
	Shuffle += 1
	return Shuffle
EndFunction


int Function NextDraw()
	int value = Draw
	Draw -= 1
	return value
EndFunction


; Properties
;---------------------------------------------

Group ReadOnly
	int Property Top Hidden
		{The top most card in the shuffle}
		int Function Get()
			return Draw
		EndFunction
	EndProperty
EndGroup
