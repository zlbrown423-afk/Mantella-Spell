# LWHaptics

VR controller "impact" pulses for OStim scenes, landing on every thrust. Default: rear-entry
(doggystyle / from-behind) scenes only, both Touch controllers.

## How the rhythm stays exact

OStim Standalone already detects every thrust itself: it measures the distance between the partners'
bones and fires a "peak" at the moment of contact (the same signal that plays its slap sound). It hands
those peaks to sex toys through its plugin interface. `LivingWorldHaptics.dll` registers itself there
as a toy called **VR controllers (Living World)**, and on each peak sends a short pulse that hits hard and
fades, through OpenVR. The pulse follows the animation at every speed, with no timers or guessing.

The rear-entry check uses OStim's scene events: the player's scene has the `doggystyle` tag, or vaginal or
anal sex with a partner tagged `facingaway` / `allfours`.

No Papyrus runs, so it adds no Papyrus load and cannot cause the stack-dump freezes seen before.

## Settings

`SKSE/Plugins/LivingWorldHaptics.ini` (re-read at each scene start):

| key | default | meaning |
| --- | --- | --- |
| `bEnabled` | 1 | on/off |
| `iStrength` | 80 | 0-100 |
| `iPulseMs` | 70 | length of one impact (shorter = sharper, longer = heavier) |
| `iHands` | 0 | 0 both, 1 right, 2 left |
| `bRearEntryOnly` | 1 | 0 = every scene where OStim detects thrusts |
| `bClimax` / `iClimaxMs` | 1 / 700 | a long rumble when OStim reports a climax |
| `bTestPulseOnLoad` | 0 | 1 = one buzz right after a save loads, to check the controllers react |

OStim's own MCM toy page also lists the toy; switching it off there, or setting its scaling to "speed",
works too (the pulse is multiplied by OStim's peak value).

A log is written next to the dll: `SKSE/Plugins/LivingWorldHaptics.log` (hooked / armed / idle lines).

## Build

`./build.sh` (clang + lld + llvm-dlltool; no Windows SDK, no CRT). Output `Dist/LWHaptics-<ver>.zip`, ready
for Vortex. Needs OStim Standalone (VR port) loaded; without it the dll only logs that OStim did not answer.

`src/openvr.h` is Valve's OpenVR header v1.0.10 (BSD-3-Clause, Copyright Valve Corporation).
`src/OStimPluginInterface.h` mirrors OStimNG 7.5.1b's plugin interface (GPL-3.0).

## 0.1.1: stays completely idle until a save is loaded

A report said the Touch controllers (laser pointers) did not respond at "Press any button" while 0.1.0 was
installed. 0.1.0's log shows it only registered with OStim at startup and never called OpenVR, so the cause
is not proven. 0.1.1 removes every startup action anyway:

* at game start it only registers for SKSE's "save loaded" message; no thread, no OStim, no OpenVR;
* it contacts OStim only after a save has loaded, and not at all with `bEnabled=0`;
* the rumble thread and OpenVR are first touched on the first real pulse inside a scene;
* the message to OStim is addressed to OStim only (0.1.0 could fall back to a broadcast to all plugins).
