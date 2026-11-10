Scriptname LWCoverEyes_Quest extends Quest
{Living World "Cover Your Eyes". Gives the player the power once, and covers or uncovers the player's eyes
when it is cast: the screen fades to black (Skyrim's own FadeToBlackHoldImod), sound keeps playing. The
eyes uncover by themselves after MaxSeconds, on a second cast, or when combat starts, so nobody is left
blind. Each change is sent as the mod event LivingWorld_EyesCovered (1 covered, 0 not), which the Living
World build of Mantella turns into what the NPCs around notice.}

Spell Property CoverEyes Auto
Float Property MaxSeconds = 30.0 Auto
Int Property DarknessFormId = 0x0F756E Auto   ; FadeToBlackHoldImod, Skyrim.esm

Bool covered = False
Bool usedGameFade = False

Event OnInit()
	If !IsRunning()
		Return
	EndIf
	Actor player = Game.GetPlayer()
	If CoverEyes && !player.HasSpell(CoverEyes)
		player.AddSpell(CoverEyes, True)
	EndIf
EndEvent

Function Toggle()
	If covered
		Uncover()
	Else
		Cover()
	EndIf
EndFunction

Function Cover()
	If Game.GetPlayer().IsInCombat()
		Debug.Notification("Not in the middle of a fight.")
		Return
	EndIf
	covered = True
	ImageSpaceModifier dark = Game.GetFormFromFile(DarknessFormId, "Skyrim.esm") as ImageSpaceModifier
	If dark
		dark.ApplyCrossFade(0.4)
		usedGameFade = False
	Else
		Game.FadeOutGame(True, True, 0.0, 0.4)   ; no such modifier: Skyrim's own fade instead
		usedGameFade = True
	EndIf
	SendModEvent("LivingWorld_EyesCovered", "", 1.0)
	RegisterForSingleUpdate(1.0)
EndFunction

Function Uncover()
	covered = False
	UnregisterForUpdate()
	If usedGameFade
		Game.FadeOutGame(False, True, 0.0, 0.4)
	Else
		ImageSpaceModifier.RemoveCrossFade(0.4)
	EndIf
	SendModEvent("LivingWorld_EyesCovered", "", 0.0)
EndFunction

; Once a second while covered: give up after MaxSeconds, or at once when a fight starts.
Float coveredFor = 0.0
Event OnUpdate()
	If !covered
		coveredFor = 0.0
		Return
	EndIf
	coveredFor += 1.0
	If coveredFor >= MaxSeconds || Game.GetPlayer().IsInCombat()
		coveredFor = 0.0
		Uncover()
		Return
	EndIf
	RegisterForSingleUpdate(1.0)
EndEvent

Bool Function IsCovered()
	Return covered
EndFunction
