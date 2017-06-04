ScriptName Gambling:BlackJack:Components:GUI extends Gambling:BlackJack:GameComponent
import Gambling
import Gambling:BlackJack:Game
import Gambling:Common


; TODO: report difference in win or natural win
; TODO: give feedback to player about play results


; Events
;---------------------------------------------

Event OnGameEvent(BlackJack:Game akSender, PhaseEventArgs e)
	If (e.Name == akSender.ScoringState)
		If (e.Change == akSender.Begun)
			If (BlackJack.HasHuman)
				int humanScore = BlackJack.Players.PlayerA.Score
				WriteLine(self, "Your final score is "+humanScore+".")

				If (BlackJack.IsWin(humanScore))
					Gambling_BlackJack_MessageWinNatural.Show(humanScore)
				EndIf

				If (BlackJack.IsBust(humanScore))
					Gambling_BlackJack_MessageBust.Show(humanScore)
				EndIf
			Else
				WriteLine(self, "No human to show any messages.")
			EndIf
		Else
			If (Gambling_BlackJack_MessagePlayAgain.Show() == 1)
				BlackJack.Play()
			EndIf
		EndIf
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Messages
	; Message Property Gambling_BlackJack_MessageWin Auto Const Mandatory
	Message Property Gambling_BlackJack_MessageWinNatural Auto Const Mandatory
	Message Property Gambling_BlackJack_MessageBust Auto Const Mandatory
	Message Property Gambling_BlackJack_MessagePlayAgain Auto Const Mandatory
EndGroup
