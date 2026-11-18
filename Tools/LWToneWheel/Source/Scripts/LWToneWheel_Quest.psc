Scriptname LWToneWheel_Quest extends Quest
{Living World tone wheel: gives the player the eight "Tone: ..." lesser powers once, so they can go on the Spell
Wheel. Casting one picks the tone of voice the player means; NPCs judge it against how the voice really sounds.}

Spell Property ToneFriendly Auto
Spell Property TonePolite Auto
Spell Property ToneFlirty Auto
Spell Property ToneStern Auto
Spell Property ToneThreatening Auto
Spell Property ToneSarcastic Auto
Spell Property TonePleading Auto
Spell Property ToneNeutral Auto

Event OnInit()
	If !IsRunning()
		Return
	EndIf
	Give(ToneFriendly)
	Give(TonePolite)
	Give(ToneFlirty)
	Give(ToneStern)
	Give(ToneThreatening)
	Give(ToneSarcastic)
	Give(TonePleading)
	Give(ToneNeutral)
EndEvent

Function Give(Spell power)
	Actor player = Game.GetPlayer()
	If power && !player.HasSpell(power)
		player.AddSpell(power, False)
	EndIf
EndFunction
