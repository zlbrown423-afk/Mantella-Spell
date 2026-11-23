Scriptname PWKit_Effect extends ActiveMagicEffect
{Plains Wardens "Warden Kit": the NPC you cast it at gets the Plains Warden Armor (Whiterun guard look),
Warden's Boots, Warden's Gauntlets and the Plains Warden Shield and puts them on. No helmet. Items come from PlainsWardensArmory.esp,
looked up at cast time so this plugin needs no master but Skyrim.esm.}

Armor Function Piece(Int id)
	Return Game.GetFormFromFile(id, "PlainsWardensArmory.esp") as Armor
EndFunction

Function Wear(Actor who, Armor item)
	If !item
		Return
	EndIf
	If who.GetItemCount(item) < 1
		who.AddItem(item, 1, True)
	EndIf
	who.EquipItem(item, False, True)
EndFunction

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If !akTarget || akTarget.IsDead() || akTarget.IsChild()
		Return
	EndIf
	Armor cuirass = Piece(0x813)
	If !cuirass
		Debug.Notification("Warden Kit: PlainsWardensArmory.esp is not loaded")
		Return
	EndIf
	Wear(akTarget, cuirass)
	Wear(akTarget, Piece(0x80F))
	Wear(akTarget, Piece(0x811))
	Wear(akTarget, Piece(0x817)) ; shield (an NPC holding a two-handed weapon or bow will not show it)
	Debug.Notification(akTarget.GetDisplayName() + " is wearing Warden colours")
EndEvent
