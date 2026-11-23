# PlainsWardensKit

One spell, **Warden Kit** (Alteration, no magicka, given to the player automatically; put it on the Spell Wheel).
Cast it at an NPC: they get and put on the Plains Warden Armor (Whiterun guard look), Warden's Boots,
Warden's Gauntlets and the Plains Warden Shield from PlainsWardensArmory.esp. No helmet. Not on children or the dead. The target is not angered.

The armour is looked up at cast time with `Game.GetFormFromFile` (0x813 cuirass, 0x80F boots, 0x811 gauntlets, 0x817 shield),
so the plugin's only master is Skyrim.esm. Without PlainsWardensArmory.esp loaded it shows a notice and does nothing.
Vanilla may put an NPC back in their default outfit after a cell change or reload.

Console alternative (no plugin): click the NPC, `bat wardenkit` (file in the game folder).

Build on the play PC: `powershell -ExecutionPolicy Bypass -File build.ps1` (Spriggit + Papyrus Compiler, same tools
as LWSitDown). The zip lands in `Dist\`.
