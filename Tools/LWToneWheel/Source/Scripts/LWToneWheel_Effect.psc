Scriptname LWToneWheel_Effect extends ActiveMagicEffect
{A "Tone: ..." lesser power was cast: tell the Living World build of Mantella which tone the player means for the
lines they speak next. The tone is the magic effect's own name (Friendly, Polite, Flirty, Stern, Threatening,
Sarcastic, Pleading, or Neutral to go back to your own voice), so all eight powers share this one script.
MantellaRepository (OnLwToneSet) shows "Tone: ..." and passes it to the server, which compares it with how the
voice actually sounds.}

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Actor player = Game.GetPlayer()
	If akCaster != player
		Return
	EndIf
	MagicEffect fx = GetBaseObject()
	If !fx
		Return
	EndIf
	String tone = fx.GetName()
	If tone == ""
		Return
	EndIf
	player.SendModEvent("LivingWorld_ToneSet", tone)
EndEvent
