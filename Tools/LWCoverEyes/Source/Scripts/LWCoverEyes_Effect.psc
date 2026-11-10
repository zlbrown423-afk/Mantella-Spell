Scriptname LWCoverEyes_Effect extends ActiveMagicEffect
{Cast "Cover Your Eyes": covers the player's eyes, or uncovers them when they are covered.}

LWCoverEyes_Quest Property Owner Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If akCaster != Game.GetPlayer() || !Owner
		Return
	EndIf
	Owner.Toggle()
EndEvent
