Scriptname PWKit_Quest extends Quest
{Plains Wardens "Warden Kit": gives the player the spell once, so it can go on the Spell Wheel.}

Spell Property WardenKit Auto

Event OnInit()
	If !IsRunning()
		Return
	EndIf
	Actor player = Game.GetPlayer()
	If WardenKit && !player.HasSpell(WardenKit)
		player.AddSpell(WardenKit, True)
	EndIf
EndEvent
