Scriptname LWCoverEyes_Arousal extends ActiveMagicEffect
{Cast "Arousal": one step up (visible, more, fully); cast when fully up to let it go down.}

LWCoverEyes_Quest Property Owner Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If akCaster != Game.GetPlayer() || !Owner
		Return
	EndIf
	Owner.ArousalStep()
EndEvent
