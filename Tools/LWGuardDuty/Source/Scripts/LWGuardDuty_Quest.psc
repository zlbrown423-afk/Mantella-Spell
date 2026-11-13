Scriptname LWGuardDuty_Quest extends Quest
{Living World guard careers: the duty in hand as a journal quest, "Guard Duty", kept in front of the player
until the shift is over.

The objective is the duty and when the shift ends ("Stand watch at the main gate until 2:00 pm, 3 h left").
It pops up at the top of the view when the duty is given and again every few minutes (the server says how
often), with the time left. Once the duty may be reported, a second objective appears, "Report back to
Commander Caius", with a compass marker on them. Between conversations this script keeps the clock itself:
at the shift's end the duty objective is ticked off (or failed, if the player was never seen at the post)
and the report one becomes "Shift over: report back to ... by 2:00 am"; past that deadline it fails and the
quest closes. When the server sees the duty settled it says so and the quest closes the same way.

The objective texts are the names of two hidden references (renamed with SetDisplayName) that fill the
DutyText and ReportText aliases of LWGuardDuty_Shown; its objectives read <Alias=DutyText> and
<Alias=ReportText>.

The Living World build of Mantella sends the mod event this listens for (LivingWorld_GuardDuty); without it
nothing happens. MANTELLA_LW_DUTY_HUD=0 on the server closes it for good.}

Quest Property Shown Auto                  ; LWGuardDuty_Shown: the journal entry
MiscObject Property TextBase Auto          ; LWGuardDuty_Text: the hidden references whose names are the texts
Float Property PollSeconds = 10.0 Auto Hidden
Float Property CloseDelay = 5.0 Auto Hidden   ; seconds the ticked-off / failed objective stays before it closes

Int Task                  ; the duty shown (server task id); 0 = none
String DutyLine
Float EndGt               ; game days + 1 (as the server counts them); 0 = no shift
Float ReadyAt             ; may be reported from then on; -1 = not yet
Float ReportBy            ; missed after this; 0 = none
Bool Seen
String Boss
Actor BossActor
Float Every = 180.0       ; real seconds between reminders; 0 = only on change
Int Phase                 ; 1 on shift, 2 may report, 3 shift over
Float ShownAt             ; real time of the last reminder
Float LastReal
ObjectReference DutyRef
ObjectReference ReportRef

Event OnInit()
	If IsRunning()
		Listen()
		RegisterForSingleUpdate(PollSeconds)
	EndIf
EndEvent

Function Listen()
	RegisterForModEvent("LivingWorld_GuardDuty", "OnGuardDuty")
	LastReal = Utility.GetCurrentRealTime()
EndFunction

Event OnUpdate()
	If Utility.GetCurrentRealTime() < LastReal   ; the game was started again and a save loaded
		Listen()
	EndIf
	LastReal = Utility.GetCurrentRealTime()
	If Task != 0
		Refresh(False)
	EndIf
	RegisterForSingleUpdate(PollSeconds)
EndEvent

; ---- from the Mantella server (via MantellaConversation) ----

Event OnGuardDuty(Int newTask, String text, Float aEndGt, Float aReadyAt, Float aReportBy, Bool isSeen, String bossName, Form bossForm, String outcome, Int lastTask, Float everySeconds)
	If newTask == 0
		If Task != 0
			If lastTask == Task
				Close(outcome)
			Else
				Close("")        ; not the duty the server settled (a save from before it): just take it down
			EndIf
		EndIf
		Return
	EndIf
	If newTask != Task
		Open(newTask)
	EndIf
	DutyLine = text
	EndGt = aEndGt
	ReadyAt = aReadyAt
	ReportBy = aReportBy
	Seen = isSeen
	Boss = bossName
	Every = everySeconds
	Actor a = bossForm as Actor
	ReferenceAlias superior = Shown.GetAlias(2) as ReferenceAlias
	If a && a != BossActor && superior
		superior.ForceRefTo(a)
	ElseIf !a && superior
		superior.Clear()
	EndIf
	BossActor = a
	Refresh(True)
EndEvent

; ---- the journal quest ----

Function Open(Int newTask)
	If Shown.IsRunning()
		Shown.Stop()
		Utility.Wait(0.5)
	EndIf
	Task = newTask
	Phase = 0
	BossActor = None
	Actor player = Game.GetPlayer()
	If !DutyRef
		DutyRef = player.PlaceAtMe(TextBase, 1, True, True)
	EndIf
	If !ReportRef
		ReportRef = player.PlaceAtMe(TextBase, 1, True, True)
	EndIf
	Shown.Start()
	(Shown.GetAlias(0) as ReferenceAlias).ForceRefTo(DutyRef)
	(Shown.GetAlias(1) as ReferenceAlias).ForceRefTo(ReportRef)
	Shown.SetStage(10)
	Shown.SetActive(True)
