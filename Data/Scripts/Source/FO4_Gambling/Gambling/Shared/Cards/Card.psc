ScriptName Gambling:Shared:Cards:Card extends ObjectReference
import Gambling:Common
import Gambling:Shared


Data instance
CustomEvent Drawn


Struct Data
	int Suit = -1
	int Rank = -1
	int Order = -1
	bool Drawn = false
	ObjectReference Reference
EndStruct


; Events
;---------------------------------------------

Event OnInit()
	instance = new Data
EndEvent


Function Initialize(Data aData)
	instance = aData
	instance.Reference = self
	WriteLine(self, "Initialized:"+aData)
EndFunction




Event Gambling:Shared:Cards:Shoe.ShuffleRequest(Cards:Shoe akSender, var[] arguments)
	instance.Order = akSender.Shuffler.NextShuffle()
	WriteLine(self, "[Shuffle] Order:"+Order)
EndEvent



Event Gambling:Shared:Cards:Shoe.DrawRequest(Cards:Shoe akSender, var[] arguments)
	If (arguments[0] as int == Order)
		WriteLine(self, "[Draw] Order:"+Order)
		SendCustomEvent("Drawn")
	EndIf
EndEvent



; Methods
;---------------------------------------------




; Functions
;---------------------------------------------


; Properties
;---------------------------------------------

Group Required
	Cards:Deck Property Owner Auto Hidden
	{The deck that own this card.}
EndGroup


Group ReadOnly
	int Property Suit Hidden
		int Function Get()
			return instance.Suit
		EndFunction
	EndProperty

	int Property Rank Hidden
		int Function Get()
			return instance.Rank
		EndFunction
	EndProperty

	int Property Order Hidden
		int Function Get()
			return instance.Order
		EndFunction
	EndProperty

	bool Property IsDrawn Hidden
		bool Function Get()
			return instance.Drawn
		EndFunction
	EndProperty

	ObjectReference Property Reference Hidden
		ObjectReference Function Get()
			return instance.Reference
		EndFunction
	EndProperty
EndGroup
