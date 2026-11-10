Scriptname LWSitDown_Quest extends Quest
{Living World "Sit Down": gives the player the spell once, so it can go on the Spell Wheel.}

Spell Property SitDown Auto

Event OnInit()
	If !IsRunning()
		Return
	EndIf
	Actor player = Game.GetPlayer()
	If SitDown && !player.HasSpell(SitDown)
		player.AddSpell(SitDown, True)
	EndIf
EndEvent
