# LWDiary

A small companion plugin for the Living World build of Mantella: **diaries** for the people you spend time with.

* Anyone grown-up you have talked with at least 5 times (the Mantella server decides, `MANTELLA_LW_DIARY_MIN_TALKS`)
  gets a book, **"Gerdur's Diary"**, in their pockets. Pickpocket it, or find it lying on a table: when you walk
  into their home, there is a 60% chance it is out on a table there. It belongs to them, so taking it is theft.
  If it was left at home and you meet them somewhere else, they have it on them again.
* Open it (from the table, their inventory or your own) and close it again: the newest entries follow as message
  pages, newest day first. They are written by the server's background model from that person's own memories,
  what they heard, and how they feel about you, so they hold things they would never say to your face.
* If the owner sees you reading it ("Gerdur sees you reading it."), they remember: less trust, less liking, more
  suspicion. Anyone else in the room who sees it remembers too.
* With fog on, someone you do not know by name has a "Nord woman's Diary" until you learn their name.
* Children never keep one. `MANTELLA_LW_DIARY=0` on the server switches diaries off (open ones show blank pages).

How it fits together: at each conversation start the server lists the participants who keep a diary;
`MantellaConversation` passes that on as the mod event `LivingWorld_DiaryKeeper`, and `LWDiary_Quest` makes the
book. Opening it (`LWDiary_Book.OnRead`) sends the request `mantella_lw_diary_read` straight to the server; the
reply comes back through `MantellaConversation` as `LivingWorld_DiaryPages`. A 4-second timer only checks whether
the player changed cell. Master: Skyrim.esm only.

Build on the play PC: `powershell -ExecutionPolicy Bypass -File build.ps1`. The first run reads Skyrim.esm with
`find_vanilla.py` for a journal model and the table objects (kept in `vanilla.json`), then Spriggit + Papyrus
Compiler as for LWSitDown. The zip lands in `Dist\` for Vortex. It needs the Mantella-Spell build with
`LivingWorldDiaryKeepers` in `MantellaConversation`.
