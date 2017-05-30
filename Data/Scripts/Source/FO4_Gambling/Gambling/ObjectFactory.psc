Scriptname Gambling:ObjectFactory extends Quest
import Gambling
import Gambling:Common
import Gambling:Context
import Gambling:Shared


; Functions
;---------------------------------------------

ObjectReference Function CreateID(int aFormID, string aPlugin)
	Activator Type = GetType(aFormID, aPlugin)
	return Create(Type)
EndFunction


ObjectReference Function Create(Activator aActivator)
	ObjectReference reference = Anchor.PlaceAtMe(aActivator)
	return reference
EndFunction


Function Dispose(ObjectReference aReference)
	If (aReference)
		WriteLine(self, "Disposing of "+aReference)
		aReference.Disable()
		aReference.Delete()
	Else
		WriteLine(self, "There is no reference to dispose.")
	EndIf
EndFunction


; Globals
;---------------------------------------------

ObjectFactory Function GetFactory() Global
	return Game.GetFormFromFile(0x0000271B, GetPlugin()) as ObjectFactory
EndFunction


Activator Function GetType(int aFormID, string aPlugin) Global
	return Game.GetFormFromFile(aFormID, aPlugin) as Activator
EndFunction


; Types
;---------------------------------------------

Cards:Deck Function NewDeck(Cards:Shoe owner)
	Cards:Deck value = CreateID(0x00003659, GetPlugin()) as Cards:Deck
	value.Initialize(owner)
	return value
EndFunction


Cards:Shuffler Function NewShuffler(Cards:Shoe owner)
	Cards:Shuffler value = CreateID(0x00003E0F, GetPlugin()) as Cards:Shuffler
	value.Initialize(owner)
	return value
EndFunction


; Properties
;---------------------------------------------

Group Properties
	ObjectReference Property Anchor Auto Const Mandatory
EndGroup
