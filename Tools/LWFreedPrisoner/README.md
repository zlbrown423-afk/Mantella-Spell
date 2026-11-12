# LWFreedPrisoner

The Breton woman freed from Northwatch Keep (ref `000C1AA4`, named **Elyse Marrow** by `LWNorthwatchPrisoners`)
as a companion who lives in Whiterun when you leave her behind.

* **Following.** Ask her to follow with Mantella as usual. While she is in Mantella's `giafac_Following`
  she is also your teammate, so she comes through load doors with you.
* **When you let her go** (Mantella's Unfollow), she walks to Whiterun: the Bannered Mare by day
  (8 am to 9 pm), your house at night: Breezehome first, then Proudspire Manor, Honeyside, Vlindrel Hall, Hjerim,
  or the Bannered Mare if you own none. She sandboxes there (sits, eats, sleeps) with the vanilla Sandbox template,
  radius 1500. Ask her to follow again to bring her along.
* **Background and memory.** `ElyseMarrow.json` is a Mantella character override: her lore background
  (Wayrest-born dock tally-keeper from Solitude, taken by the Thalmor over her late husband's Talos figure) and the
  memory of you opening her cell door during the Northwatch raid. Copy it to
  `Documents\My Games\Mantella\data\Skyrim\character_overrides\`. It also fixes the stock CSV row, which lists
  her as male.
* Needs `LWNorthwatchPrisoners.esp` 0.2.0 (no respawn, her name). Masters: Skyrim.esm, Mantella.esp.
* Off switch: console `set LWFP_On to 0` (she keeps her own AI), or disable the plugin.

Build on the play PC: `powershell -ExecutionPolicy Bypass -File build.ps1` (Spriggit + Papyrus Compiler, as for
LWSaloniaSurrender). The zip lands in `Dist\`.
