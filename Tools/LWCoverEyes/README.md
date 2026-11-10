# LWCoverEyes

A tiny companion plugin for the Living World build of Mantella: one lesser power, **Cover Your Eyes**,
given to the player automatically. Put it on the Spell Wheel.

* Cast it: the screen fades to black (Skyrim's own `FadeToBlackHoldImod`), sound keeps playing.
* Cast it again to look. It also uncovers by itself after 30 seconds or when a fight starts.
* Each change sends the mod event `LivingWorld_EyesCovered` (1 covered, 0 uncovered). Mantella's
  `MantellaRepository` turns it into an `eyes` record, so NPCs around know the player cannot see, and a
  running conversation hears "... covers their eyes".

Works without Mantella too (only the dark screen then). Master: Skyrim.esm only.

Build on the play PC: `powershell -ExecutionPolicy Bypass -File build.ps1` (Spriggit + Papyrus Compiler,
the same tools as LWAskLead). The zip lands in `Dist\` for Vortex.