EndFunction

; Ticks off ('done') or fails ('failed') what is showing, waits a moment, and takes the quest down.
Function Close(String outcome)
	If Shown.IsRunning()
		If outcome == "done"
			If Shown.IsObjectiveDisplayed(10) && !Shown.IsObjectiveCompleted(10) && !Shown.IsObjectiveFailed(10)
				Shown.SetObjectiveCompleted(10)
			EndIf
			If Shown.IsObjectiveDisplayed(20)
				Shown.SetObjectiveCompleted(20)
			EndIf
		ElseIf outcome == "failed"
			If Shown.IsObjectiveDisplayed(20)
				Shown.SetObjectiveFailed(20)
			ElseIf Shown.IsObjectiveDisplayed(10) && !Shown.IsObjectiveCompleted(10)
				Shown.SetObjectiveFailed(10)
			EndIf
		EndIf
		Task = 0
		If outcome != ""
			Utility.Wait(CloseDelay)
		EndIf
		If Task == 0     ; no new duty came in while it waited
			Shown.Stop()
		EndIf
	EndIf
	Task = 0
	Phase = 0
	BossActor = None
EndFunction

Function Refresh(Bool changed)
	If !Shown.IsRunning()
		Return
	EndIf
	Float now = Utility.GetCurrentGameTime() + 1.0
	If ReportBy > 0.0 && now > ReportBy
		Close("failed")      ; never reported back: the server books it as missed
		Return
	EndIf
	Int was = Phase
	If EndGt > 0.0 && now >= EndGt
		Phase = 3
	ElseIf ReadyAt >= 0.0 && now >= ReadyAt
		Phase = 2
	Else
		Phase = 1
	EndIf
	Float real = Utility.GetCurrentRealTime()
	Bool remind = Every > 0.0 && real - ShownAt >= Every
	If !changed && !remind && Phase == was
		Return
	EndIf
	ShownAt = real
	If Phase < 3
		DutyRef.SetDisplayName(DutyText(now), True)
		Shown.SetObjectiveDisplayed(10, True, True)
	ElseIf !Shown.IsObjectiveCompleted(10) && !Shown.IsObjectiveFailed(10)
		DutyRef.SetDisplayName(DutyLine, True)
		Shown.SetObjectiveDisplayed(10, True, False)
		If Seen
			Shown.SetObjectiveCompleted(10)
		Else
			Shown.SetObjectiveFailed(10)   ; never seen at the post: reporting now is a false report
		EndIf
	EndIf
	If Phase >= 2
		ReportRef.SetDisplayName(ReportText(), True)
		If Phase != was || changed || Phase == 3
			Shown.SetObjectiveDisplayed(20, True, True)
		EndIf
	ElseIf Shown.IsObjectiveDisplayed(20)
		Shown.SetObjectiveDisplayed(20, False)
	EndIf
EndFunction

String Function DutyText(Float now)
	String s = DutyLine
	If EndGt > 0.0
		s += " until " + Clock(EndGt) + " (" + Left(EndGt - now) + " left)"
		If !Seen
			s += ". Be seen at your post"
		EndIf
	EndIf
	Return s
EndFunction

String Function ReportText()
	String who = Boss
	If who == ""
		who = "your superior"
	EndIf
	If Phase == 3
		String s = "Shift over: report back to " + who
		If ReportBy > 0.0
			s += " by " + Clock(ReportBy)
		EndIf
		Return s
	EndIf
	If EndGt > 0.0
		Return "You may report back to " + who + " (shift ends " + Clock(EndGt) + ")"
	EndIf
	If ReportBy > 0.0
		Return "Report back to " + who + " by " + Clock(ReportBy)
	EndIf
	Return "Report back to " + who
EndFunction

; ---- time as text ----

String Function Clock(Float gt)
	Int minutes = ((gt - Math.Floor(gt)) * 1440.0 + 0.5) as Int
	minutes = minutes % 1440
	Int h = minutes / 60
	Int m = minutes % 60
	String ampm = "am"
	If h >= 12
		ampm = "pm"
	EndIf
	Int h12 = h % 12
	If h12 == 0
		h12 = 12
	EndIf
	String mm = m as String
	If m < 10
		mm = "0" + mm
	EndIf
	Return (h12 as String) + ":" + mm + " " + ampm
EndFunction

String Function Left(Float days)
	Int minutes = (days * 1440.0 + 0.5) as Int
	If minutes < 1
		minutes = 1
	EndIf
	If minutes < 60
		Return (minutes as String) + " min"
	EndIf
	Int h = minutes / 60
	Int m = minutes % 60
	If m == 0
		Return (h as String) + " h"
	EndIf
	Return (h as String) + " h " + (m as String) + " min"
EndFunction
