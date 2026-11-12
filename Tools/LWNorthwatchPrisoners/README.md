# LWNorthwatchPrisoners

A tiny companion plugin: the prisoners in Northwatch Keep can follow you out and stay out.

**Why they vanish.** The three prisoners (the Breton woman in the south-west cell, ref `000C1AA4`, base
`000C1AA3`, and the two men, refs `000C1A9C` / `000C1AA0`, bases `000C1A9E` / `000C1A9F`) are persistent refs
in `NorthwatchKeep01` with no enable parent, and the *Missing in Action* quest never references them. Their base
records carry the **Respawn** flag, though. When the keep's cell resets (10 days, or 30 once cleared), a
respawning actor is put back the way the editor placed her: in her cell, asleep, wherever she had followed you.

**What the plugin does.** It overrides those three base NPC records with one change: the Respawn flag is cleared.
Name, face, factions, packages and the quest are untouched. Being persistent refs, they are never unloaded or
deleted once they are somewhere else. Follow them with Mantella's Follow (ask her to come with you) as with
anyone else.

Notes
* When you tell her to stop following, her own default AI takes over again and she may wander back toward the
  keep, like any NPC heading home. Keep her following, or send her somewhere with Mantella.
* Turn it off: disable the plugin in Vortex (no save cleanup needed; the flag simply comes back).
* Without the plugin, a console stopgap: `prid c1aa4`, `setrelationshiprank player 3`, `addfac 5c84d 0` makes her a
  vanilla potential follower (it does not stop the respawn reset).

Build on the play PC: `powershell -ExecutionPolicy Bypass -File build.ps1`. `make_esp.py` copies the three
records from Skyrim.esm byte for byte (decompressed), clears ACBS flag 0x08 and writes the names out as text
(Skyrim.esm is localized, this plugin is not). Master: Skyrim.esm only. The zip lands in `Dist\` for Vortex.
