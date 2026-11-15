# VR typing patch

Lets you type lines to Mantella NPCs while playing Skyrim VR. In VR, Mantella's text box
(UIExtensions `UITextEntryMenu`) opens but takes no keyboard input.

## How it works

1. `Open Mantella Typing.bat` starts `MantellaTyping.ps1`, a small always-on-top desktop window.
2. You type a line and press Enter. The line is saved to
   `SkyrimVR\Data\MantellaTyping\input.txt` (one line, UTF-8). The path is set at the top of the script.
3. In game, press the Mantella text hotkey. `MantellaConversation.GetPlayerTextInput()` reads the file
   with PapyrusUtil `MiscUtil.ReadFromFile`, sends the line as the player's input and empties the file.

This only works with the microphone **off** in the MCM. With the mic on, the text hotkey is used for
push-to-talk or does nothing, and `GetPlayerTextInput()` is never reached, so the patch never
competes with speech capture. The server has no typing code: a typed line arrives as ordinary
player text (input type `text`), and speech-to-text is skipped for it.

Two optional powers on the play PC also use the file: LWDirtTest (hygiene debug lines) and LWAskLead
(lead questions). They write the file, then call `GetPlayerTextInput()`.

## Files

- `Scripts/Source/MantellaConversation.psc`: the `VR TYPING PATCH` hunk in `GetPlayerTextInput()`.
- `MantellaTyping.ps1`, `Open Mantella Typing.bat`: the desktop typing window.
- `stubs/`: empty `MantellaMCM` and `UIExtensions` stubs, used only as compile imports.
- `original-patch.diff`: the patch as first made against stock Mantella 0.14.

## Removing it

Revert the `VR TYPING PATCH` hunk in `MantellaConversation.psc` (back to the three `UIExtensions`
lines), recompile, and delete this folder. Nothing else depends on it except the two optional powers.
