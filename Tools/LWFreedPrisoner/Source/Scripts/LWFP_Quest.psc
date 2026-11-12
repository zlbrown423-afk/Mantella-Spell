Scriptname LWFP_Quest extends Quest
{Living World: the freed Northwatch Keep prisoner (the Breton woman, ref 000C1AA4) as a companion.
While Mantella has her following (giafac_Following rank 1 or more) she is the player's teammate, so she goes
through load doors with them. When Mantella's Unfollow lets her go, she does not drift back to her cell:
she spends the day at the Bannered Mare in Whiterun and the night at the player's house (Breezehome first,
then Proudspire, Honeyside, Vlindrel Hall, Hjerim; the Bannered Mare again if the player owns none).
Console off switch: set LWFP_On to 0 (she then keeps her own AI). Log lines are tagged [LWFreedPrisoner].}

ReferenceAlias Property PrisonerAlias Auto   ; alias 0, forced to 000C1AA4, carries LWFP_StayPkg
ReferenceAlias Property HomeAlias Auto       ; alias 1, the marker she sandboxes around
GlobalVariable Property LWFP_On Auto
GlobalVariable Property LWFP_StayHome Auto
Faction Property FollowingFaction Auto       ; Mantella.esp giafac_Following 003806
Faction Property PlayerFaction Auto

Cell Property HouseWhiterun Auto      ; Breezehome
Cell Property HouseSolitude Auto      ; Proudspire Manor
Cell Property HouseRiften Auto        ; Honeyside
Cell Property HouseMarkarth Auto      ; Vlindrel Hall
Cell Property HouseWindhelm Auto      ; Hjerim
ObjectReference Property MarkerWhiterun Auto
ObjectReference Property MarkerSolitude Auto
ObjectReference Property MarkerRiften Auto
ObjectReference Property MarkerMarkarth Auto
ObjectReference Property MarkerWindhelm Auto
ObjectReference Property MarkerBanneredMare Auto

Float Property Poll = 4.0 AutoReadOnly
Float Property DayStart = 8.0 AutoReadOnly    ; 8 am: off to the inn
Float Property DayEnd = 21.0 AutoReadOnly     ; 9 pm: home to sleep

Int Mode   ; 0 = never followed yet (still the keep's prisoner), 1 = following, 2 = staying in Whiterun

Event OnInit()
	Log("Started")
	RegisterForSingleUpdate(Poll)
EndEvent

Event OnUpdate()
	Tick()
	RegisterForSingleUpdate(Poll)
EndEvent

Function Tick()
	Actor her = PrisonerAlias.GetActorRef()
	If her == None || her.IsDead()
		Return
	EndIf
	If LWFP_On.GetValueInt() == 0
		If LWFP_StayHome.GetValueInt() != 0
			LWFP_StayHome.SetValueInt(0)
			her.EvaluatePackage()
		EndIf
		Return
	EndIf
	Bool following = her.GetFactionRank(FollowingFaction) >= 1
	If following
		If Mode != 1
			Mode = 1
			LWFP_StayHome.SetValueInt(0)
			her.SetPlayerTeammate(True)
			her.EvaluatePackage()
			Log("Following the player")
		EndIf
	ElseIf Mode == 1
		Mode = 2
		her.SetPlayerTeammate(False)
		LWFP_StayHome.SetValueInt(1)
		PlaceHer(her, True)
	ElseIf Mode == 2
		PlaceHer(her, False)
	EndIf
EndFunction

; Points the Home alias at the inn by day and the player's house by night; only re-evaluates when that changes.
Function PlaceHer(Actor her, Bool abForce)
	ObjectReference target = PickSpot()
	If abForce || HomeAlias.GetReference() != target
		HomeAlias.ForceRefTo(target)
		her.EvaluatePackage()
		Log("Staying at " + target)
	EndIf
EndFunction

ObjectReference Function PickSpot()
	Float t = Utility.GetCurrentGameTime()
	Float hour = (t - Math.Floor(t)) * 24.0
	If hour >= DayStart && hour < DayEnd
		Return MarkerBanneredMare
	EndIf
	If OwnedByPlayer(HouseWhiterun)
		Return MarkerWhiterun
	ElseIf OwnedByPlayer(HouseSolitude)
		Return MarkerSolitude
	ElseIf OwnedByPlayer(HouseRiften)
		Return MarkerRiften
	ElseIf OwnedByPlayer(HouseMarkarth)
		Return MarkerMarkarth
	ElseIf OwnedByPlayer(HouseWindhelm)
		Return MarkerWindhelm
	EndIf
	Return MarkerBanneredMare
EndFunction

Bool Function OwnedByPlayer(Cell akCell)
	If akCell == None
		Return False
	EndIf
	Return akCell.GetFactionOwner() == PlayerFaction || akCell.GetActorOwner() == Game.GetPlayer().GetActorBase()
EndFunction

Function Log(String asText)
	Debug.Trace("[LWFreedPrisoner] " + asText)
EndFunction
