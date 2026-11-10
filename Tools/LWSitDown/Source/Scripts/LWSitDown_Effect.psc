Scriptname LWSitDown_Effect extends ActiveMagicEffect
{Cast "Sit Down" at an NPC: hands them to the Living World build of Mantella (MantellaRepository), which walks
them to the seat the player pointed at (else the nearest free chair, bench or stool) and keeps them seated.
Cast at someone already sitting: they stand up.}

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Actor player = Game.GetPlayer()
	If akCaster != player || !akTarget || akTarget == player || akTarget.IsDead()
		Return
	EndIf
	Int handle = ModEvent.Create("LivingWorld_SitSpell")
	If handle
		ModEvent.PushForm(handle, akTarget)
		ModEvent.Send(handle)
	EndIf
EndEvent
