# LWToneWheel

A tiny companion plugin for the Living World build of Mantella: a **tone wheel**. Eight lesser powers,
given to the player automatically:

`Tone: Friendly` · `Tone: Polite` · `Tone: Flirty` · `Tone: Stern` · `Tone: Threatening` · `Tone: Sarcastic` ·
`Tone: Pleading` · `Tone: Neutral`

Put them on the Spell Wheel (they are powers, so they sit in the voice slot and never take a weapon or spell out
of your hands). Cast one before you speak: a notification shows `Tone: Stern`, and from then on NPCs judge your
lines against it.

* The tone stays until you pick another one, cast **Tone: Neutral**, or the conversation ends. A tone picked
  before you start talking carries into that conversation (for up to ten minutes).
* NPCs judge the **live** voice, speechcraft style: the server measures each line (loudness against your own
  recent lines, pitch, pitch range, hesitation, pace) and compares it with the tone you picked. A delivery that
  fits lands ("it carries authority"); one that does not falls flat ("it falters: it sounds like a bluff"). Your
  Speech skill gives the benefit of the doubt on small slips.
* After each line the HUD shows how it came across, e.g. `[Tone] Threatening: clashes (hesitant, higher pitch)`.

The power only sends the mod event `LivingWorld_ToneSet` (the tone's name); `MantellaRepository` (Mantella-Spell)
passes it to the server. Voice measuring needs the capture layer on (`MANTELLA_LW_AUDIO_V2=1`); without it NPCs
still know the intended tone and judge it by your words. Server switches: `MANTELLA_LW_TONE=0` (all off),
`MANTELLA_LW_TONE_HUD=0` (no `[Tone]` line), `MANTELLA_LW_TONE_UNPICKED=0` (no note on a striking voice when no
tone is picked). Master: Skyrim.esm only.

Build on the play PC: `powershell -ExecutionPolicy Bypass -File build.ps1` (Spriggit + Papyrus Compiler, the
same tools as LWCoverEyes). The zip lands in `Dist\` for Vortex. Also compile `MantellaRepository.psc`.
