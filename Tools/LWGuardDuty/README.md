# LWGuardDuty

A small companion plugin for the Living World build of Mantella (guard careers): the **guard duty in hand as a
journal quest**, "Guard Duty", kept in front of you until the shift is over.

* When your superior gives you a duty, the quest starts and its objective pops up at the top of the view:
  *"Stand watch at the main gate until 2:00 pm (3 h left). Be seen at your post"*.
* It pops up again every 3 minutes (real time) with the time left, so it never slips out of mind. Each time, the
  same line is also shown 4 times in a row in the top-left corner, 3 seconds apart (about 12 seconds in all), so
  there is time to read it (`NoticeRepeats` / `NoticeGap` on `LWGuardDuty_Quest`).
  `MANTELLA_LW_DUTY_HUD_EVERY=0` on the server shows it only when something changes; any other number is the
  seconds between reminders.
* Once you may report back (seen at your post and half the shift gone, or the trouble dealt with) a second
  objective appears, *"You may report back to Commander Caius (shift ends 2:00 pm)"*, with a compass marker on
  them (the quest is made the active one).
* At the shift's end the duty objective is ticked off (or failed, if nobody saw you at your post) and the report
  one becomes *"Shift over: report back to Commander Caius by 2:00 am"*. Past that it fails and the quest
  closes: the server books it as a missed duty.
* Reporting back (or the server finding the duty missed) ticks off or fails what is showing, and the quest closes
  a few seconds later. Loading an older save shows the duty as it was in that save.
* `MANTELLA_LW_DUTY_HUD=0` on the server switches it off (a duty that is showing closes at the next conversation).

How it fits together: the server (`livingworld/guard/hud.py`) sends the duty with an NPC line whenever it
changes; `MantellaConversation` passes it on as the mod event `LivingWorld_GuardDuty`, and
`LWGuardDuty_Quest` (start-game enabled, no journal entry of its own) runs the visible quest
`LWGuardDuty_Shown`. Its objectives read `<Alias=DutyText>` and `<Alias=ReportText>`: two hidden, disabled
references whose names are set with SKSE's `SetDisplayName`, so the text can be anything. The third alias,
`Superior`, holds the person to report to and is the target of the report objective. Between conversations
the script keeps the clock itself (a 10-second check). Master: Skyrim.esm only.

Build on the play PC: `powershell -ExecutionPolicy Bypass -File build.ps1` (Spriggit + Papyrus Compiler, the
same tools as LWDiary). The zip lands in `Dist\` for Vortex. It needs the Mantella-Spell build that sends
`LivingWorld_GuardDuty` from `MantellaConversation`.
