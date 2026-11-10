# LWSitDown

A tiny companion plugin for the Living World build of Mantella: one spell, **Sit Down** (Alteration,
no magicka), given to the player automatically. Put it on the Spell Wheel and cast it from either hand.

* Point at a chair, bench or stool, then cast at the NPC: they walk over and sit in it.
* Cast at the NPC without pointing at a seat first: they take the nearest free chair, bench or stool
  (about 35 m around).
* Cast at someone who is already sitting: they stand up.
* They stay seated like after a spoken "sit down" order (Living World sits them back down for three
  minutes if their AI pulls them up), and a running conversation hears "... sat down on the Chair".
* Not in a fight, not on children. The target is not angered.

The spell only sends the mod event `LivingWorld_SitSpell` (the target actor); the walking and sitting is
done by `MantellaRepository` (Mantella-Spell), the same code as the spoken Sit action. So it needs the
Living World build of Mantella that has `OnLwSitSpell`. Master: Skyrim.esm only.

Build on the play PC: `powershell -ExecutionPolicy Bypass -File build.ps1` (Spriggit + Papyrus Compiler,
the same tools as LWCoverEyes). The zip lands in `Dist\` for Vortex.
