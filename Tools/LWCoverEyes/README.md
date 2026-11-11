# LWCoverEyes

A tiny companion plugin for the Living World build of Mantella: two lesser powers, **Cover Your Eyes**
and **Arousal**, given to the player automatically. Put them on the Spell Wheel.

* Cast it: the screen fades to black (Skyrim's own `FadeToBlackHoldImod`), sound keeps playing.
* Cast it again to look. It also uncovers by itself after 30 seconds or when a fight starts.
* Each change sends the mod event `LivingWorld_EyesCovered` (1 covered, 0 uncovered). Mantella's
  `MantellaRepository` turns it into an `eyes` record, so NPCs around know the player cannot see, and a
  running conversation hears "... covers their eyes".

**Arousal** (male player with The New Gentleman) does what rapid taps of the arousal key (NumPad 5) do,
for VR where a keyboard key is awkward: each cast is one step up (visibly aroused, more, fully), a cast
when fully aroused lets it go down, and it fades by itself after two minutes. It sends the mod event
`LivingWorld_ArousalStep`; `MantellaRepository` moves TNG and tells the NPCs around. Without Mantella it
does nothing.

Cover Your Eyes works without Mantella too (only the dark screen then). Master: Skyrim.esm only.

Build on the play PC: `powershell -ExecutionPolicy Bypass -File build.ps1` (Spriggit + Papyrus Compiler,
the same tools as LWAskLead). The zip lands in `Dist\` for Vortex.
