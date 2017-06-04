ScriptName Gambling:BlackJack:Components:GUI extends Gambling:BlackJack:GameComponent
import Gambling
import Gambling:Common


int Invalid = -1 const
int OptionExit = 0 const
int OptionStart = 1 const


; Events
;---------------------------------------------

Event OnGamePhase(PhaseEventArgs e)
	If (e.Name == ScoringPhase)
		If !(BlackJack.HasHuman)
			WriteLine(self, "No human, ignoring messages.")
			return
		EndIf

		If (e.Change == Begun)
			int humanScore = BlackJack.Players.Human.Score
			WriteLine(self, "Your final score is "+humanScore+".")

			If (BlackJack.IsWin(humanScore))
				Gambling_BlackJack_MessageWinNatural.Show(humanScore)
			EndIf

			If (BlackJack.IsBust(humanScore))
				Gambling_BlackJack_MessageBust.Show(humanScore)
			EndIf
		Else
			If (Gambling_BlackJack_MessagePlayAgain.Show() == 1)
				BlackJack.Play(none)
			EndIf
		EndIf
	EndIf
EndEvent



bool Function PromptPlay()
	int selected = Gambling_BlackJack_MessagePlay.Show()

	If (selected == OptionStart)
		return true

	ElseIf (selected == OptionExit || selected == Invalid)
		WriteLine(self, "Chose not to play Black Jack.")
		return false
	Else
		WriteLine(self, "The option '"+selected+"' is unhandled.")
		return false
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Messages
	Message Property Gambling_BlackJack_MessagePlay Auto Const Mandatory
	; Message Property Gambling_BlackJack_MessageWin Auto Const Mandatory
	Message Property Gambling_BlackJack_MessageWinNatural Auto Const Mandatory
	Message Property Gambling_BlackJack_MessageBust Auto Const Mandatory
	Message Property Gambling_BlackJack_MessagePlayAgain Auto Const Mandatory
EndGroup
