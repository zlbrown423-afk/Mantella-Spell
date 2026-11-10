Scriptname LWDiary_Quest extends Quest
{Living World diaries. People the player talks with a lot keep a diary (the Mantella server decides who, and
writes the entries from their own memories). Each one is a real book, "Gerdur's Diary": in their pockets
(pickpocket it), or, when the player walks into their home, often lying on a table there (owned by them, so
taking it is theft). Opening it asks the server for the newest entries and shows them as pages after the book
is closed. If the owner sees the player reading it, they remember, and so does anyone else who sees.

The Living World build of Mantella sends the mod events this listens for; without it nothing happens.}

Book Property DiaryBook Auto
FormList Property Tables Auto                    ; vanilla table statics a diary can be put on
Float Property TableChance = 0.6 Auto Hidden      ; walking into the owner's home: the diary lies on a table
Float Property TableSearchUnits = 3000.0 Auto Hidden
Float Property SeeUnits = 2000.0 Auto Hidden      ; how far away someone can catch the player reading
Float Property PollSeconds = 4.0 Auto Hidden

Actor[] Owners
ObjectReference[] Books
Int[] NpcIds          ; the owner's id in the server's store (sent back when the diary is opened)
String[] Titles
String WorldId
Int Port = 4999
Cell _lastCell
Float _lastRealTime
Float _askedAt = -100.0

Event OnInit()
	If IsRunning()
		Setup()
	EndIf
EndEvent

Function Setup()
	If !Owners
		Owners = New Actor[32]
		Books = New ObjectReference[32]
		NpcIds = New Int[32]
		Titles = New String[32]
	EndIf
	RegisterForModEvent("LivingWorld_DiaryKeeper", "OnDiaryKeeper")
	RegisterForModEvent("LivingWorld_DiaryOpened", "OnDiaryOpened")
	RegisterForModEvent("LivingWorld_DiaryPages", "OnDiaryPages")
	_lastRealTime = Utility.GetCurrentRealTime()
	RegisterForSingleUpdate(PollSeconds)
EndFunction

; Every few seconds: has the player walked into another cell? Cheap; nothing else runs on the timer.
Event OnUpdate()
	Float now = Utility.GetCurrentRealTime()
	If now < _lastRealTime   ; the game was started again and a save loaded: make sure the events are heard
		RegisterForModEvent("LivingWorld_DiaryKeeper", "OnDiaryKeeper")
		RegisterForModEvent("LivingWorld_DiaryOpened", "OnDiaryOpened")
		RegisterForModEvent("LivingWorld_DiaryPages", "OnDiaryPages")
	EndIf
	_lastRealTime = now
	Actor player = Game.GetPlayer()
	Cell here = player.GetParentCell()
	If here && here != _lastCell
		_lastCell = here
		EnteredCell(here, player)
	EndIf
	RegisterForSingleUpdate(PollSeconds)
EndEvent

; ---- who keeps one (from the Mantella server, at each conversation start) ----

Event OnDiaryKeeper(Form keeperForm, Int npcId, String title, String world, Int httpPort)
	Actor keeper = keeperForm as Actor
	If !keeper || keeper.IsChild() || keeper.IsDead() || !DiaryBook
		Return
	EndIf
	If !Owners
		Setup()
	EndIf
	WorldId = world
	If httpPort > 0
		Port = httpPort
	EndIf
	Int i = Owners.Find(keeper)
	If i >= 0
		NpcIds[i] = npcId
		If Books[i] && Titles[i] != title   ; the player learned their name: the book's name changes too
			Books[i].SetDisplayName(title, True)
		EndIf
		Titles[i] = title
		If !Books[i]
			Books[i] = NewDiary(keeper, title)
		EndIf
		Return
	EndIf
	i = FreeSlot()
	If i < 0
		Return
	EndIf
	Owners[i] = keeper
	NpcIds[i] = npcId
	Titles[i] = title
	Books[i] = NewDiary(keeper, title)
EndEvent

ObjectReference Function NewDiary(Actor keeper, String title)
	ObjectReference book = keeper.PlaceAtMe(DiaryBook, 1, True, False)
	If book
		book.SetDisplayName(title, True)
		keeper.AddItem(book, 1, True)
	EndIf
	Return book
EndFunction

Int Function FreeSlot()
	Int i = 0
	While i < Owners.Length
		If !Owners[i] || Owners[i].IsDead()
			Return i
		EndIf
		i += 1
	EndWhile
	Return -1
EndFunction

; ---- where it lies ----

Function EnteredCell(Cell here, Actor player)
	Int i = 0
	While i < Owners.Length
		Actor owner = Owners[i]
		ObjectReference book = Books[i]
		If owner && book && !owner.IsDead()
			ObjectReference holder = book.GetContainer()
			If holder == player
				; the player has it: it stays with them
			ElseIf here.IsInterior() && IsHome(here, owner, player)
				If holder == owner && Utility.RandomFloat(0.0, 1.0) < TableChance
					LayOnTable(i, here, player)
				EndIf
			ElseIf !holder && owner.GetParentCell() == here && book.GetParentCell() != here
				owner.AddItem(book, 1, True)   ; it was left at home and they are out: they took it with them
			EndIf
		EndIf
		i += 1
	EndWhile
EndFunction

