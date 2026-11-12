Scriptname MantellaAdvancedAction_LeadTo extends Quest Hidden

MantellaInterface Property EventInterface Auto
MantellaConstants Property mConsts Auto
MantellaLocationUtils Property LocationUtils Auto
Faction Property MantellaFunctionSourceFaction Auto
ReferenceAlias Property LeadToLocationAlias Auto
ReferenceAlias Property LeadToSourceAlias Auto
ReferenceAlias Property LeadToTargetAlias Auto
Actor Property PlayerRef Auto

event OnInit()
    RegisterForModEvent(EventInterface.EVENT_ADVANCED_ACTIONS_PREFIX + mConsts.ACTION_NPC_LEADTO, "OnNpcLeadToAdvancedActionReceived")
EndEvent


event OnNpcLeadToAdvancedActionReceived(Form speaker, Form conversationQuest, int argumentsHandle)
    MantellaConversation conversation = conversationQuest as MantellaConversation
    
    ; Extract parameters
    string sourceName = SKSE_HTTP.getString(argumentsHandle, mConsts.ACTION_ARG_SOURCE)
    string targetName = SKSE_HTTP.getString(argumentsHandle, mConsts.ACTION_ARG_TARGET)
    string locationName = SKSE_HTTP.getString(argumentsHandle, "location")
    
    ; Get destination marker
    ObjectReference markerRef = LocationUtils.MapMarkerLocationToRef(locationName)
    if !markerRef
        Debug.Notification("Could not find " + locationName)
        EventInterface.AddMantellaEvent("Cannot travel to unknown location: " + locationName + ".")
        return
    endif

    ; Clear any previous pending travel state
    ClearSourceAlias()
    
    ; Set destination
    LeadToLocationAlias.ForceRefTo(markerRef)
    
    Actor sourceActor = conversation.GetActorByName(sourceName)
    Actor targetActor = conversation.GetActorByName(targetName)

    if sourceActor && targetActor
        LeadTo(sourceActor, targetActor, locationName)
    endif
endEvent


Function ClearSourceAlias()
    ; Clear source alias to reset travel state
    UnregisterForUpdate()
    if LeadToSourceAlias
        Actor sourceActor = LeadToSourceAlias.GetActorReference()
        if sourceActor
            if sourceActor.GetFactionRank(MantellaFunctionSourceFaction) == 5 ; LIVINGWORLD PATCH: only our own rank
                sourceActor.RemoveFromFaction(MantellaFunctionSourceFaction)
            endIf
            sourceActor.EvaluatePackage()
        endIf
        LeadToSourceAlias.Clear()
    endIf
EndFunction


Function LeadTo(Actor leaderActor, Actor followerActor, string locationName)
    LeadToSourceAlias.ForceRefTo(leaderActor)
    LeadToTargetAlias.ForceRefTo(followerActor)
    
    ; Clear wait state for followers to prevent them from getting stranded
    if leaderActor.IsPlayerTeammate()
        if leaderActor.GetActorValue("WaitingForPlayer") == 1
            leaderActor.SetActorValue("WaitingForPlayer", 0)
            Debug.Notification(leaderActor.GetDisplayName() + " is no longer waiting.")
        endif
    endif
    
    ; Set faction rank to activate package
    leaderActor.SetFactionRank(MantellaFunctionSourceFaction, 5) ; Rank 5 = LeadTo package
    
    ; Force AI to re-evaluate packages
    leaderActor.EvaluatePackage()
    if followerActor != PlayerRef
        followerActor.EvaluatePackage()
    endif
    
    Debug.Notification(leaderActor.GetDisplayName() + " is leading " + followerActor.GetDisplayName() + " to " + locationName + ".")

    ; LIVINGWORLD PATCH: watch the trip (arrival, doors, a player who stopped following)
    _lwPlace = locationName
    LwResetWatch()
    RegisterForSingleUpdate(LwTick)
EndFunction


; ---------------------------------------------------------------------------------------------------
; LIVINGWORLD PATCH: the trip watcher.
;
; The LeadTo package (Escort template) only runs while the leader is more than 1000 units from the
; destination marker, and nothing used to take the leader off it. So on arrival the package switched
; off, the NPC's own routine walked them away (often through their front door, which puts them in
; another cell and "far" again), the package switched back on, out they came, and so on forever.
; Load doors on the way did the same thing: the leader went through first, the escort sent them back
; for the player, the player came through the other way, and the two swapped sides again and again.
;
; Every second this watcher:
;   - ends the trip once the leader (or the player, with the leader alongside) reaches the place;
;   - when the player has gone through a door and the leader is still on the other side, brings the
;     leader through to the player, like a follower catching up, so they cannot keep swapping sides;
;   - gives up when the player clearly stopped following (fast travel, wandered far off).
; Ending a trip takes the leader off the LeadTo rank only, and tells Mantella they arrived.
; ---------------------------------------------------------------------------------------------------

float property LwTick = 1.0 autoReadOnly
float property LwArriveUnits = 1300.0 autoReadOnly       ; package stops at 1000; catch them just outside
float property LwNearUnits = 2000.0 autoReadOnly         ; "walking together" before a door
float property LwFarUnits = 6000.0 autoReadOnly          ; ~85 m: the player is not following any more
int property LwCatchUpAfter = 3 autoReadOnly              ; seconds apart after the player used a door
int property LwStuckAfter = 20 autoReadOnly               ; seconds apart with no door from the player
int property LwFarGiveUp = 90 autoReadOnly
int property LwApartGiveUp = 120 autoReadOnly
int property LwMaxCatchUps = 12 autoReadOnly