Bool Function IsHome(Cell here, Actor owner, Actor player)
	If here.GetActorOwner() == owner.GetActorBase()
		Return True
	EndIf
	Faction f = here.GetFactionOwner()
	If f && owner.IsInFaction(f)
		Return True
	EndIf
	Location home = owner.GetEditorLocation()
	Return home && player.GetCurrentLocation() == home
EndFunction

Function LayOnTable(Int i, Cell here, Actor player)
	If !Tables
		Return
	EndIf
	ObjectReference table = Game.FindClosestReferenceOfAnyTypeInListFromRef(Tables, player, TableSearchUnits)
	If !table || table.GetParentCell() != here
		Return
	EndIf
	Actor owner = Owners[i]
	ObjectReference placed = table.PlaceAtMe(DiaryBook, 1, True, False)
	If !placed
		Return
	EndIf
	owner.RemoveItem(Books[i], 1, True)   ; the copy in their pocket goes; this one is it now
	Books[i] = placed
	placed.SetDisplayName(Titles[i], True)
	placed.SetActorOwner(owner.GetActorBase())   ; taking it is theft
	placed.MoveTo(table, 0.0, 0.0, table.GetHeight() + 8.0)
	placed.ApplyHavokImpulse(0.0, 0.0, -1.0, 0.5)   ; let it settle on the table top
EndFunction

; ---- reading ----

Event OnDiaryOpened(Form bookForm)
	ObjectReference book = bookForm as ObjectReference
	If !book || !Books
		Return
	EndIf
	Int i = Books.Find(book)
	If i < 0 || !Owners[i] || NpcIds[i] <= 0
		Return
	EndIf
	Float now = Utility.GetCurrentRealTime()
	If now - _askedAt < 3.0
		Return
	EndIf
	_askedAt = now
	Actor owner = Owners[i]
	Actor player = Game.GetPlayer()
	Bool seen = Sees(owner, player)
	Int[] witnessIds = New Int[6]
	String[] witnessNames = New String[6]
	Witnesses(owner, player, witnessIds, witnessNames)
	Int handle = SKSE_HTTP.createDictionary()
	SKSE_HTTP.setString(handle, "mantella_request_type", "mantella_lw_diary_read")
	SKSE_HTTP.setString(handle, "mantella_lw_diary_world_id", WorldId)
	SKSE_HTTP.setInt(handle, "mantella_lw_diary_owner", NpcIds[i])
	SKSE_HTTP.setBool(handle, "mantella_lw_diary_seen", seen)
	SKSE_HTTP.setIntArray(handle, "mantella_lw_diary_witness_ref_ids", witnessIds)
	SKSE_HTTP.setStringArray(handle, "mantella_lw_diary_witness_names", witnessNames)
	Location where = player.GetCurrentLocation()
	If where
		SKSE_HTTP.setString(handle, "mantella_lw_diary_location", where.GetName())
	EndIf
	SKSE_HTTP.setFloat(handle, "mantella_lw_diary_game_days", Utility.GetCurrentGameTime() + 1.0) ; the server counts days as Mantella does (GameDaysPassed + 1)
	SKSE_HTTP.sendLocalhostHttpRequest(handle, Port, "Mantella")
	If seen
		Debug.Notification(owner.GetDisplayName() + " sees you reading it.")
	EndIf
EndEvent

Bool Function Sees(Actor npc, Actor player)
	If !npc || !npc.Is3DLoaded() || npc.IsDead() || npc.IsUnconscious() || npc.GetSleepState() >= 3
		Return False
	EndIf
	Return npc.GetDistance(player) < SeeUnits && npc.HasLOS(player)
EndFunction

; Grown-ups in the player's cell who can see them (at most six). Unused entries stay 0 / "".
Function Witnesses(Actor owner, Actor player, Int[] ids, String[] names)
	Cell here = player.GetParentCell()
	If !here
		Return
	EndIf
	Int n = here.GetNumRefs(62)   ; 62: placed actors
	If n > 40
		n = 40
	EndIf
	Int found = 0
	Int k = 0
	While k < n && found < ids.Length
		Actor a = here.GetNthRef(k, 62) as Actor
		If a && a != player && a != owner && !a.IsChild() && Sees(a, player)
			ids[found] = a.GetFormID()
			names[found] = a.GetActorBase().GetName()
			found += 1
		EndIf
		k += 1
	EndWhile
EndFunction

; The server's pages, joined with "<pg>". Shown one message box at a time once the book is closed
; (Utility.Wait does not count down while a menu is open, so each wait ends after its box is closed).
Event OnDiaryPages(String title, String joined)
	Utility.Wait(0.3)
	Int total = 1
	Int at = StringUtil.Find(joined, "<pg>", 0)
	While at >= 0
		total += 1
		at = StringUtil.Find(joined, "<pg>", at + 4)
	EndWhile
	Int start = 0
	Int page = 1
	While page <= total
		Int stop = StringUtil.Find(joined, "<pg>", start)
		String text
		If stop < 0
			text = StringUtil.Substring(joined, start)
		Else
			text = StringUtil.Substring(joined, start, stop - start)
		EndIf
		String counter = ""
		If total > 1
			counter = "\n\n(" + page + " of " + total + ")"
		EndIf
		Debug.MessageBox(title + "\n\n" + text + counter)
		Utility.Wait(0.3)
		start = stop + 4
		page += 1
	EndWhile
EndEvent