string _lwPlace
Form _lwPlayerSpace   ; interior cell, or exterior worldspace
float _lwPlayerDoorAt
int _lwApart
int _lwFar
int _lwCatchUps
bool _lwWasNear

Function LwResetWatch()
    Actor follower = LeadToTargetAlias.GetActorReference()
    if !follower
        follower = PlayerRef
    endIf
    _lwPlayerSpace = LwSpaceOf(follower)
    _lwPlayerDoorAt = -100.0
    _lwApart = 0
    _lwFar = 0
    _lwCatchUps = 0
    _lwWasNear = true
EndFunction

; After a game load: watch a trip that was running when the save was made (saves from before this
; patch had no watcher, so their leaders are still on the package).
Function LivingWorldResumeWatch()
    Actor leader = LeadToSourceAlias.GetActorReference()
    if leader && leader.GetFactionRank(MantellaFunctionSourceFaction) == 5
        if _lwPlace == ""
            _lwPlace = "their destination"
        endIf
        LwResetWatch()
        RegisterForSingleUpdate(LwTick)
    endIf
EndFunction

; Cancel the trip (CancelTravel, or the player said stop).
Function StopLeading(string why)
    Actor leader = LeadToSourceAlias.GetActorReference()
    if leader
        Debug.Trace("Mantella Living World: " + leader.GetDisplayName() + " stops leading (" + why + ")")
    endIf
    LwEndTrip()
EndFunction

Function LwEndTrip()
    ClearSourceAlias()
    LeadToTargetAlias.Clear()
    LeadToLocationAlias.Clear()
    _lwPlace = ""
EndFunction

; Both in the same exterior worldspace, or in the same interior cell. GetDistance across those is not
; meaningful, so every distance check goes through this first.
bool Function LwSameSpace(ObjectReference a, ObjectReference b)
    Form sa = LwSpaceOf(a)
    return sa && sa == LwSpaceOf(b)
EndFunction

Form Function LwSpaceOf(ObjectReference a)
    Cell c = a.GetParentCell()
    if c && c.IsInterior()
        return c
    endIf
    return a.GetWorldSpace()
EndFunction

event OnUpdate()
    Actor leader = LeadToSourceAlias.GetActorReference()
    ObjectReference marker = LeadToLocationAlias.GetReference()
    if !leader || !marker || leader.IsDead() || leader.GetFactionRank(MantellaFunctionSourceFaction) != 5
        LwEndTrip()   ; someone else's order replaced ours, or nothing left to watch
        return
    endIf
    Actor follower = LeadToTargetAlias.GetActorReference()   ; normally the player
    if !follower
        follower = PlayerRef
    endIf
    if leader.IsInCombat()
        RegisterForSingleUpdate(LwTick * 3.0)   ; the package yields to combat; check again after
        return
    endIf

    ; Arrived?
    bool leaderThere = LwSameSpace(leader, marker) && leader.GetDistance(marker) <= LwArriveUnits
    bool together = LwSameSpace(leader, follower)
    bool playerThere = together && LwSameSpace(follower, marker) && follower.GetDistance(marker) <= LwArriveUnits \
        && leader.GetDistance(follower) <= LwNearUnits
    if leaderThere || playerThere
        string place = _lwPlace
        string who = leader.GetDisplayName()
        Debug.Trace("Mantella Living World: " + who + " arrived at " + place + "; trip over")
        LwEndTrip()
        Debug.Notification(who + " has brought you to " + place + ".")
        EventInterface.AddMantellaEvent(who + " and the player arrived at " + place + ".")
        return
    endIf

    ; Doors: notice the one being led changing cells.
    Form playerSpace = LwSpaceOf(follower)
    float now = Utility.GetCurrentRealTime()
    if playerSpace != _lwPlayerSpace
        _lwPlayerSpace = playerSpace
        _lwPlayerDoorAt = now
    endIf

    if together
        _lwApart = 0
        float d = leader.GetDistance(follower)
        _lwWasNear = d <= LwNearUnits
        if d > LwFarUnits
            _lwFar += 1
            if _lwFar >= LwFarGiveUp
                LwGiveUp(leader)
                return
            endIf
        else
            _lwFar = 0
        endIf
    else
        _lwApart += 1
        bool playerUsedDoor = now - _lwPlayerDoorAt <= 15.0
        if _lwWasNear && _lwCatchUps < LwMaxCatchUps && ((playerUsedDoor && _lwApart >= LwCatchUpAfter) || _lwApart >= LwStuckAfter)
            ; The player went through and the leader is on the wrong side (or went back for them):
            ; bring the leader through instead of letting them swap sides again.
            _lwCatchUps += 1
            _lwApart = 0
            _lwPlayerDoorAt = -100.0
            Debug.Trace("Mantella Living World: " + leader.GetDisplayName() + " catches up with the player through the door (" + _lwCatchUps + ")")
            leader.MoveTo(follower)
            leader.EvaluatePackage()
        elseIf _lwApart >= LwApartGiveUp
            LwGiveUp(leader)
            return
        endIf
    endIf
    RegisterForSingleUpdate(LwTick)
endEvent

Function LwGiveUp(Actor leader)
    string who = leader.GetDisplayName()
    string place = _lwPlace
    Debug.Trace("Mantella Living World: the player stopped following " + who + "; trip to " + place + " dropped")
    LwEndTrip()
    Debug.Notification(who + " stopped leading you to " + place + ".")
    EventInterface.AddMantellaEvent(who + " stopped leading the player to " + place + " because the player did not follow.")
EndFunction