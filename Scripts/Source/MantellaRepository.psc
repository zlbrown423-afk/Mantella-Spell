Scriptname MantellaRepository extends Quest Conditional

Actor Property PlayerRef Auto

Spell property MantellaSpell auto
Spell property MantellaRemoveNpcSpell auto
Spell Property MantellaEndSpell auto
;Faction Property giafac_Sitters  Auto ;gia
;Faction Property giafac_Sleepers  Auto ;gia
;Faction Property giafac_talktome  Auto ;gia
Faction Property giafac_AllowFollower  Auto ;gia
Faction Property giafac_AllowAnger  Auto ;gia
Faction Property fac_AllowInventory  Auto
Faction Property giafac_AllowDialogue  Auto ;gia
Faction Property giafac_Following  Auto ;gia
Faction Property giafac_Mantella  Auto ;gia
Faction Property MantellaCombatTeamA  Auto
Faction Property MantellaCombatTeamB  Auto
quest property gia_FollowerQst auto ;gia
MantellaListenerScript Property ListenerScript Auto


bool property microphoneEnabled auto
bool property useHotkeyToStartMic auto
float property MantellaEffectResponseTimer auto
bool property showReminderMessages auto

int property MantellaStartHotkey auto
; LIVINGWORLD PATCH: save-load timeline for the Living World server (kept in the save)
int property LivingWorldTimelineId auto        ; timeline this save is on (0 until the server answers)
int property LivingWorldLoadNonce auto         ; random number picked at each load (0 = no load seen yet)
float property LivingWorldLoadedGameDays auto  ; game days at that load
string property LivingWorldWorldKey auto       ; LIVINGWORLD PATCH: the world (memories) this save belongs to, kept across a rename ("" until the server names one)
int property MantellaListenerTextHotkey auto
int property MantellaEndHotkey auto
int property MantellaCustomGameEventHotkey auto
int property MantellaRadiantHotkey auto

bool property showDialogueItems auto Conditional

bool property radiantEnabled auto
bool property approachEnabled auto
float property radiantDistance auto
float property radiantFrequency auto
int property triggerRatio auto
bool property showRadiantDialogueMessages auto

string property playerCharacterDescription1 auto
string property playerCharacterDescription2 auto
bool property playerCharacterUsePlayerDescription2 auto
bool property playerCharacterVoicePlayerInput auto
string property playerCharacterVoiceModel auto
bool property playerTrackingUsePCName auto


bool property playerTrackingOnItemAdded auto
bool property playerTrackingOnItemRemoved auto
bool property playerTrackingOnSpellCast auto
bool property playerTrackingOnHit auto
bool property playerTrackingOnObjectEquipped auto
bool property playerTrackingOnObjectUnequipped auto
bool property playerTrackingOnPlayerBowShot auto
bool property playerTrackingOnSit auto
bool property playerTrackingOnGetUp auto

bool property playerTrackingOnLocationChange auto
bool property playerTrackingOnTimeChange auto
bool property playerTrackingOnWeatherChange auto


bool property playerEquipmentBody auto
bool property playerEquipmentHead auto
bool property playerEquipmentHands auto
bool property playerEquipmentFeet auto
bool property playerEquipmentAmulet auto
bool property playerEquipmentRightHand auto
bool property playerEquipmentLeftHand auto

int property worldID auto


bool property targetTrackingItemAdded auto 
bool property targetTrackingItemRemoved auto
bool property targetTrackingOnSpellCast auto
bool property targetTrackingOnHit auto
bool property targetTrackingOnCombatStateChanged auto
bool property targetTrackingOnObjectEquipped auto
bool property targetTrackingOnObjectUnequipped auto
bool property targetTrackingOnSit auto
bool property targetTrackingOnGetUp auto
bool property targetTrackingAngerState auto

bool property targetEquipmentBody auto
bool property targetEquipmentHead auto
bool property targetEquipmentHands auto
bool property targetEquipmentFeet auto
bool property targetEquipmentAmulet auto
bool property targetEquipmentRightHand auto
bool property targetEquipmentLeftHand auto

bool property enableVanillaDialogueAwareness auto
;bool property followingNPCsit auto ;gia
;bool property followingNPCsleep auto ;gia
;bool property NPCstopandTalk auto ;gia
bool property NPCPackage auto Conditional
;bool property NPCForgive auto ;gia
bool property NPCDialogue auto ;gia

bool property NPCdebugSelectModeEnabled auto
; bool restartMantellaExe = False
int property HttpPort auto


event OnInit()
    assignDefaultSettings(0, true)
    ; end any existing conversation that may still be running on the Mantella server when the mod is loaded
    (Quest.GetQuest("MantellaConversation") as MantellaConversation).EndConversation() 
endEvent

; event OnUpdate()
;     If (restartMantellaExe)
;         restartMantellaExe = false
;         MantellaLauncher.LaunchMantellaExe()
;     EndIf
; endEvent

; lastVersion is the previous MCM version number defined in 'MantellaMCM.psc' before the new update is applied.
; Whenever a new repository value OR a new MCM setting is added, up the MCM version number returned by `ManatellaMCM.GetVersion()`
; and add the corresponding default value here in a block corresponding to the version number like the examples below
; Doing it like this will only assign the defaul values to settings that haven't been initialised prior.
function assignDefaultSettings(int lastVersion, bool isFirstInit = false)
    If (lastVersion < 7 || isFirstInit)
        enableVanillaDialogueAwareness = true
    EndIf
    If (lastVersion < 5 || isFirstInit)
        showReminderMessages = true
    EndIf
    If (lastVersion < 4 || isFirstInit)
        playerTrackingOnTimeChange = true
        playerTrackingOnWeatherChange = true
    EndIf
    If (lastVersion < 3 || isFirstInit)
        worldID = 1
    EndIf
    If (lastVersion < 2 || isFirstInit)
        showRadiantDialogueMessages = true
    EndIf
    If (lastVersion < 1 || isFirstInit)
        microphoneEnabled = true
        useHotkeyToStartMic = false
        MantellaEffectResponseTimer = 180

        MantellaStartHotkey = -1
        MantellaListenerTextHotkey = 35
        BindPromptHotkey(MantellaListenerTextHotkey)
        MantellaEndHotkey = -1
        MantellaCustomGameEventHotkey = -1
        MantellaRadiantHotkey = -1

        showDialogueItems = true

        radiantEnabled = false
        approachEnabled = false
        radiantDistance = 20
        radiantFrequency = 10
        triggerRatio = 50


        playerCharacterDescription1 = ""
        playerCharacterDescription2 = ""
        playerCharacterUsePlayerDescription2 = false
        playerCharacterVoicePlayerInput = false
        playerCharacterVoiceModel = ""
        playerTrackingUsePCName = true

        
        playerTrackingOnItemAdded = true
        playerTrackingOnItemRemoved = true
        playerTrackingOnSpellCast = true
        playerTrackingOnHit = true
        playerTrackingOnLocationChange = true
        playerTrackingOnObjectEquipped = true
        playerTrackingOnObjectUnequipped = true
        playerTrackingOnPlayerBowShot = true
        playerTrackingOnSit = true
        playerTrackingOnGetUp = true

        playerEquipmentBody = true
        playerEquipmentHead = true
        playerEquipmentHands = true
        playerEquipmentFeet = true
        playerEquipmentAmulet = true
        playerEquipmentRightHand = true
        playerEquipmentLeftHand = true


        targetTrackingItemAdded = true
        targetTrackingItemRemoved = true
        targetTrackingOnSpellCast = true
        targetTrackingOnHit = true
        targetTrackingOnCombatStateChanged = true
        targetTrackingOnObjectEquipped = true
        targetTrackingOnObjectUnequipped = true
        targetTrackingOnSit = true
        targetTrackingOnGetUp = true
        targetTrackingAngerState = true

        targetEquipmentBody = true
        targetEquipmentHead = true
        targetEquipmentHands = true
        targetEquipmentFeet = true
        targetEquipmentAmulet = true
        targetEquipmentRightHand = true
        targetEquipmentLeftHand = true
        

	;followingNPCsit = false ;gia
	;followingNPCsleep = false ;gia
	;NPCstopandTalk = false ;gia
    NPCPackage = true
	;NPCForgive = false ;gia
	NPCDialogue = True ;gia
    
    NPCdebugSelectModeEnabled = false

        HttpPort = 4999
    EndIf
endFunction

function BindStartAddHotkey(int keyCode)
    ;used by the MCM_GeneralSettings when updating the start hotkey KeyMapChange
    UnregisterForKey(MantellaStartHotkey)
    MantellaStartHotkey=keyCode
    RegisterForKey(keyCode)
endfunction

function BindPromptHotkey(int keyCode)
    ;used by the MCM_GeneralSettings when updating the prompt hotkey KeyMapChange
    UnregisterForKey(MantellaListenerTextHotkey)
    MantellaListenerTextHotkey=keyCode
    RegisterForKey(keyCode)
endfunction

function BindEndHotkey(int keyCode)
    ;used by the MCM_GeneralSettings when updating the end hotkey KeyMapChange
    UnregisterForKey(MantellaEndHotkey)
    MantellaEndHotkey=keyCode
    RegisterForKey(keyCode)
endfunction

function BindCustomGameEventHotkey(int keyCode)
    ;used by the MCM_GeneralSettings when updating the custom game event hotkey KeyMapChange
    UnregisterForKey(MantellaCustomGameEventHotkey)
    MantellaCustomGameEventHotkey=keyCode
    RegisterForKey(keyCode)
endfunction

function BindRadiantHotkey(int keyCode)
    ;used by the MCM_GeneralSettings when updating the prompt hotkey KeyMapChange
    UnregisterForKey(MantellaRadiantHotkey)
    MantellaRadiantHotkey=keyCode
    RegisterForKey(keyCode)
endfunction

bool Function IsVR()
    return Debug.GetVersionNumber() == "1.4.15.0"
EndFunction

bool function restartMantellaExe()
    ; restartMantellaExe = true
    ; RegisterForSingleUpdate(1)
    MantellaLauncher.LaunchMantellaExe() 
    ;Note: If you need to debug this call to the SKSE plugin, you need to call it from the commented out single update above instead
    ;      or the VS debugger will crash (due to being called from the MCM thread?).
    ;      Check the corresponding commented out OnUpdate at the beginning of the script.
EndFunction

Event OnKeyDown(int KeyCode)
    ;this function was previously in MantellaListener Script back in Mantella 0.9.2
	;this ensures the right key is pressed and only activated while not in menu mode
    if !utility.IsInMenuMode()
        if KeyCode == MantellaStartHotkey
            Actor targetRef = (Game.GetCurrentCrosshairRef() as actor)            
            if (targetRef) ;If we have a target under the crosshair, cast sepll on it
                MantellaSpell.cast(PlayerRef, targetRef)
                ;Utility.Wait(0.5)
            Else
                ListenerScript.StartGroupConversation()
            endIf        
        elseIf KeyCode == MantellaListenerTextHotkey
            If(!microphoneEnabled) ;Otherwise, try to open player text input if microphone is off
                MantellaConversation conversation = Quest.GetQuest("MantellaConversation") as MantellaConversation
                if(conversation.IsRunning())
                    conversation.GetPlayerTextInput()
                endIf
            elseIf (useHotkeyToStartMic)
                MantellaConversation conversation = Quest.GetQuest("MantellaConversation") as MantellaConversation
                if(conversation.IsRunning())
                    conversation.sendRequestForVoiceTranscribe()
                endIf
            endIf
        elseIf KeyCode == MantellaEndHotkey
            Actor targetRef = (Game.GetCurrentCrosshairRef() as actor)            
            if (targetRef) ;If we have a target under the crosshair, cast sepll on it
                MantellaRemoveNpcSpell.cast(PlayerRef, targetRef)
            else
                MantellaEndSpell.cast(PlayerRef)
            endIf
        elseIf KeyCode == MantellaCustomGameEventHotkey
            MantellaConversation conversation = Quest.GetQuest("MantellaConversation") as MantellaConversation
            if(conversation.IsRunning())
                UIExtensions.InitMenu("UITextEntryMenu")
                UIExtensions.OpenMenu("UITextEntryMenu")
                string gameEventEntry = UIExtensions.GetMenuResultString("UITextEntryMenu")
                if (gameEventEntry && gameEventEntry != "")
                    gameEventEntry = gameEventEntry+"\n"
                    conversation.AddIngameEvent(gameEventEntry)
                endIf
            endIf
        elseIf (KeyCode == LwArousalKey && LwArousalKey > 0) ; LIVINGWORLD PATCH: arousal (rapid taps raise it)
            LwArousalTap()
        elseIf KeyCode == MantellaRadiantHotkey
            radiantEnabled =! radiantEnabled
            if radiantEnabled == True
                Debug.Notification("Radiant Dialogue enabled.")
            else
                Debug.Notification("Radiant Dialogue disabled.")
            endIf
        endIf
    endIf
endEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LIVINGWORLD PATCH: perception                                                                      ;
; The player grabbing an NPC (HIGGS grab/drop events) and eating or drinking (HIGGS hand-to-mouth or ;
; the inventory) become text records queued here, saved with the game, and sent with the next       ;
; Mantella request (MantellaConversation.BuildContext). The Living World server turns each record    ;
; into one world event and a separate memory for the NPC grabbed and for each NPC who saw it.       ;
; Record format: see livingworld/perception/records.py in MantellaExtension.                        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

string[] property LivingWorldEvents auto hidden     ; records waiting to be sent
int property LivingWorldEventCounter auto hidden    ; makes each record key unique within a load
bool property LivingWorldPerceptionOn = true auto hidden
float property LivingWorldWitnessScanMeters = 25.0 auto hidden  ; witnesses further than this are not even sent
int property LivingWorldMaxQueuedEvents = 40 auto hidden

Actor _lwLeftHeld
Actor _lwRightHeld
float _lwLeftSince
float _lwRightSince
string _lwLeftNode
string _lwRightNode
string _lwLeftArea
string _lwRightArea
float _lwPx
float _lwPy
float _lwPz
Form _lwLastMouthForm
float _lwLastMouthTime
float property LivingWorldMinGrabSeconds = 0.3 auto hidden     ; shorter holds are HIGGS flicker, not a grab
float property LivingWorldGrabLineCooldown = 5.0 auto hidden    ; seconds between "X grabbed Y" lines for one person
Actor _lwLastSaidTarget
float _lwLastSaidAt
bool _lwAreaBusy = false

; LIVINGWORLD PATCH: reactions on the spot. Outside a conversation, someone the player grabs against their will
; speaks up (a Mantella conversation starts with them), and a guard who saw it comes over to step in. The server
; decides what they say (guard/peace.py: a warning first, an arrest once guards have had to step in before).
bool property LivingWorldReactOn = true auto hidden
float property LivingWorldReactHoldSeconds = 5.0 auto hidden   ; a hold this long gets a reaction while still held
float property LivingWorldReactMinSeconds = 2.0 auto hidden    ; shorter, on a shoulder or arm: let it pass
float property LivingWorldReactCooldown = 60.0 auto hidden     ; the same person reacts again only after this
float property LivingWorldReactAnyCooldown = 15.0 auto hidden  ; and nobody reacts within this of the last one
float property LivingWorldReactGuardMeters = 20.0 auto hidden  ; a guard further than this did not really see it
Actor _lwSawGuard
float _lwSawGuardMeters
Actor _lwPendingTarget
Actor _lwPendingGuard
string _lwPendingArea
float _lwPendingSeconds
bool _lwPendingHeld
Actor _lwReactedLast
float _lwReactedLastAt = -1000.0
float _lwReactedAnyAt = -1000.0
bool _lwLeftReacted
bool _lwRightReacted

; Walking away ends the conversation: Mantella only ends one when the player says goodbye or uses the
; end spell, so walking off left it running, and the next NPC the player spoke to was added to it.
bool property LivingWorldWalkAwayOn = true auto hidden
float property LivingWorldWalkAwayMeters = 12.0 auto hidden   ; further than this from every NPC in it
float property LivingWorldWalkAwaySeconds = 4.0 auto hidden   ; for this long
int _lwWalkWatch = 0

; Called on every game load (HIGGS registrations are not kept in the save).
function LivingWorldRegisterPerception()
    _lwLeftHeld = None
    _lwRightHeld = None
    _lwAreaBusy = false
    _lwPendingTarget = None
    RegisterForModEvent("LivingWorld_ReactNow", "OnLivingWorldReactNow")       ; reactions on the spot, each
    RegisterForModEvent("LivingWorld_HoldCheck", "OnLivingWorldHoldCheck")     ; on its own stack, off HIGGS's
    RegisterForModEvent("LivingWorld_WalkAway", "OnLivingWorldWalkAway")       ; end a conversation the player left
    RegisterForModEvent("MantellaLivingWorld_StayOne", "OnLwStayOne")           ; walk a talker back (bards, schedules)
    LivingWorldWatchWalkAway() ; a conversation running across a save load is watched again
    if (SKSE.GetPluginVersion("HIGGS") > 0)
        HiggsVR.RegisterForGrabEvent(self)
        HiggsVR.RegisterForDropEvent(self)
        HiggsVR.RegisterForConsumeEvent(self)
        Debug.Trace("Mantella Living World: listening for HIGGS grab, drop and consume events")
    else
        Debug.Trace("Mantella Living World: HIGGS not found; grab perception is off")
    endIf
    LivingWorldRegisterAttireAndDrink()
    LivingWorldRegisterActions()
    LwRegisterReputation() ; LIVINGWORLD PATCH: reputation (S2)
    LwRegisterIntimacy() ; LIVINGWORLD PATCH: intimate scenes (OStim)
endFunction

Event OnObjectGrabbed(ObjectReference akRef, bool abIsLeft)
    Actor target = akRef as Actor
    ; children are left out of Living World entirely
    if (!LivingWorldPerceptionOn || !target || target == PlayerRef || target.IsDead() || target.IsChild())
        return
    endIf
    if (_lwScAny && LwSceneTouch(target))
        return   ; hands on a partner during an intimate scene are part of the scene (counted there)
    endIf
    ; the same person grabbed again by the same hand without a drop in between: one hold, not two
    if ((abIsLeft && _lwLeftHeld == target) || (!abIsLeft && _lwRightHeld == target))
        LwProbeCount(abIsLeft, 0, 1)
        return
    endIf
    float now = Utility.GetCurrentRealTime()
    ; a hand that grabs again without a drop event: close the previous grab first
    if (abIsLeft && _lwLeftHeld)
        LivingWorldEndHold(_lwLeftHeld, true, now)
    elseIf (!abIsLeft && _lwRightHeld)
        LivingWorldEndHold(_lwRightHeld, false, now)
    endIf
    ; The hold starts now, before anything slow, so a drop that arrives while the area is still being
    ; worked out finds a consistent hold to close.
    if (abIsLeft)
        _lwLeftHeld = target
        _lwLeftSince = now
        _lwLeftNode = ""
        _lwLeftArea = ""
        _lwLeftReacted = false
    else
        _lwRightHeld = target
        _lwRightSince = now
        _lwRightNode = ""
        _lwRightArea = ""
        _lwRightReacted = false
    endIf
    if (LivingWorldReactOn)
        SendModEvent("LivingWorld_HoldCheck") ; still holding on in a few seconds: they speak up
    endIf
    LwProbeHoldStarted(abIsLeft, target, now, 0.0)
    string node = HiggsVR.GetGrabbedNodeName(abIsLeft)
    if (abIsLeft && _lwLeftHeld == target && _lwLeftSince == now)
        _lwLeftNode = node
    elseIf (!abIsLeft && _lwRightHeld == target && _lwRightSince == now)
        _lwRightNode = node
    endIf
    ; Working out the body area reads bone positions, and every such read waits for the game's main thread.
    ; Only one at a time: while one runs, another grab is recorded without an area (the server then uses the
    ; node name). A pile of these waiting behind each other is what froze the game for 30 s (2026-11-08).
    if (_lwAreaBusy)
        if (abIsLeft)
            _lwPLNoArea += 1
        else
            _lwPRNoArea += 1
        endIf
        return
    endIf
    _lwAreaBusy = true
    string area = LivingWorldGrabArea(target, abIsLeft, node)
    _lwAreaBusy = false
    if (abIsLeft && _lwLeftHeld == target && _lwLeftSince == now)
        _lwLeftArea = area
        _lwPLGrabMs = (Utility.GetCurrentRealTime() - now) * 1000.0
    elseIf (!abIsLeft && _lwRightHeld == target && _lwRightSince == now)
        _lwRightArea = area
        _lwPRGrabMs = (Utility.GetCurrentRealTime() - now) * 1000.0
    endIf
EndEvent

Event OnObjectDropped(ObjectReference akRef, bool abIsLeft)
    Actor target = akRef as Actor
    if (!target)
        return
    endIf
    float now = Utility.GetCurrentRealTime()
    if ((abIsLeft && _lwLeftHeld == target) || (!abIsLeft && _lwRightHeld == target))
        LivingWorldEndHold(target, abIsLeft, now)
    endIf
EndEvent

; A hold ends: record it (unless it was too short to be a real grab) and report its timing.
function LivingWorldEndHold(Actor target, bool abIsLeft, float now)
    LwProbeCount(abIsLeft, 1, 0)
    float seconds
    if (abIsLeft)
        _lwLeftHeld = None
        seconds = now - _lwLeftSince
        if (seconds < 0.0)   ; this drop's clock was read before the hold it closes began
            now = _lwLeftSince
            seconds = 0.0
        endIf
        if (seconds >= LivingWorldMinGrabSeconds)
            LivingWorldRecordGrab(target, _lwLeftNode, _lwLeftArea, "L", seconds)
        else
            _lwPLShort += 1
        endIf
    else
        _lwRightHeld = None
        seconds = now - _lwRightSince
        if (seconds < 0.0)
            now = _lwRightSince
            seconds = 0.0
        endIf
        if (seconds >= LivingWorldMinGrabSeconds)
            LivingWorldRecordGrab(target, _lwRightNode, _lwRightArea, "R", seconds)
        else
            _lwPRShort += 1
        endIf
    endIf
    LwProbeHoldEnded(abIsLeft, target, now)
endFunction

Event OnObjectConsumed(Form akForm, bool abIsLeft)
    _lwLastMouthForm = akForm
    _lwLastMouthTime = Utility.GetCurrentRealTime()
    LivingWorldConsumed(PlayerRef, akForm, "higgs_mouth")
EndEvent

; Also called by MantellaListenerScript.OnObjectEquipped for food, drink and potions used from the inventory.
function LivingWorldConsumed(Actor consumer, Form item, string via)
    Potion p = item as Potion
    if (!LivingWorldPerceptionOn || !p || p.IsPoison() || !consumer || consumer.IsChild())
        return
    endIf
    ; HIGGS eating also equips the item: count it once
    if (via == "equip" && item == _lwLastMouthForm && Utility.GetCurrentRealTime() - _lwLastMouthTime < 3.0)
        return
    endIf
    string foodFlag = "0"
    if (p.IsFood())
        foodFlag = "1"
    endIf
    string rec = LivingWorldHeader("consume") + "|actor=" + LivingWorldActorField(consumer) + "|item=" + item.GetName() + "|item_form=" + item.GetFormID() + "|food=" + foodFlag + "|via=" + via + "|qty=1"
    rec += LivingWorldWitnesses(consumer, None)
    LivingWorldQueue(rec)
endFunction

function LivingWorldRecordGrab(Actor target, string node, string area, string hand, float seconds)
    if (_lwScAny && LwSceneWithPlayer(target))
        return   ; part of an intimate scene, not a grab
    endIf
    string rec = LivingWorldHeader("grab") + "|actor=" + LivingWorldActorField(PlayerRef) + "|target=" + LivingWorldActorField(target) + "|node=" + node + "|area=" + area + "|hand=" + hand + "|dur=" + seconds + "|trank=" + target.GetRelationshipRank(PlayerRef)
    _lwSawGuard = None
    _lwSawGuardMeters = 1000.0
    rec += LivingWorldWitnesses(PlayerRef, target)
    LivingWorldQueue(rec)
    bool reacted = (hand == "L" && _lwLeftReacted) || (hand == "R" && _lwRightReacted)
    if (!reacted)
        LivingWorldMaybeReact(target, area, seconds, false, _lwSawGuard)
    endIf
    ; let a running conversation react straight away, as Mantella's own events do.
    ; Never the raw node name: "NPC Spine1 [Spn1]" made NPCs say they were grabbed by the spine.
    string part = area
    if (part == "")
        part = "body"
    endIf
    ; at most one such line per person every few seconds, however often HIGGS lets go and grabs again
    float now = Utility.GetCurrentRealTime()
    if (target != _lwLastSaidTarget || now - _lwLastSaidAt >= LivingWorldGrabLineCooldown)
        _lwLastSaidTarget = target
        _lwLastSaidAt = now
        ListenerScript.AddIngameEventToConversation(PlayerRef.GetDisplayName() + " grabbed " + LivingWorldFog.RealName(target) + " by the " + part + " for " + (seconds as int) + " seconds.")
    endIf
endFunction

; LIVINGWORLD PATCH: reactions on the spot (see the properties above). Rules only, here in the game: a quick hand on
; a shoulder or an arm passes; a hold of a few seconds, a long hold, or a hand on the face, neck, chest, hips or
; backside gets a reaction. People with a close bond (relationship rank 3+) only react to the sensitive or the long.
bool function LivingWorldSensitiveArea(string area)
    return StringUtil.Find(area, "face") >= 0 || StringUtil.Find(area, "head") >= 0 || StringUtil.Find(area, "neck") >= 0 || StringUtil.Find(area, "chest") >= 0 || StringUtil.Find(area, "hips") >= 0 || StringUtil.Find(area, "backside") >= 0
endFunction

function LivingWorldMaybeReact(Actor target, string area, float seconds, bool stillHeld, Actor guard)
    if (!LivingWorldReactOn || !target || target.IsDead() || target.IsChild() || target.IsInCombat() || PlayerRef.IsInCombat())
        return
    endIf
    if (ListenerScript.conversation.IsRunning() || _lwPendingTarget)
        return   ; in a conversation the "X grabbed Y" line already lets them react
    endIf
    if (_lwScAny && LwSceneWithPlayer(target))
        return   ; the player's partner in an intimate scene does not pull away from it
    endIf
    bool sensitive = LivingWorldSensitiveArea(area)
    bool isLong = seconds >= LivingWorldReactHoldSeconds
    if (!sensitive && !isLong && seconds < LivingWorldReactMinSeconds)
        return
    endIf
    if (target.GetRelationshipRank(PlayerRef) >= 3 && !sensitive && seconds < 20.0)
        return
    endIf
    float now = Utility.GetCurrentRealTime()
    if (now - _lwReactedAnyAt < LivingWorldReactAnyCooldown || (target == _lwReactedLast && now - _lwReactedLastAt < LivingWorldReactCooldown))
        return
    endIf
    _lwPendingTarget = target
    _lwPendingGuard = None
    if (guard && guard != target && (sensitive || isLong))
        _lwPendingGuard = guard
    endIf
    _lwPendingArea = area
    _lwPendingSeconds = seconds
    _lwPendingHeld = stillHeld
    SendModEvent("LivingWorld_ReactNow") ; start it outside the HIGGS event
endFunction

Event OnLivingWorldReactNow(string eventName, string strArg, float numArg, Form sender)
    if (_lwPendingTarget)
        LivingWorldReactNow()
    endIf
EndEvent

; a hand still holding someone long enough: they speak up while held
; Called when a conversation starts. Each call starts a fresh watch; an older one sees the newer token and stops.
function LivingWorldWatchWalkAway()
    LwStayReset()
    if (LivingWorldWalkAwayOn || LivingWorldStayOn)
        _lwWalkWatch += 1
        SendModEvent("LivingWorld_WalkAway", "", _lwWalkWatch as float)
    endIf
endFunction

Event OnLivingWorldWalkAway(string eventName, string strArg, float numArg, Form sender)
    int token = numArg as int
    MantellaConversation conv = ListenerScript.conversation
    float away = 0.0
    while (token == _lwWalkWatch && conv.IsRunning())
        Utility.Wait(1.0)
        if (LivingWorldStayOn && conv.IsPlayerInConversation())
            LwKeepTalkersClose(conv)
        endIf
        if (LivingWorldWalkAwayOn && conv.IsPlayerInConversation() && LivingWorldPlayerLeft(conv))
            away += 1.0
            if (away >= LivingWorldWalkAwaySeconds && token == _lwWalkWatch && conv.IsRunning())
                _lwWalkWatch += 1 ; this watch is done
                if (_lwStayGaveUp)
                    Debug.Notification(_lwStayGaveUp.GetDisplayName() + " wandered off. Conversation ending...")
                else
                    Debug.Notification("You walked away. Conversation ending...")
                endIf
                conv.EndConversation()
                return
            endIf
        else
            away = 0.0
        endIf
    endWhile
EndEvent

; True when every NPC in the conversation is out of earshot: far away, in another cell, or gone.
bool function LivingWorldPlayerLeft(MantellaConversation conv)
    int n = conv.Participants.GetSize()
    int i = 0
    bool anyNpc = false
    while (i < n)
        Actor a = conv.Participants.GetAt(i) as Actor
        if (a && a != PlayerRef)
            anyNpc = true
            if (!a.IsDead() && a.GetParentCell() && a.GetParentCell().IsAttached() && a.GetDistance(PlayerRef) / 71.0210 <= LivingWorldWalkAwayMeters)
                return false
            endIf
        endIf
        i += 1
    endWhile
    return anyNpc
endFunction

; True when the target is far from every NPC already in the conversation (the player has moved on).
bool function LivingWorldFarFromConversation(MantellaConversation conv, Actor target)
    if (!LivingWorldWalkAwayOn || !target || !conv.IsPlayerInConversation())
        return false
    endIf
    int n = conv.Participants.GetSize()
    int i = 0
    while (i < n)
        Actor a = conv.Participants.GetAt(i) as Actor
        if (a && a != PlayerRef && a != target && a.GetParentCell() && a.GetParentCell().IsAttached() && a.GetDistance(target) / 71.0210 <= LivingWorldWalkAwayMeters)
            return false
        endIf
        i += 1
    endWhile
    return true
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LIVINGWORLD PATCH: keep talkers in the conversation                                                ;
; Vanilla AI can pull an NPC out of a conversation mid-sentence: the bard's audience (the bard starts ;
; a song and the inn's patrons go and listen) outranks Mantella's "stop to talk" package, and so can  ;
; schedules. Each second of a conversation (on the walk-away watch) every NPC in it is checked: when  ;
; they have walked off from where they stood and are now further from the player, for 2 s they are   ;
; let go from the bard's audience; after 4 s they walk back to the player, at most                    ;
; LivingWorldStayReturns times per conversation. The player walking away is not this (the NPC stays  ;
; put), and NPCs under a Living World order (sit, go there, fetch drinks), on a Mantella action      ;
; (follow, move to, travel...), following the player or fighting are left alone.                     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

bool property LivingWorldStayOn = true auto hidden
float property LivingWorldStayDriftMeters = 3.0 auto hidden   ; moved this far from where they stood
int property LivingWorldStayReturns = 3 auto hidden
Actor[] _lwStayActors
float[] _lwStayBase       ; their distance to the player when they last stood still
float[] _lwStayX
float[] _lwStayY
int[] _lwStayFar          ; seconds in a row spent drifting off
int[] _lwStayBack         ; walk-backs this conversation
Actor _lwStayGaveUp       ; out of walk-backs: if the conversation ends now, they left, not the player

function LwStayReset()
    _lwStayActors = new Actor[8]
    _lwStayBase = new float[8]
    _lwStayX = new float[8]
    _lwStayY = new float[8]
    _lwStayFar = new int[8]
    _lwStayBack = new int[8]
    _lwStayGaveUp = None
endFunction

function LwKeepTalkersClose(MantellaConversation conv)
    if (!_lwStayActors)
        LwStayReset()
    endIf
    Faction onAction = Game.GetFormFromFile(0x223451, "Mantella.esp") as Faction   ; MantellaFunctionSourceFaction
    int n = conv.Participants.GetSize()
    int i = 0
    while (i < n)
        Actor a = conv.Participants.GetAt(i) as Actor
        if (a && a != PlayerRef && LwStayCandidate(a, onAction))
            float d = a.GetDistance(PlayerRef) / 71.0210
            int slot = _lwStayActors.Find(a)
            if (slot < 0)
                slot = _lwStayActors.Find(None)
                if (slot >= 0)
                    _lwStayActors[slot] = a
                    LwStayAnchor(slot, a, d)
                    _lwStayBack[slot] = 0
                endIf
            else
                float dx = a.GetPositionX() - _lwStayX[slot]
                float dy = a.GetPositionY() - _lwStayY[slot]
                float moved = Math.sqrt(dx * dx + dy * dy) / 71.0210
                if (moved > LivingWorldStayDriftMeters && d > _lwStayBase[slot] + 1.0)
                    _lwStayFar[slot] = _lwStayFar[slot] + 1
                    if (_lwStayFar[slot] == 2)
                        LwReleaseFromBardAudience(a)
                        a.EvaluatePackage()
                    elseIf (_lwStayFar[slot] >= 4)
                        _lwStayFar[slot] = 0
                        if (_lwStayBack[slot] < LivingWorldStayReturns)
                            _lwStayBack[slot] = _lwStayBack[slot] + 1
                            Debug.Trace("Mantella Living World: " + a.GetDisplayName() + " was pulled out of the conversation; walking back (" + _lwStayBack[slot] + ")")
                            int handle = ModEvent.Create("MantellaLivingWorld_StayOne")
                            if (handle)
                                ModEvent.PushForm(handle, a)
                                ModEvent.Send(handle)
                            endIf
                        else
                            _lwStayGaveUp = a
                        endIf
                    endIf
                elseIf (d <= _lwStayBase[slot] + 1.0)
                    LwStayAnchor(slot, a, d)   ; standing with the player (or the player came over): the new spot
                endIf
            endIf
        endIf
        i += 1
    endWhile
endFunction

function LwStayAnchor(int slot, Actor a, float d)
    _lwStayBase[slot] = d
    _lwStayX[slot] = a.GetPositionX()
    _lwStayY[slot] = a.GetPositionY()
    _lwStayFar[slot] = 0
endFunction

bool function LwStayCandidate(Actor a, Faction onAction)
    if (a.IsDead() || a.IsInCombat() || a.IsPlayerTeammate() || !a.Is3DLoaded())
        return false
    endIf
    if (_lwOrderActors && _lwOrderActors.Find(a) >= 0)
        return false   ; sitting down, going there, fetching drinks: our own orders
    endIf
    if (onAction && a.IsInFaction(onAction))
        return false   ; on a Mantella action (move to, travel, loot...)
    endIf
    return true
endFunction

; Vanilla's bard audience: the patrons a song pulls over. Letting go of their alias drops its package.
function LwReleaseFromBardAudience(Actor a)
    Quest audience = Quest.GetQuest("BardAudienceQuest")
    if (!audience || !audience.IsRunning())
        return
    endIf
    int n = audience.GetNumAliases()
    int i = 0
    while (i < n)
        ReferenceAlias ra = audience.GetNthAlias(i) as ReferenceAlias
        if (ra && ra.GetActorReference() == a)
            ra.Clear()
            Debug.Trace("Mantella Living World: let " + a.GetDisplayName() + " go from the bard's audience")
        endIf
        i += 1
    endWhile
endFunction

Event OnLwStayOne(Form npcForm)
    Actor a = npcForm as Actor
    if (!a || !ListenerScript.conversation.IsRunning())
        return
    endIf
    a.PathToReference(PlayerRef, 1.0)   ; latent, on its own event thread
    a.EvaluatePackage()                  ; back under Mantella's "stop to talk"
EndEvent

Event OnLivingWorldHoldCheck(string eventName, string strArg, float numArg, Form sender)
    Utility.Wait(LivingWorldReactHoldSeconds + 0.2)
    float now = Utility.GetCurrentRealTime()
    if (_lwLeftHeld && !_lwLeftReacted && now - _lwLeftSince >= LivingWorldReactHoldSeconds)
        _lwLeftReacted = true
        LivingWorldMaybeReact(_lwLeftHeld, _lwLeftArea, now - _lwLeftSince, true, None)
    elseIf (_lwRightHeld && !_lwRightReacted && now - _lwRightSince >= LivingWorldReactHoldSeconds)
        _lwRightReacted = true
        LivingWorldMaybeReact(_lwRightHeld, _lwRightArea, now - _lwRightSince, true, None)
    endIf
EndEvent

function LivingWorldReactNow()
    Actor target = _lwPendingTarget
    Actor guard = _lwPendingGuard
    string area = _lwPendingArea
    float seconds = _lwPendingSeconds
    bool held = _lwPendingHeld
    _lwPendingTarget = None
    _lwPendingGuard = None
    MantellaConversation conv = ListenerScript.conversation
    if (!target || target.IsDead() || conv.IsRunning())
        return
    endIf
    float now = Utility.GetCurrentRealTime()
    _lwReactedAnyAt = now
    _lwReactedLast = target
    _lwReactedLastAt = now
    string part = area
    if (part == "")
        part = "body"
    endIf
    LivingWorldQueue(LivingWorldHeader("react") + "|actor=" + LivingWorldActorField(target) + "|target=" + LivingWorldActorField(PlayerRef) + "|via=victim|area=" + area + "|dur=" + seconds)
    if (guard)
        LivingWorldQueue(LivingWorldHeader("react") + "|actor=" + LivingWorldActorField(guard) + "|target=" + LivingWorldActorField(PlayerRef) + "|via=guard|party=" + LivingWorldActorField(target) + "|area=" + area + "|dur=" + seconds)
    endIf
    string who = LivingWorldFog.RealName(target)
    string player = PlayerRef.GetDisplayName()
    string ev
    if (held)
        ev = player + " has hold of " + who + " by the " + part + " and will not let go. " + who + " speaks up about it right now."
    else
        ev = who + " pulls away from " + player + ", who just grabbed them by the " + part + " for " + (seconds as int) + " seconds. " + who + " speaks up about it right now."
    endIf
    Actor[] actors
    if (guard)
        actors = new Actor[3]
        actors[2] = guard
        ev += " " + LivingWorldFog.RealName(guard) + ", a guard, saw it and comes over to step in."
    else
        actors = new Actor[2]
    endIf
    actors[0] = PlayerRef
    actors[1] = target
    conv.Start()
    if (guard)
        Debug.Notification(guard.GetDisplayName() + " saw that and comes over.")
    else
        Debug.Notification(who + " reacts.")
    endIf
    conv.AddIngameEvent(ev)
    conv.StartConversation(actors)
    if (guard)
        conv.TriggerApproachMoveAction(guard)
    endIf
endFunction

; Where on the body the player's hand is: "left shoulder", "upper back", "stomach", "right thigh" ...
; HIGGS only names the ragdoll body it holds, and Skyrim's ragdoll has a few large spine bodies for the
; whole torso, so a hand on the shoulder, the waist, the chest or the back all came back as a spine.
; Instead: take the hand's position (first-person skeleton, which follows the VR controller), find the
; nearest bone segment of the NPC's skeleton, and for the torso tell front, back and side from the way
; the NPC faces. Returns "" when it cannot tell; the server then falls back to the node name.
string function LivingWorldGrabArea(Actor target, bool abIsLeft, string grabbedNode)
    if (!target.Is3DLoaded())
        return ""
    endIf
    string handNode = "NPC R Hand [RHnd]"
    string fingerNode = "NPC R Finger20 [RF20]"
    if (abIsLeft)
        handNode = "NPC L Hand [LHnd]"
        fingerNode = "NPC L Finger20 [LF20]"
    endIf
    ; one call per position: each call waits for the game's main thread (about a frame), so they add up
    float[] p = new float[3]
    if (!NetImmerse.GetNodeWorldPosition(PlayerRef, handNode, p, true))
        return ""
    endIf
    float hx = p[0]
    float hy = p[1]
    float hz = p[2]
    ; the hand node sits at the wrist: move to the palm, halfway to the middle finger
    if (NetImmerse.GetNodeWorldPosition(PlayerRef, fingerNode, p, true))
        hx = (hx + p[0]) / 2.0
        hy = (hy + p[1]) / 2.0
        hz = (hz + p[2]) / 2.0
    endIf

    string[] nodes = new string[20]
    nodes[0] = "NPC Pelvis [Pelv]"
    nodes[1] = "NPC Spine [Spn0]"
    nodes[2] = "NPC Spine1 [Spn1]"
    nodes[3] = "NPC Spine2 [Spn2]"
    nodes[4] = "NPC Neck [Neck]"
    nodes[5] = "NPC Head [Head]"
    nodes[6] = "NPC L Clavicle [LClv]"
    nodes[7] = "NPC L UpperArm [LUar]"
    nodes[8] = "NPC L Forearm [LLar]"
    nodes[9] = "NPC L Hand [LHnd]"
    nodes[10] = "NPC R Clavicle [RClv]"
    nodes[11] = "NPC R UpperArm [RUar]"
    nodes[12] = "NPC R Forearm [RLar]"
    nodes[13] = "NPC R Hand [RHnd]"
    nodes[14] = "NPC L Thigh [LThg]"
    nodes[15] = "NPC L Calf [LClf]"
    nodes[16] = "NPC L Foot [Lft ]"
    nodes[17] = "NPC R Thigh [RThg]"
    nodes[18] = "NPC R Calf [RClf]"
    nodes[19] = "NPC R Foot [Rft ]"
    ; Only the bones near the ragdoll body HIGGS holds: an arm, a leg, the head, or the torso (with the
    ; shoulders, where torso grabs often land). At most 9 bone reads instead of 20 checks and 60 reads.
    bool[] want = LivingWorldBonesNear(grabbedNode)
    float[] nx = new float[20]
    float[] ny = new float[20]
    float[] nz = new float[20]
    bool[] has = new bool[20]
    int i = 0
    while (i < 20)
        if (want[i] && NetImmerse.GetNodeWorldPosition(target, nodes[i], p, false))
            has[i] = true
            nx[i] = p[0]
            ny[i] = p[1]
            nz[i] = p[2]
        endIf
        i += 1
    endWhile

    ; bone segments: from node, to node (-1: 18 units above the head node, -2: past the hand, -3: the
    ; node itself), and what to call it
    int[] sa = new int[20]
    int[] sb = new int[20]
    string[] sk = new string[20]
    sa[0] = 0
    sb[0] = 1
    sk[0] = "pelvis"
    sa[1] = 1
    sb[1] = 2
    sk[1] = "midsection"
    sa[2] = 2
    sb[2] = 3
    sk[2] = "midsection"
    sa[3] = 3
    sb[3] = 4
    sk[3] = "upper torso"
    sa[4] = 4
    sb[4] = 5
    sk[4] = "neck"
    sa[5] = 5
    sb[5] = -1
    sk[5] = "head"
    sa[6] = 6
    sb[6] = 7
    sk[6] = "left shoulder"
    sa[7] = 7
    sb[7] = 8
    sk[7] = "left upper arm"
    sa[8] = 8
    sb[8] = 9
    sk[8] = "left forearm"
    sa[9] = 9
    sb[9] = -2
    sk[9] = "left hand"
    sa[10] = 10
    sb[10] = 11
    sk[10] = "right shoulder"
    sa[11] = 11
    sb[11] = 12
    sk[11] = "right upper arm"
    sa[12] = 12
    sb[12] = 13
    sk[12] = "right forearm"
    sa[13] = 13
    sb[13] = -2
    sk[13] = "right hand"
    sa[14] = 14
    sb[14] = 15
    sk[14] = "left thigh"
    sa[15] = 15
    sb[15] = 16
    sk[15] = "left leg"
    sa[16] = 16
    sb[16] = -3
    sk[16] = "left foot"
    sa[17] = 17
    sb[17] = 18
    sk[17] = "right thigh"
    sa[18] = 18
    sb[18] = 19
    sk[18] = "right leg"
    sa[19] = 19
    sb[19] = -3
    sk[19] = "right foot"

    int best = -1
    float bestD2 = 2025.0     ; 45 units (about 65 cm): further than that, the hand is not on this body
    float bestX
    float bestY
    float bestZ
    i = 0
    while (i < 20)
        int a = sa[i]
        int b = sb[i]
        if (has[a] && (b < 0 || has[b]))
            float bx = nx[a]
            float by = ny[a]
            float bz = nz[a]
            if (b == -1)
                bz += 18.0
            elseIf (b == -2 && has[a - 1])
                ; the hand reaches past the wrist about half a forearm
                bx += (nx[a] - nx[a - 1]) * 0.5
                by += (ny[a] - ny[a - 1]) * 0.5
                bz += (nz[a] - nz[a - 1]) * 0.5
            elseIf (b >= 0)
                bx = nx[b]
                by = ny[b]
                bz = nz[b]
            endIf
            float d2 = LivingWorldSegmentDistance2(nx[a], ny[a], nz[a], bx, by, bz, hx, hy, hz)
            if (d2 < bestD2)
                bestD2 = d2
                best = i
                bestX = _lwPx
                bestY = _lwPy
                bestZ = _lwPz
            endIf
        endIf
        i += 1
    endWhile
    if (best < 0)
        return ""
    endIf
    string kind = sk[best]
    if (best != 0 && best != 1 && best != 2 && best != 3 && best != 5)
        return kind
    endIf

    ; torso and head: front, back or side, from where the hand is relative to the way the NPC faces
    float angle = target.GetAngleZ()
    float ox = hx - bestX
    float oy = hy - bestY
    float forward = ox * Math.Sin(angle) + oy * Math.Cos(angle)
    float right = ox * Math.Cos(angle) - oy * Math.Sin(angle)
    if (best == 5)
        if (forward > 5.0)
            return "face"
        endIf
        return "head"
    endIf
    string side = "right"
    if (right < 0.0)
        side = "left"
    endIf
    bool sideways = Math.Abs(right) > Math.Abs(forward)
    bool front = forward >= 0.0
    if (best == 0)
        if (sideways)
            return side + " hip"
        elseIf (front)
            return "hips"
        endIf
        return "backside"
    elseIf (best == 3)
        if (sideways)
            return side + " side"
        elseIf (front)
            return "chest"
        endIf
        return "upper back"
    endIf
    if (sideways)
        return side + " side"
    elseIf (front)
        return "stomach"
    endIf
    return "lower back"
endFunction

; Which of LivingWorldGrabArea's 20 bones to read for a grab on this ragdoll body (HIGGS node name).
bool[] function LivingWorldBonesNear(string grabbedNode)
    bool[] want = new bool[20]
    string side = ""
    if (StringUtil.Find(grabbedNode, " L ") >= 0)
        side = "L"
    elseIf (StringUtil.Find(grabbedNode, " R ") >= 0)
        side = "R"
    endIf
    bool arm = StringUtil.Find(grabbedNode, "Arm") >= 0 || StringUtil.Find(grabbedNode, "Forearm") >= 0 || StringUtil.Find(grabbedNode, "Hand") >= 0 || StringUtil.Find(grabbedNode, "Finger") >= 0 || StringUtil.Find(grabbedNode, "Thumb") >= 0
    bool leg = StringUtil.Find(grabbedNode, "Thigh") >= 0 || StringUtil.Find(grabbedNode, "Calf") >= 0 || StringUtil.Find(grabbedNode, "Foot") >= 0 || StringUtil.Find(grabbedNode, "Toe") >= 0
    bool head = StringUtil.Find(grabbedNode, "Head") >= 0 || StringUtil.Find(grabbedNode, "Neck") >= 0
    if (arm && side == "L")
        want[6] = true
        want[7] = true
        want[8] = true
        want[9] = true
    elseIf (arm && side == "R")
        want[10] = true
        want[11] = true
        want[12] = true
        want[13] = true
    elseIf (leg && side == "L")
        want[14] = true
        want[15] = true
        want[16] = true
    elseIf (leg && side == "R")
        want[17] = true
        want[18] = true
        want[19] = true
    elseIf (head)
        want[3] = true
        want[4] = true
        want[5] = true
    else
        ; torso (spine, pelvis, COM, clavicle) or unknown: pelvis, spine, neck and shoulders
        want[0] = true
        want[1] = true
        want[2] = true
        want[3] = true
        want[4] = true
        want[6] = true
        want[7] = true
        want[10] = true
        want[11] = true
    endIf
    return want
endFunction

; Squared distance from point h to segment a-b. Leaves the closest point of the segment in _lwPx/_lwPy/_lwPz.
float function LivingWorldSegmentDistance2(float ax, float ay, float az, float bx, float by, float bz, float hx, float hy, float hz)
    float dx = bx - ax
    float dy = by - ay
    float dz = bz - az
    float len2 = dx * dx + dy * dy + dz * dz
    float t = 0.0
    if (len2 > 0.0001)
        t = ((hx - ax) * dx + (hy - ay) * dy + (hz - az) * dz) / len2
        if (t < 0.0)
            t = 0.0
        elseIf (t > 1.0)
            t = 1.0
        endIf
    endIf
    _lwPx = ax + t * dx
    _lwPy = ay + t * dy
    _lwPz = az + t * dz
    float ex = hx - _lwPx
    float ey = hy - _lwPy
    float ez = hz - _lwPz
    return ex * ex + ey * ey + ez * ez
endFunction

string function LivingWorldHeader(string kind)
    ; copy the counter at once: another event's stack may run while this one waits on a game call below
    LivingWorldEventCounter += 1
    int n = LivingWorldEventCounter
    string loc = (PlayerRef.GetCurrentLocation() as Form).GetName()
    if (loc == "")
        loc = "Skyrim"
    endIf
    return "v=1|key=" + LivingWorldLoadNonce + "-" + n + "|type=" + kind + "|gt=" + (Utility.GetCurrentGameTime() + 1.0) + "|loc=" + loc
endFunction

; ref^base^ref_plugin^base_plugin^is_player^name (plugin names: see MantellaConversation.LivingWorldPluginName)
string function LivingWorldActorField(Actor a)
    MantellaConversation conv = ListenerScript.conversation
    int refId = (a as Form).GetFormID()
    int baseId = (a.GetActorBase() as Form).GetFormID()
    string isPlayer = "0"
    if (a == PlayerRef)
        isPlayer = "1"
    endIf
    return refId + "^" + baseId + "^" + conv.LivingWorldPluginName(refId) + "^" + conv.LivingWorldPluginName(baseId) + "^" + isPlayer + "^" + LivingWorldFog.RealName(a) ; LIVINGWORLD PATCH: fog
endFunction

; One "|w=" entry per NPC near the event: distance (m), line of sight, and the game's own relationship
; ranks towards the actor and the target. The server decides who actually perceived it.
string function LivingWorldWitnesses(Actor doer, Actor target)
    string result = ""
    Actor center = target
    if (!center)
        center = doer
    endIf
    Actor[] candidates = ListenerScript.ScanNearbyActors()
    FormList participants = ListenerScript.conversation.Participants
    int count = candidates.Length
    int total = count + participants.GetSize()
    int i = 0
    Actor[] seenAlready = new Actor[20]
    int seenCount = 0
    while (i < total && seenCount < 20)
        Actor w
        if (i < count)
            w = candidates[i]
        else
            w = participants.GetAt(i - count) as Actor
        endIf
        ; only adult people are witnesses: no animals, no creatures (the Stump, chickens), no children
        if (w && w != doer && w != target && w != PlayerRef && LivingWorldIsPerson(w) && seenAlready.Find(w) < 0)
            seenAlready[seenCount] = w
            seenCount += 1
            float meters = w.GetDistance(center) / 71.0210
            if (meters <= LivingWorldWitnessScanMeters)
                string los = "0"
                if (w.HasLOS(center) || w.HasLOS(doer))
                    los = "1"
                    if (meters <= LivingWorldReactGuardMeters && meters < _lwSawGuardMeters && w.IsGuard() && !w.IsInCombat())
                        _lwSawGuard = w
                        _lwSawGuardMeters = meters
                    endIf
                endIf
                string rankTarget = ""
                if (target)
                    rankTarget = w.GetRelationshipRank(target) as string
                endIf
                result += "|w=" + meters + "^" + los + "^" + w.GetRelationshipRank(doer) + "^" + rankTarget + "^" + LivingWorldActorField(w)
            endIf
        endIf
        i += 1
    endWhile
    return result
endFunction

function LivingWorldQueue(string rec)
    if (!LivingWorldEvents)
        LivingWorldEvents = Utility.CreateStringArray(0)
    endIf
    if (LivingWorldEvents.Length >= LivingWorldMaxQueuedEvents)
        ; full: drop the oldest
        string[] kept = Utility.CreateStringArray(LivingWorldEvents.Length - 1)
        int i = 1
        while (i < LivingWorldEvents.Length)
            kept[i - 1] = LivingWorldEvents[i]
            i += 1
        endWhile
        LivingWorldEvents = kept
    endIf
    LivingWorldEvents = Utility.ResizeStringArray(LivingWorldEvents, LivingWorldEvents.Length + 1)
    LivingWorldEvents[LivingWorldEvents.Length - 1] = rec
    Debug.Trace("Mantella Living World: queued " + rec)
endFunction

; MantellaConversation.BuildContext takes the queue with each request.
string[] function LivingWorldTakeEvents()
    LwFlushGift() ; a gift still being put together goes with this request
    string[] taken = LivingWorldEvents
    LivingWorldEvents = Utility.CreateStringArray(0)
    if (!taken)
        taken = Utility.CreateStringArray(0)
    endIf
    return taken
endFunction

; LIVINGWORLD PATCH: guard careers. When a guard leader takes the player on, the server names the
; hold's uniform (plugin-relative form IDs plus their plugin) with the NPC's line, and the player gets
; one of each. Nothing here decides anything: the server's rules already said yes.
; LIVINGWORLD PATCH: guard careers. The holds whose vanilla "Thane of ..." quest (Favor250-258, Skyrim.esm) is
; completed. Read once at the start of a conversation: eight GetFormFromFile + IsCompleted calls, no polling.
; The Rift (Favor251) is left out until its form ID is checked; "debug guard thane" covers it in testing.
string[] function LivingWorldThaneOf()
    int[] ids = new int[8]
    string[] holds = new string[8]
    ids[0] = 0x000A2C9E
    holds[0] = "Whiterun"
    ids[1] = 0x000A2C9B
    holds[1] = "Haafingar"
    ids[2] = 0x000A2C86
    holds[2] = "the Reach"
    ids[3] = 0x000A2CA6
    holds[3] = "Eastmarch"
    ids[4] = 0x000A34CE
    holds[4] = "Hjaalmarch"
    ids[5] = 0x000A34D4
    holds[5] = "the Pale"
    ids[6] = 0x000A34D7
    holds[6] = "Winterhold"
    ids[7] = 0x000A34DE
    holds[7] = "Falkreath"
    string[] found = new string[8]
    int n = 0
    int i = 0
    while (i < ids.Length)
        Quest q = Game.GetFormFromFile(ids[i], "Skyrim.esm") as Quest
        if (q && q.IsCompleted())
            found[n] = holds[i]
            n += 1
        endIf
        i += 1
    endWhile
    if (n == 0)
        return new string[1] ; the server ignores empty names
    endIf
    return Utility.ResizeStringArray(found, n)
endFunction

;; LIVINGWORLD PATCH: guard careers G2, the barracks bunk. The server names one bed reference; while the
;; player serves it is owned by the player (sleep there without trespassing), and unowned again after.
;; A bed in an unloaded cell cannot be reached, so it is kept pending and retried on location change and
;; on the listener's update tick until the player is near it.
int property LivingWorldBedId = 0 auto hidden
string property LivingWorldBedPlugin = "" auto hidden
int property LivingWorldBedOwn = -1 auto hidden   ; pending: 1 = give, 0 = take back, -1 = nothing pending

;; LIVINGWORLD PATCH: guard careers, a footlocker by the bunk. The server names a container base that never
;; respawns; the first time the player stands by their own bunk (within about 2.5 m) one is placed against
;; the bunk, square with it, on the side the player stands, and made theirs. It is a placed, persistent reference, so it and what is put in it stay in the save.
int property LivingWorldChestBase = 0 auto hidden
string property LivingWorldChestPlugin = "" auto hidden
ObjectReference property LivingWorldChestRef auto hidden

function LivingWorldGuardChest(int baseId, string plugin)
    if (LivingWorldChestRef)
        return   ; already placed
    endIf
    LivingWorldChestBase = baseId
    LivingWorldChestPlugin = plugin
    LivingWorldGuardChestRetry()
endFunction

function LivingWorldGuardChestRetry()
    if (LivingWorldChestBase == 0 || LivingWorldChestRef || LivingWorldBedId == 0)
        return
    endIf
    ObjectReference bed = Game.GetFormFromFile(LivingWorldBedId, LivingWorldBedPlugin) as ObjectReference
    if (!bed || !bed.Is3DLoaded() || bed.GetActorOwner() != PlayerRef.GetActorBase())
        return   ; not there yet, or the bunk is not the player's
    endIf
    if (PlayerRef.GetDistance(bed) > 180.0)
        return
    endIf
    Form base = Game.GetFormFromFile(LivingWorldChestBase, LivingWorldChestPlugin)
    if (!base)
        LivingWorldChestBase = 0
        return
    endIf
    ObjectReference chest = bed.PlaceAtMe(base, 1, true, true)   ; placed disabled, moved into place, then shown
    if (chest)
        LwPlaceBesideBed(chest, bed)
        chest.Enable()
        chest.SetActorOwner(PlayerRef.GetActorBase())
        LivingWorldChestRef = chest
        LivingWorldChestBase = 0
        Debug.Notification("A footlocker by your bunk is yours to use.")
    endIf
endFunction

;; Square with the bunk and right against it, on the side the player is standing (open floor, not the wall):
;; along the bed's short or long side, whichever the player is nearer to, with the bed's own facing and level.
function LwPlaceBesideBed(ObjectReference chest, ObjectReference bed)
    float a = bed.GetAngleZ()
    float c = Math.Cos(a)
    float sn = Math.Sin(a)
    float dx = PlayerRef.GetPositionX() - bed.GetPositionX()
    float dy = PlayerRef.GetPositionY() - bed.GetPositionY()
    float lx = dx * c - dy * sn          ; the player's offset in the bed's own axes
    float ly = dx * sn + dy * c
    float halfW = bed.GetWidth() / 2.0
    float halfL = bed.GetLength() / 2.0
    if (halfW < 30.0)
        halfW = 50.0
    endIf
    if (halfL < 30.0)
        halfL = 100.0
    endIf
    float gap = 32.0                     ; about half a footlocker's depth
    float tx = 0.0
    float ty = 0.0
    float turn = 0.0
    if (Math.Abs(lx) / halfW > Math.Abs(ly) / halfL)
        tx = halfW + gap
        if (lx < 0.0)
            tx = -tx
        endIf
        turn = 90.0
    else
        ty = halfL + gap
        if (ly < 0.0)
            ty = -ty
        endIf
    endIf
    float wx = tx * c + ty * sn
    float wy = ty * c - tx * sn
    chest.SetAngle(0.0, 0.0, a + turn)
    chest.SetPosition(bed.GetPositionX() + wx, bed.GetPositionY() + wy, bed.GetPositionZ())
endFunction

;; LIVINGWORLD PATCH: guard careers G2f, arrests. The server's rules decide what someone the player arrests does:
;; 'submit' = they follow the player (as a follower) until the player brings them into the jail cell, where they
;; are put behind the cell door at the jail's prisoner marker and kept there until their days are served;
;; 'flee' = they lose their nerve and run; 'fight' = they turn on the player. Each locking up and letting out is
;; queued for the server as a 'jail' record (task = the arrest). Up to 4 prisoners at a time.
int property LivingWorldJailId = 0 auto hidden
string property LivingWorldJailPlugin = "Skyrim.esm" auto hidden
float property LivingWorldEscortDays = 1.0 auto hidden     ; not brought in by then: they slip away
float property LivingWorldResistDays = 0.1 auto hidden     ; how long a runner stays without nerve
Actor[] _lwPrisoner
int[] _lwPrisonerArrest
int[] _lwPrisonerState        ; 1 = escorted, 2 = in the cell, 3 = resisting (flee)
float[] _lwPrisonerUntil      ; game days (+1, as the records' gt): escort/resist runs out, or the sentence ends
float[] _lwPrisonerDays
float[] _lwPrisonerNerve      ; a runner's own Confidence, given back afterwards

function LwPrisonerArrays()
    if (!_lwPrisoner)
        _lwPrisoner = new Actor[4]
        _lwPrisonerArrest = new int[4]
        _lwPrisonerState = new int[4]
        _lwPrisonerUntil = new float[4]
        _lwPrisonerDays = new float[4]
        _lwPrisonerNerve = new float[4]
    endIf
endFunction

int function LwPrisonerSlot(Actor npc)
    LwPrisonerArrays()
    int i = _lwPrisoner.Find(npc)
    if (i < 0)
        i = _lwPrisoner.Find(None)
    endIf
    return i
endFunction

ObjectReference function LwJailMarker()
    if (LivingWorldJailId == 0)
        return None
    endIf
    return Game.GetFormFromFile(LivingWorldJailId, LivingWorldJailPlugin) as ObjectReference
endFunction

function LivingWorldArrest(Actor npc, string mode, int arrestId, float days, int jailId, string jailPlugin)
    if (!npc || npc == PlayerRef || npc.IsDead())
        return
    endIf
    if (jailId != 0)
        LivingWorldJailId = jailId
        LivingWorldJailPlugin = jailPlugin
    endIf
    float now = Utility.GetCurrentGameTime() + 1.0
    if (mode == "fight")
        Debug.Notification(npc.GetDisplayName() + " fights back!")
        npc.StartCombat(PlayerRef)
        return
    endIf
    int slot = LwPrisonerSlot(npc)
    if (slot < 0)
        Debug.Notification("The cells are full: " + npc.GetDisplayName() + " cannot be held.")
        return
    endIf
    _lwPrisoner[slot] = npc
    _lwPrisonerArrest[slot] = arrestId
    _lwPrisonerDays[slot] = days
    if (mode == "flee")
        _lwPrisonerState[slot] = 3
        _lwPrisonerUntil[slot] = now + LivingWorldResistDays
        _lwPrisonerNerve[slot] = npc.GetBaseActorValue("Confidence")
        Debug.Notification(npc.GetDisplayName() + " runs for it!")
        npc.SetActorValue("Confidence", 0)
        npc.StartCombat(PlayerRef)
        return
    endIf
    _lwPrisonerState[slot] = 1
    _lwPrisonerUntil[slot] = now + LivingWorldEscortDays
    npc.StopCombat()
    npc.SetActorValue("WaitingForPlayer", 0)
    if (npc.GetRelationshipRank(PlayerRef) != 4)
        npc.SetFactionRank(giafac_following, 1)
        gia_FollowerQst.Reset()
        gia_FollowerQst.Stop()
        Utility.Wait(0.5)
        gia_FollowerQst.Start()
    endIf
    npc.EvaluatePackage()
    ObjectReference marker = LwJailMarker()
    string where = "the cells"
    if (marker && marker.GetParentCell())
        where = marker.GetParentCell().GetName()
    endIf
    Debug.Notification(npc.GetDisplayName() + " is under arrest. Take them to " + where + ".")
endFunction

function LwJailRecord(int slot, string via)
    Actor npc = _lwPrisoner[slot]
    LivingWorldQueue(LivingWorldHeader("jail") + "|actor=" + LivingWorldActorField(PlayerRef) + "|target=" + LivingWorldActorField(npc) + "|via=" + via + "|task=" + _lwPrisonerArrest[slot])
endFunction

function LwPrisonerClear(int slot)
    _lwPrisoner[slot] = None
    _lwPrisonerArrest[slot] = 0
    _lwPrisonerState[slot] = 0
endFunction

function LwPrisonerOut(int slot, string why)
    Actor npc = _lwPrisoner[slot]
    if (npc && !npc.IsDead())
        if (_lwPrisonerState[slot] == 1)
            MantellaFollowerUtils.DismissFollower(npc, gia_FollowerQst, giafac_following)
        endIf
        if (_lwPrisonerState[slot] == 2)
            npc.MoveToMyEditorLocation()
            npc.EvaluatePackage()
        endIf
        if (why != "")
            Debug.Notification(npc.GetDisplayName() + why)
        endIf
        LwJailRecord(slot, "released")
    endIf
    LwPrisonerClear(slot)
endFunction

; From the listener's update tick: lock up a prisoner the player has brought into the jail's cell block, keep
; prisoners in their cell, let them out when their time is served, and give runners their nerve back.
function LivingWorldJailTick()
    if (!_lwPrisoner)
        return
    endIf
    float now = Utility.GetCurrentGameTime() + 1.0
    ObjectReference marker = LwJailMarker()
    Cell jailCell = None
    if (marker)
        jailCell = marker.GetParentCell()
    endIf
    int i = 0
    while (i < _lwPrisoner.Length)
        Actor npc = _lwPrisoner[i]
        int st = _lwPrisonerState[i]
        if (npc && npc.IsDead())
            LwPrisonerClear(i)
        elseIf (npc && st == 3)
            if (now >= _lwPrisonerUntil[i])
                npc.SetActorValue("Confidence", _lwPrisonerNerve[i])
                LwPrisonerClear(i)
            endIf
        elseIf (npc && st == 1)
            if (jailCell && PlayerRef.GetParentCell() == jailCell && npc.GetParentCell() == jailCell)
                MantellaFollowerUtils.DismissFollower(npc, gia_FollowerQst, giafac_following)
                npc.MoveTo(marker)
                npc.EvaluatePackage()
                _lwPrisonerState[i] = 2
                _lwPrisonerUntil[i] = now + _lwPrisonerDays[i]
                Debug.Notification(npc.GetDisplayName() + " is locked in a cell.")
                LwJailRecord(i, "jailed")
            elseIf (now >= _lwPrisonerUntil[i])
                LwPrisonerOut(i, " slipped away.")
            endIf
        elseIf (npc && st == 2)
            if (now >= _lwPrisonerUntil[i])
                string note = ""
                if (PlayerRef.GetParentCell() == jailCell)
                    note = " has served their time."
                endIf
                LwPrisonerOut(i, note)
            elseIf (marker && (npc.GetParentCell() != jailCell || npc.GetDistance(marker) > 600.0) && !npc.IsInCombat())
                npc.MoveTo(marker)   ; back behind the cell door
            endIf
        endIf
        i += 1
    endWhile
endFunction

; The server lets prisoners out (a wrongful arrest the superior undid).
function LivingWorldRelease(int[] arrestIds)
    if (!_lwPrisoner || !arrestIds)
        return
    endIf
    int k = 0
    while (k < arrestIds.Length)
        int slot = _lwPrisonerArrest.Find(arrestIds[k])
        if (slot >= 0 && arrestIds[k] != 0)
            LwPrisonerOut(slot, " is let out.")
        endIf
        k += 1
    endWhile
endFunction

function LivingWorldGuardBed(int id, string plugin, bool own)
    LivingWorldBedId = id
    LivingWorldBedPlugin = plugin
    if (own)
        LivingWorldBedOwn = 1
    else
        LivingWorldBedOwn = 0
    endIf
    LivingWorldGuardBedRetry()
endFunction

function LivingWorldGuardBedRetry()
    LivingWorldGuardChestRetry()
    if (LivingWorldBedOwn < 0 || LivingWorldBedId == 0)
        return
    endIf
    ObjectReference bed = Game.GetFormFromFile(LivingWorldBedId, LivingWorldBedPlugin) as ObjectReference
    if (!bed)
        return   ; its cell is not loaded yet
    endIf
    if (LivingWorldBedOwn == 1)
        bed.SetActorOwner(PlayerRef.GetActorBase())
        Debug.Notification("Your bunk in the barracks is ready.")
    else
        bed.SetActorOwner(None)
    endIf
    LivingWorldBedOwn = -1
endFunction

;; LIVINGWORLD PATCH: guard careers G2e, shift encounters. The server sends the watch windows of the duty in
;; hand (when each falls due, and whether someone should come over or the player should notice something).
;; MantellaListenerScript checks them on its update tick: when one is due on the shift and no conversation is
;; running, a nearby adult who is awake, not hostile, not a follower and has not come over lately walks up and
;; a conversation starts; if nobody fits, the player notices something (a notification). Either way a "watch"
;; record tells the server. Nothing is spawned and nothing is decided here.
int property LivingWorldWatchTask = 0 auto hidden
float property LivingWorldWatchEnd = 0.0 auto hidden
float property LivingWorldWatchCooldown = 3.0 auto hidden
float[] property LivingWorldWatchAt auto hidden
int[] property LivingWorldWatchWin auto hidden
int[] property LivingWorldWatchKind auto hidden
string[] property LivingWorldWatchObs auto hidden
bool[] property LivingWorldWatchDone auto hidden
Actor[] property LivingWorldWatchRecent auto hidden
float[] property LivingWorldWatchRecentAt auto hidden

function LivingWorldGuardWatch(int task, float endGt, float[] at, int[] win, int[] kind, string[] obs, float cooldown)
    LivingWorldWatchTask = task
    LivingWorldWatchEnd = endGt
    LivingWorldWatchAt = at
    LivingWorldWatchWin = win
    LivingWorldWatchKind = kind
    LivingWorldWatchObs = obs
    if (cooldown > 0.0)
        LivingWorldWatchCooldown = cooldown
    endIf
    int n = 1
    if (at && at.Length > 0)
        n = at.Length
    endIf
    LivingWorldWatchDone = Utility.CreateBoolArray(n)
endFunction

; The first watch window that is due now on the shift, or -1.
int function LivingWorldWatchDue()
    if (LivingWorldWatchTask == 0 || !LivingWorldWatchAt || !LivingWorldWatchDone)
        return -1
    endIf
    float now = Utility.GetCurrentGameTime() + 1.0
    if (now > LivingWorldWatchEnd)
        return -1
    endIf
    int i = 0
    while (i < LivingWorldWatchAt.Length && i < LivingWorldWatchDone.Length)
        if (!LivingWorldWatchDone[i] && LivingWorldWatchAt[i] <= now)
            return i
        endIf
        i += 1
    endWhile
    return -1
endFunction

bool function LivingWorldWatchWantsSomeone(int slot)
    return LivingWorldWatchKind && slot < LivingWorldWatchKind.Length && LivingWorldWatchKind[slot] == 1
endFunction

bool function LivingWorldWatchCameLately(Actor a)
    if (!LivingWorldWatchRecent)
        return false
    endIf
    float now = Utility.GetCurrentGameTime() + 1.0
    int i = 0
    while (i < LivingWorldWatchRecent.Length)
        if (LivingWorldWatchRecent[i] == a && now - LivingWorldWatchRecentAt[i] < LivingWorldWatchCooldown)
            return true
        endIf
        i += 1
    endWhile
    return false
endFunction

bool function LivingWorldWatchFits(Actor a)
    if (!LivingWorldIsPerson(a) || a == PlayerRef || a.IsDisabled() || a.IsInCombat() || a.IsPlayerTeammate())
        return false
    endIf
    if (a.GetSleepState() >= 3 || a.IsHostileToActor(PlayerRef) || a.IsInDialogueWithPlayer())
        return false
    endIf
    return !LivingWorldWatchCameLately(a)
endFunction

; Someone from the nearby people who may come over, picked at random among those who fit, or None.
Actor function LivingWorldWatchPick(Actor[] nearby)
    if (!nearby || nearby.Length == 0)
        return None
    endIf
    int n = nearby.Length
    int start = Utility.RandomInt(0, n - 1)
    int j = 0
    while (j < n)
        Actor a = nearby[(start + j) % n]
        if (a && LivingWorldWatchFits(a))
            return a
        endIf
        j += 1
    endWhile
    return None
endFunction

function LivingWorldWatchRemember(Actor a)
    if (!LivingWorldWatchRecent)
        LivingWorldWatchRecent = new Actor[8]
        LivingWorldWatchRecentAt = new float[8]
    endIf
    int i = LivingWorldWatchRecent.Length - 1
    while (i > 0)
        LivingWorldWatchRecent[i] = LivingWorldWatchRecent[i - 1]
        LivingWorldWatchRecentAt[i] = LivingWorldWatchRecentAt[i - 1]
        i -= 1
    endWhile
    LivingWorldWatchRecent[0] = a
    LivingWorldWatchRecentAt[0] = Utility.GetCurrentGameTime() + 1.0
endFunction

; Use up a window and tell the server what it brought: who came over, or what the player noticed.
function LivingWorldWatchRecord(int slot, Actor who)
    LivingWorldWatchDone[slot] = true
    string rec = LivingWorldHeader("watch") + "|actor=" + LivingWorldActorField(PlayerRef)
    if (who)
        LivingWorldWatchRemember(who)
        rec += "|target=" + LivingWorldActorField(who) + "|via=approach"
    else
        rec += "|via=observe"
        if (LivingWorldWatchObs && slot < LivingWorldWatchObs.Length)
            Debug.Notification("On watch: " + LivingWorldWatchObs[slot])
        endIf
    endIf
    LivingWorldQueue(rec + "|win=" + LivingWorldWatchWin[slot] + "|task=" + LivingWorldWatchTask)
endFunction

function LivingWorldGuardIssue(int[] ids, string[] plugins, int[] counts = None)
    ; counts (optional): how many of each, e.g. the gold for a guard's wages; default 1
    if (!ids)
        return
    endIf
    int i = 0
    while (i < ids.Length)
        string plugin = "Skyrim.esm"
        if (plugins && i < plugins.Length && plugins[i] != "")
            plugin = plugins[i]
        endIf
        Form item = Game.GetFormFromFile(ids[i], plugin)
        int count = 1
        if (counts && i < counts.Length && counts[i] > 0)
            count = counts[i]
        endIf
        if (item)
            PlayerRef.AddItem(item, count, false)
        else
            Debug.Trace("Mantella Living World: guard issue item " + ids[i] + " not found in " + plugin)
        endIf
        i += 1
    endWhile
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LIVINGWORLD PATCH: clothing awareness and drinking                                                 ;
; Attire: what each nearby person wears in the body slot (32), sent with every request under        ;
; mantella_lw_attire, plus a queued record when the player takes off or puts on body clothing.       ;
; Drink: the Living World Drink action (data/actions/livingworld_drink.json in MantellaExtension).    ;
; The NPC drinks an alcoholic drink from their own inventory and it is recorded like any other       ;
; consume event (via=action). The server counts drinks; this script never decides anything with it. ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

bool property LivingWorldAttireOn = true auto hidden
int property LivingWorldBodySlotMask = 0x00000004 auto hidden   ; slot 32 (body)

bool _lwPlayerCovered = true
Keyword _lwActorTypeNPC

; Called from LivingWorldRegisterPerception on every load.
function LivingWorldRegisterAttireAndDrink()
    _lwActorTypeNPC = Keyword.GetKeyword("ActorTypeNPC")
    _lwPlayerCovered = PlayerRef.GetWornForm(LivingWorldBodySlotMask) != None
    RegisterForModEvent("MantellaConversation_Advanced_Action_mantella_npc_lw_drink", "OnLivingWorldDrinkAdvanced")
    RegisterForModEvent("MantellaConversation_Action_mantella_npc_lw_drink", "OnLivingWorldDrinkLegacy")
    RegisterForModEvent("MantellaLivingWorld_DrinkFetch", "OnLwDrinkFetch")   ; no drink on them: a bottle nearby
    _lwInFight = false
    _lwSwimming = PlayerRef.IsSwimming()
    _lwProbeOn = false
    _lwTickDue = 0.0
    _lwRegularDueAt = Utility.GetCurrentRealTime() + LivingWorldHygienePollSeconds
    LwBodyReset() ; LIVINGWORLD PATCH: body language (BL1)
    LwGestureReset() ; LIVINGWORLD PATCH: gestures (BL2)
    LwScheduleNext(Utility.GetCurrentRealTime())
endFunction

; "clothing", "armor" or "none" for what the actor wears in the body slot
string function LivingWorldCover(Actor a)
    Armor body = a.GetWornForm(LivingWorldBodySlotMask) as Armor
    if (!body)
        return "none"
    elseIf (body.GetWeightClass() == 2)
        return "clothing"
    endIf
    return "armor"
endFunction

string function LivingWorldAttireRecord(Actor a)
    string cover = LivingWorldCover(a)
    string bodyName = ""
    Form body = a.GetWornForm(LivingWorldBodySlotMask)
    if (body)
        bodyName = body.GetName()
    endIf
    string sex = "m"
    if (a.GetActorBase().GetSex() == 1)
        sex = "f"
    endIf
    string rec = LivingWorldHeader("attire") + "|actor=" + LivingWorldActorField(a) + "|body=" + bodyName + "|cover=" + cover + "|sex=" + sex
    if (_lwScAny && LwInScene(a) >= 0)
        rec += "|via=scene"   ; clothes off for an intimate scene: the scene's own record covers it
    endIf
    if (a == PlayerRef)
        if (cover == "none")
            float size = LwPlayerGenitalScale()
            if (size > 0.0)
                rec += "|psize=" + size   ; The New Gentleman: women who see him may notice (MantellaExtension intimacy/size.py)
            endIf
        endIf
        if (_lwErectShown)
            rec += "|erect=1"   ; visibly aroused (shows only when the body slot is empty)
        endIf
        if (_lwEyesCovered)
            rec += "|eyes=1"    ; the player's eyes are covered: cannot see, can still hear
        endIf
    endIf
    if (cover == "none")
        rec += LivingWorldWitnesses(a, None)   ; who could see them: only worked out when it matters
    endIf
    return rec
endFunction

; An adult, living person. Children are left out of every Living World system.
bool function LivingWorldIsPerson(Actor a)
    return a && !a.IsDead() && !a.IsChild() && (!_lwActorTypeNPC || a.HasKeyword(_lwActorTypeNPC))
endFunction

; One attire record each for the player, the conversation's participants and the nearby people.
; MantellaConversation.BuildContext sends this with every request.
string[] function LivingWorldAttireSnapshot()
    if (!LivingWorldAttireOn)
        return Utility.CreateStringArray(0)
    endIf
    Actor[] nearby = ListenerScript.ScanNearbyActors()
    FormList participants = ListenerScript.conversation.Participants
    int partCount = participants.GetSize()   ; read once: the list can change while this loop waits on calls
    int total = 1 + partCount + nearby.Length
    Actor[] done = new Actor[30]
    int doneCount = 0
    string[] result = Utility.CreateStringArray(0)
    int i = 0
    while (i < total && doneCount < 30)
        Actor a
        if (i == 0)
            a = PlayerRef
        elseIf (i <= partCount)
            a = participants.GetAt(i - 1) as Actor
        else
            a = nearby[i - 1 - partCount]
        endIf
        if (a && LivingWorldIsPerson(a) && done.Find(a) < 0 && a.GetDistance(PlayerRef) / 71.0210 <= LivingWorldWitnessScanMeters)
            done[doneCount] = a
            doneCount += 1
            result = Utility.ResizeStringArray(result, result.Length + 1)
            result[result.Length - 1] = LivingWorldAttireRecord(a)
        endIf
        i += 1
    endWhile
    return result
endFunction

; Called by MantellaListenerScript when the player equips or unequips anything. Checks a moment later,
; so swapping one outfit for another does not count as undressing.
function LivingWorldPlayerAttireMaybeChanged(Form item)
    Armor worn = item as Armor
    if (!LivingWorldAttireOn || !worn || Math.LogicalAnd(worn.GetSlotMask(), LivingWorldBodySlotMask) == 0)
        return
    endIf
    _lwRegularDueAt = Utility.GetCurrentRealTime() + 1.0
    if (!_lwProbeOn)   ; while the probe ticks it picks this up on its own
        LwScheduleTick(1.0)
    endIf
endFunction

; One timer for this script: the regular checks (attire, hygiene) every few seconds and, while the player
; holds someone, the performance probe every half second. Each tick also measures how late it ran.
Event OnUpdate()
    float now = Utility.GetCurrentRealTime()
    float lag = 0.0
    if (_lwTickDue > 0.0)
        lag = now - _lwTickDue
        if (lag > 300.0 || lag < 0.0)   ; a timer left from before a load: not a measurement
            lag = 0.0
        endIf
    endIf
    _lwTickDue = 0.0
    if (_lwProbeOn)
        LwProbeTick(lag)
    elseIf (lag > LivingWorldStallSeconds && !Utility.IsInMenuMode() && now - _lwLastStallAt > 10.0)
        _lwLastStallAt = now
        LivingWorldQueue(LivingWorldHeader("perf") + "|what=stall|rt0=" + (now - lag) + "|lag=" + lag + "|held=0")
        Debug.Trace("Mantella Living World perf: a script tick ran " + lag + " s late")
    endIf
    if (now >= _lwRegularDueAt)
        if (LivingWorldAttireOn)
            bool covered = PlayerRef.GetWornForm(LivingWorldBodySlotMask) != None
            if (covered != _lwPlayerCovered)
                _lwPlayerCovered = covered
                LivingWorldQueue(LivingWorldAttireRecord(PlayerRef))
            endIf
            if (LwDecencyOn)
                LwDecencyTick(now)   ; LIVINGWORLD PATCH: a guard who sees the player naked comes over
            endIf
        endIf
        if (LivingWorldHygieneOn)
            LwHygieneTick()
        endIf
        _lwRegularDueAt = now + LivingWorldHygienePollSeconds
    endIf
    if (_lwProbeOn)   ; the player is holding someone: no body language until they let go
        LwScheduleTick(LivingWorldProbeSeconds)
        return
    endIf
    if (LivingWorldBodyLanguageOn && now >= _lwbDueAt)
        _lwbWatching = LwBodyTick(now)
        if (_lwbWatching)
            _lwbDueAt = now + LwBodyTickSeconds
        else
            _lwbDueAt = now + LwBodyScanSeconds
        endIf
    endIf
    if (LwGesturesActive() && now >= _lwgDueAt && !Utility.IsInMenuMode() && !PlayerRef.IsInCombat())
        LwGestureTick(now)
        _lwgDueAt = Utility.GetCurrentRealTime() + _lwgInterval
    endIf
    LwScheduleNext(now)
EndEvent

; The next tick, for whichever comes first: the regular checks (when hygiene is on) or body language.
function LwScheduleNext(float now)
    float due = -1.0
    if (LivingWorldHygieneOn)
        due = _lwRegularDueAt
    endIf
    if (LivingWorldBodyLanguageOn && (due < 0.0 || _lwbDueAt < due))
        due = _lwbDueAt
    endIf
    if (LwGesturesActive() && (due < 0.0 || _lwgDueAt < due))
        due = _lwgDueAt
    endIf
    if (due >= 0.0)
        LwScheduleTick(due - now)
    endIf
endFunction

function LwScheduleTick(float delay)
    if (delay < 0.1)
        delay = 0.1
    endIf
    _lwTickDue = Utility.GetCurrentRealTime() + delay
    RegisterForSingleUpdate(delay)
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LIVINGWORLD PATCH: performance probe                                                               ;
; Only watches. While the player holds someone it ticks every half second and measures how late each ;
; tick runs; on release it queues one type=perf record for that hold (format: livingworld/perf/      ;
; game_records.py in MantellaExtension) with how many HIGGS grab and drop events arrived, how many   ;
; repeats were ignored, and the latest tick. A tick that runs late means the game or its scripts      ;
; stopped for that long; the server's monitor (MANTELLA_LW_PERF=1) tells which from outside.         ;
; Outside holds, a regular tick more than LivingWorldStallSeconds late queues a what=stall record.   ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

bool property LivingWorldProbeOn = true auto hidden
float property LivingWorldProbeSeconds = 0.5 auto hidden
float property LivingWorldStallSeconds = 1.0 auto hidden

float _lwTickDue = 0.0
float _lwRegularDueAt = 0.0
float _lwLastStallAt = -100.0
bool _lwProbeOn = false
; per hand: grab and drop events, repeats ignored, holds too short, ticks, summed and latest lateness,
; ticks over a second late, grab handler time
int _lwPLGrabs
int _lwPLDrops
int _lwPLDups
int _lwPLShort
int _lwPLTicks
float _lwPLLagSum
float _lwPLLagMax
int _lwPLStalls
float _lwPLGrabMs
int _lwPLNoArea
int _lwPRGrabs
int _lwPRDrops
int _lwPRDups
int _lwPRShort
int _lwPRTicks
float _lwPRLagSum
float _lwPRLagMax
int _lwPRStalls
float _lwPRGrabMs
int _lwPRNoArea

function LwProbeHoldStarted(bool abIsLeft, Actor target, float now, float grabMs)
    if (abIsLeft)
        _lwPLGrabs = 1
        _lwPLDrops = 0
        _lwPLDups = 0
        _lwPLShort = 0
        _lwPLTicks = 0
        _lwPLLagSum = 0.0
        _lwPLLagMax = 0.0
        _lwPLStalls = 0
        _lwPLGrabMs = grabMs
        _lwPLNoArea = 0
    else
        _lwPRGrabs = 1
        _lwPRDrops = 0
        _lwPRDups = 0
        _lwPRShort = 0
        _lwPRTicks = 0
        _lwPRLagSum = 0.0
        _lwPRLagMax = 0.0
        _lwPRStalls = 0
        _lwPRGrabMs = grabMs
        _lwPRNoArea = 0
    endIf
    if (LivingWorldProbeOn && !_lwProbeOn)
        _lwProbeOn = true
        LwScheduleTick(LivingWorldProbeSeconds)
    endIf
endFunction

function LwProbeCount(bool abIsLeft, int drops, int dups)
    if (abIsLeft)
        _lwPLDrops += drops
        _lwPLDups += dups
    else
        _lwPRDrops += drops
        _lwPRDups += dups
    endIf
endFunction

function LwProbeTick(float lag)
    if (lag < 0.0)
        lag = 0.0
    endIf
    if (_lwLeftHeld)
        _lwPLTicks += 1
        _lwPLLagSum += lag
        if (lag > _lwPLLagMax)
            _lwPLLagMax = lag
        endIf
        if (lag > LivingWorldStallSeconds)
            _lwPLStalls += 1
        endIf
    endIf
    if (_lwRightHeld)
        _lwPRTicks += 1
        _lwPRLagSum += lag
        if (lag > _lwPRLagMax)
            _lwPRLagMax = lag
        endIf
        if (lag > LivingWorldStallSeconds)
            _lwPRStalls += 1
        endIf
    endIf
    if (lag > LivingWorldStallSeconds)
        Debug.Trace("Mantella Living World perf: a probe tick ran " + lag + " s late while holding someone")
    endIf
    if (!_lwLeftHeld && !_lwRightHeld)
        _lwProbeOn = false
    endIf
endFunction

function LwProbeHoldEnded(bool abIsLeft, Actor target, float now)
    if (!LivingWorldProbeOn)
        return
    endIf
    string hand = "R"
    float since = _lwRightSince
    int grabs = _lwPRGrabs
    int drops = _lwPRDrops
    int dups = _lwPRDups
    int shortHolds = _lwPRShort
    int ticks = _lwPRTicks
    float lagSum = _lwPRLagSum
    float lagMax = _lwPRLagMax
    int stalls = _lwPRStalls
    float grabMs = _lwPRGrabMs
    int noArea = _lwPRNoArea
    if (abIsLeft)
        hand = "L"
        since = _lwLeftSince
        grabs = _lwPLGrabs
        drops = _lwPLDrops
        dups = _lwPLDups
        shortHolds = _lwPLShort
        ticks = _lwPLTicks
        lagSum = _lwPLLagSum
        lagMax = _lwPLLagMax
        stalls = _lwPLStalls
        grabMs = _lwPLGrabMs
        noArea = _lwPLNoArea
    endIf
    float lagAvg = 0.0
    if (ticks > 0)
        lagAvg = lagSum / ticks
    endIf
    LivingWorldQueue(LivingWorldHeader("perf") + "|what=grab|hand=" + hand + "|target=" + target.GetDisplayName() + "|rt0=" + since + "|rt1=" + now + "|grabs=" + grabs + "|drops=" + drops + "|dups=" + dups + "|short=" + shortHolds + "|ticks=" + ticks + "|lag_avg=" + lagAvg + "|lag_max=" + lagMax + "|stalls=" + stalls + "|grab_ms=" + grabMs + "|noarea=" + noArea)
    if (!_lwLeftHeld && !_lwRightHeld)
        _lwProbeOn = false
        LwScheduleNext(now)
    endIf
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LIVINGWORLD PATCH: hygiene (H1)                                                                    ;
; The server works out how clean everyone is (MantellaExtension livingworld/hygiene). The game only ;
; reports two things it alone can see: a fight ending (the player and each adult ally who fought,   ;
; with the lowest share of health they fell to) and the player swimming. The player never gets      ;
; OnCombatStateChanged, so this polls two cheap checks every few seconds; allies are only scanned   ;
; while the player is fighting.                                                                     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

bool property LivingWorldHygieneOn = true auto hidden
float property LivingWorldHygienePollSeconds = 2.0 auto hidden
float property LivingWorldMinSwimSeconds = 3.0 auto hidden

bool _lwInFight = false
Actor[] _lwFighters
float[] _lwFighterHp
int _lwFightTicks = 0
bool _lwSwimming = false
float _lwSwimStart = 0.0

function LwHygieneTick()
    if (PlayerRef.IsInCombat())
        if (!_lwInFight)
            _lwInFight = true
            _lwFighters = new Actor[12]
            _lwFighterHp = new float[12]
            _lwFightTicks = 0
        endIf
        LwNoteFighter(PlayerRef)
        _lwFightTicks += 1
        if (_lwFightTicks % 2 == 1)   ; allies every other tick
            Actor[] nearby = ListenerScript.ScanNearbyActors()
            int i = 0
            while (i < nearby.Length)
                Actor a = nearby[i]
                if (a && a != PlayerRef && a.IsInCombat() && !a.IsHostileToActor(PlayerRef) && LivingWorldIsPerson(a))
                    LwNoteFighter(a)
                endIf
                i += 1
            endWhile
        endIf
    elseIf (_lwInFight)
        _lwInFight = false
        int i = 0
        while (i < _lwFighters.Length)
            Actor a = _lwFighters[i]
            if (a && !a.IsDead())
                LivingWorldQueue(LivingWorldHeader("fight") + "|actor=" + LivingWorldActorField(a) + "|hp=" + _lwFighterHp[i])
            endIf
            i += 1
        endWhile
    endIf

    bool swimming = PlayerRef.IsSwimming()
    if (swimming && !_lwSwimming)
        _lwSwimStart = Utility.GetCurrentRealTime()
    elseIf (!swimming && _lwSwimming)
        float seconds = Utility.GetCurrentRealTime() - _lwSwimStart
        if (seconds >= LivingWorldMinSwimSeconds)
            LivingWorldQueue(LivingWorldHeader("swim") + "|actor=" + LivingWorldActorField(PlayerRef) + "|dur=" + seconds)
        endIf
    endIf
    _lwSwimming = swimming
endFunction

; remember someone in this fight and the lowest health they fell to
function LwNoteFighter(Actor a)
    float hp = a.GetActorValuePercentage("Health")
    int slot = _lwFighters.Find(a)
    if (slot < 0)
        slot = _lwFighters.Find(None)
        if (slot < 0)
            return
        endIf
        _lwFighters[slot] = a
        _lwFighterHp[slot] = hp
    elseIf (hp < _lwFighterHp[slot])
        _lwFighterHp[slot] = hp
    endIf
endFunction

event OnLivingWorldDrinkAdvanced(Form speaker, Form conversationQuest, int argumentsHandle)
    MantellaConversation conv = conversationQuest as MantellaConversation
    string sourceName = SKSE_HTTP.getString(argumentsHandle, "source")
    Actor drinker = conv.GetActorByName(sourceName)
    if (!drinker)
        drinker = speaker as Actor
    endIf
    LivingWorldDrink(drinker)
endEvent

event OnLivingWorldDrinkLegacy(Form speaker)
    LivingWorldDrink(speaker as Actor)
endEvent

bool function LivingWorldIsAlcohol(string itemName)
    string[] names = new string[8]
    names[0] = "ale"
    names[1] = "mead"
    names[2] = "wine"
    names[3] = "sujamma"
    names[4] = "flin"
    names[5] = "brandy"
    names[6] = "shein"
    names[7] = "matze"
    int i = 0
    while (i < names.Length)
        if (StringUtil.Find(itemName, names[i]) >= 0)
            return true
        endIf
        i += 1
    endWhile
    return false
endFunction

; The NPC drinks one alcoholic drink from their own inventory.
function LivingWorldDrink(Actor drinker)
    if (!drinker || drinker == PlayerRef || drinker.IsChild())
        return
    endIf
    Potion drink = None
    int i = 0
    int count = drinker.GetNumItems()
    while (i < count && !drink)
        Potion p = drinker.GetNthForm(i) as Potion
        if (p && p.IsFood() && !p.IsPoison() && LivingWorldIsAlcohol(p.GetName()))
            drink = p
        endIf
        i += 1
    endWhile
    if (!drink)
        ObjectReference bottle = LwNearbyBottle(drinker)
        if (bottle)
            int handle = ModEvent.Create("MantellaLivingWorld_DrinkFetch")   ; walking is latent: its own thread
            if (handle)
                ModEvent.PushForm(handle, drinker)
                ModEvent.PushForm(handle, bottle)
                ModEvent.Send(handle)
                return
            endIf
        endIf
        ListenerScript.AddIngameEventToConversation(drinker.GetDisplayName() + " reached for a drink but had none, and there was no bottle within reach. (The innkeeper sells them.)")
        return
    endIf
    drinker.EquipItem(drink, false, true)   ; an NPC equipping a potion drinks it
    LivingWorldConsumed(drinker, drink, "action")
    ListenerScript.AddIngameEventToConversation(drinker.GetDisplayName() + " drank a " + drink.GetName() + ".")
endFunction

float property LivingWorldDrinkReachUnits = 710.0 auto hidden   ; about 10 m

; The nearest bottle of ale, mead, wine... standing in the drinker's cell within reach (inns and homes
; have them on tables and shelves). Not one in the player's hand.
ObjectReference function LwNearbyBottle(Actor drinker)
    Cell c = drinker.GetParentCell()
    if (!c)
        return None
    endIf
    ObjectReference best = None
    float bestDistance = LivingWorldDrinkReachUnits
    int n = c.GetNumRefs(46)   ; kAlchemy: potions, food and drink placed in the world
    int i = 0
    while (i < n)
        ObjectReference ref = c.GetNthRef(i, 46)
        if (ref && ref.IsEnabled() && !ref.IsDeleted() && ref.GetDistance(PlayerRef) > 60.0)
            Potion p = ref.GetBaseObject() as Potion
            if (p && p.IsFood() && !p.IsPoison() && LivingWorldIsAlcohol(p.GetName()))
                float d = drinker.GetDistance(ref)
                if (d < bestDistance)
                    best = ref
                    bestDistance = d
                endIf
            endIf
        endIf
        i += 1
    endWhile
    return best
endFunction

Event OnLwDrinkFetch(Form npcForm, Form bottleForm)
    Actor npc = npcForm as Actor
    ObjectReference bottle = bottleForm as ObjectReference
    if (!npc || !bottle)
        return
    endIf
    ; "I'll sit and have a drink": let them reach the seat first
    float until = Utility.GetCurrentRealTime() + 12.0
    while (_lwOrderActors && _lwOrderActors.Find(npc) >= 0 && !LwIsSeated(npc) && Utility.GetCurrentRealTime() < until)
        Utility.Wait(1.0)
    endWhile
    if (npc.GetDistance(bottle) > 150.0)
        npc.PathToReference(bottle, 1.0)   ; a sit order brings them back to their seat afterwards
    endIf
    if (npc.IsDead() || npc.IsInCombat() || !bottle.IsEnabled() || bottle.IsDeleted() || npc.GetDistance(bottle) > 300.0)
        ListenerScript.AddIngameEventToConversation(npc.GetDisplayName() + " went for a bottle but did not get to it.")
        return
    endIf
    Potion drink = bottle.GetBaseObject() as Potion
    bottle.Disable()
    bottle.Delete()
    npc.AddItem(drink, 1, true)
    npc.EquipItem(drink, false, true)   ; an NPC equipping a potion drinks it
    LivingWorldConsumed(npc, drink, "action")
    ListenerScript.AddIngameEventToConversation(npc.GetDisplayName() + " took a " + drink.GetName() + " from nearby and drank it.")
EndEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LIVINGWORLD PATCH: Trade (an agreed deal)                                                          ;
; Barter only opens for merchants (Skyrim ignores ShowBarterMenu on a guard) and Inventory only      ;
; opens a window. Trade carries out the deal the player and the NPC agreed: the server names what    ;
; each side hands over (livingworld/actions/trade.py) and this checks both sides have it, then moves ;
; it all at once. Items are found by name (any spelling in *_gives_match, '|'-separated).           ;
; An NPC short of gold pays the rest "from their savings" (added), so a deal with a guard who        ;
; carries little coin still works. The player's side is never conjured: no goods, no deal.          ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

function LwRegisterTrade()
    RegisterForModEvent("MantellaConversation_Advanced_Action_mantella_lw_npc_trade", "OnLwTradeAdvanced")
    RegisterForModEvent("MantellaConversation_Action_mantella_lw_npc_trade", "OnLwTradeBasic")
endFunction

Event OnLwTradeAdvanced(Form speaker, Form conversationQuest, int argumentsHandle)
    MantellaConversation conv = conversationQuest as MantellaConversation
    Actor npc = None
    if (conv)
        npc = conv.GetActorByName(SKSE_HTTP.getString(argumentsHandle, "source", ""))
    endIf
    if (!npc)
        npc = speaker as Actor
    endIf
    LwTrade(npc, SKSE_HTTP.getString(argumentsHandle, "player_gives_match", ""), SKSE_HTTP.getInt(argumentsHandle, "player_gives_count", 0), SKSE_HTTP.getInt(argumentsHandle, "player_gives_gold", 0), SKSE_HTTP.getString(argumentsHandle, "npc_gives_match", ""), SKSE_HTTP.getInt(argumentsHandle, "npc_gives_count", 0), SKSE_HTTP.getInt(argumentsHandle, "npc_gives_gold", 0))
EndEvent

; "Trade:" with no details (basic actions): nothing says what the deal is, so open the NPC's pack instead.
Event OnLwTradeBasic(Form speaker)
    Actor npc = speaker as Actor
    if (npc && npc != PlayerRef && LivingWorldIsPerson(npc))
        npc.OpenInventory(true)
        ListenerScript.AddIngameEventToConversation(npc.GetDisplayName() + " opened their pack so the two of them could swap goods by hand.")
    endIf
EndEvent

; The item in who's inventory whose name is, or else contains, one of the '|'-separated spellings,
; preferring one they hold at least `count` of ("Amethyst" before "Flawless Amethyst").
Form function LwTradeFindItem(Actor who, string terms, int count)
    if (!who || terms == "")
        return None
    endIf
    Form gold = Game.GetFormFromFile(0x0000000F, "Skyrim.esm")
    Form best = None
    int bestScore = 0
    int n = who.GetNumItems()
    int i = 0
    while (i < n)
        Form f = who.GetNthForm(i)
        if (f && f != gold)
            int score = LwTradeNameMatches(f.GetName(), terms)   ; 2 = same name, 1 = name contains it
            if (score > 0)
                if (who.GetItemCount(f) >= count)
                    score += 2
                endIf
                if (score > bestScore)
                    best = f
                    bestScore = score
                endIf
            endIf
        endIf
        i += 1
    endWhile
    return best
endFunction

int function LwTradeNameMatches(string itemName, string terms)
    if (itemName == "")
        return 0
    endIf
    int found = 0
    int start = 0
    int len = StringUtil.GetLength(terms)
    while (start < len)
        int bar = StringUtil.Find(terms, "|", start)
        if (bar < 0)
            bar = len
        endIf
        string term = StringUtil.Substring(terms, start, bar - start)
        if (term != "")
            if (itemName == term)
                return 2
            elseIf (StringUtil.Find(itemName, term) >= 0)
                found = 1
            endIf
        endIf
        start = bar + 1
    endWhile
    return found
endFunction

string function LwTradeFirstTerm(string terms)
    int bar = StringUtil.Find(terms, "|")
    if (bar < 0)
        return terms
    endIf
    return StringUtil.Substring(terms, 0, bar)
endFunction

function LwTrade(Actor npc, string playerMatch, int playerCount, int playerGold, string npcMatch, int npcCount, int npcGold)
    if (!npc || npc == PlayerRef || !LivingWorldIsPerson(npc) || npc.IsDead())
        return
    endIf
    string npcName = LivingWorldFog.RealName(npc)
    string playerName = PlayerRef.GetDisplayName()
    if (playerCount < 1)
        playerCount = 1
    endIf
    if (npcCount < 1)
        npcCount = 1
    endIf
    if (playerGold < 0)
        playerGold = 0
    endIf
    if (npcGold < 0)
        npcGold = 0
    endIf
    if (playerMatch == "" && npcMatch == "" && playerGold == 0 && npcGold == 0)
        npc.OpenInventory(true)
        ListenerScript.AddIngameEventToConversation(npcName + " opened their pack so the two of them could swap goods by hand (the deal did not say what changes hands).")
        return
    endIf
    Form gold = Game.GetFormFromFile(0x0000000F, "Skyrim.esm")   ; Gold001

    ; Check everything first: nothing moves unless the whole deal can.
    Form playerItem = None
    if (playerMatch != "")
        playerItem = LwTradeFindItem(PlayerRef, playerMatch, playerCount)
        if (!playerItem)
            ListenerScript.AddIngameEventToConversation("The trade did not happen: " + playerName + " has no " + LwTradeFirstTerm(playerMatch) + " to hand over.")
            Debug.Notification("Trade: you have no " + LwTradeFirstTerm(playerMatch))
            return
        endIf
        if (PlayerRef.GetItemCount(playerItem) < playerCount)
            ListenerScript.AddIngameEventToConversation("The trade did not happen: " + playerName + " has only " + PlayerRef.GetItemCount(playerItem) + " " + playerItem.GetName() + ", not " + playerCount + ".")
            Debug.Notification("Trade: you have only " + PlayerRef.GetItemCount(playerItem) + " " + playerItem.GetName())
            return
        endIf
    endIf
    if (playerGold > 0 && PlayerRef.GetItemCount(gold) < playerGold)
        ListenerScript.AddIngameEventToConversation("The trade did not happen: " + playerName + " does not have the " + playerGold + " gold.")
        Debug.Notification("Trade: you don't have " + playerGold + " gold")
        return
    endIf
    Form npcItem = None
    if (npcMatch != "")
        npcItem = LwTradeFindItem(npc, npcMatch, npcCount)
        if (!npcItem || npc.GetItemCount(npcItem) < npcCount)
            ListenerScript.AddIngameEventToConversation("The trade did not happen: " + npcName + " does not have " + npcCount + " " + LwTradeFirstTerm(npcMatch) + " on them.")
            Debug.Notification("Trade: " + npcName + " doesn't have the " + LwTradeFirstTerm(npcMatch))
            return
        endIf
    endIf

    ; Swap. Not silent, so the player sees what came and went.
    string gave = ""
    string got = ""
    if (playerItem)
        PlayerRef.RemoveItem(playerItem, playerCount, false, npc)
        gave = playerCount + " " + playerItem.GetName()
    endIf
    if (playerGold > 0)
        PlayerRef.RemoveItem(gold, playerGold, false, npc)
        gave = LwTradeJoin(gave, playerGold + " gold")
    endIf
    if (npcItem)
        npc.RemoveItem(npcItem, npcCount, false, PlayerRef)
        got = npcCount + " " + npcItem.GetName()
    endIf
    if (npcGold > 0)
        int purse = npc.GetItemCount(gold)
        if (purse >= npcGold)
            npc.RemoveItem(gold, npcGold, false, PlayerRef)
        else
            if (purse > 0)
                npc.RemoveItem(gold, purse, true, PlayerRef)
            endIf
            PlayerRef.AddItem(gold, npcGold - purse, true)
            Debug.Notification(npcGold + " Gold added")
        endIf
        got = LwTradeJoin(got, npcGold + " gold")
    endIf
    if (gave == "")
        gave = "nothing"
    endIf
    if (got == "")
        got = "nothing"
    endIf
    ListenerScript.AddIngameEventToConversation("Trade done: " + playerName + " handed " + npcName + " " + gave + ", and " + npcName + " handed over " + got + ".")
    Debug.Trace("Mantella Living World: trade with " + npcName + ": player gave " + gave + ", got " + got)
endFunction

string function LwTradeJoin(string a, string b)
    if (a == "")
        return b
    endIf
    return a + " and " + b
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LIVINGWORLD PATCH: actions (sit, stand up, go there)                                              ;
; The Living World server offers these to the LLM only when MANTELLA_LIVING_WORLD=1 (see             ;
; livingworld/actions/ in MantellaExtension), so without it these handlers never fire.               ;
; Each action arrives in two forms, like Mantella's own: the advanced one (tool call with arguments) ;
; and the basic one ("Sit:" at the start of the reply, speaker only).                                ;
; "There" / "that one" means what the player points at: the VR activation crosshair, or the last     ;
; thing it rested on in the past LivingWorldPointMemorySeconds (the player has usually lowered their  ;
; hand by the time the reply arrives).                                                               ;
; NPCs told to sit or stay go back to it if their AI pulls them away, for LivingWorldHoldSeconds,    ;
; until StandUp, a new order, combat, or LivingWorldMaxReturns returns.                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

float property LivingWorldHoldSeconds = 180.0 auto hidden
int property LivingWorldMaxReturns = 4 auto hidden
float property LivingWorldFurnitureSearchUnits = 2500.0 auto hidden   ; about 35 m
float property LivingWorldPointMemorySeconds = 20.0 auto hidden

ObjectReference _lwPointedFurniture   ; last furniture the crosshair rested on
float _lwPointedFurnitureTime
ObjectReference _lwPointedPlace       ; last thing that was not a person (people get MoveTo instead)
float _lwPointedPlaceTime
Actor[] _lwOrderActors      ; one slot per NPC under a sit / stay order
int[] _lwOrderIds           ; the order each NPC is under; a new order or StandUp changes it
ObjectReference[] _lwClaimed ; furniture already picked for someone and not yet sat on
int _lwOrderCounter

function LivingWorldRegisterActions()
    RegisterForModEvent("MantellaConversation_Advanced_Action_mantella_lw_npc_sit", "OnLwSitAdvanced")
    RegisterForModEvent("MantellaConversation_Action_mantella_lw_npc_sit", "OnLwSitBasic")
    RegisterForModEvent("MantellaConversation_Advanced_Action_mantella_lw_npc_standup", "OnLwStandUpAdvanced")
    RegisterForModEvent("MantellaConversation_Action_mantella_lw_npc_standup", "OnLwStandUpBasic")
    RegisterForModEvent("MantellaConversation_Advanced_Action_mantella_lw_npc_gothere", "OnLwGoThereAdvanced")
    RegisterForModEvent("MantellaConversation_Action_mantella_lw_npc_gothere", "OnLwGoThereBasic")
    RegisterForModEvent("MantellaLivingWorld_SitOne", "OnLwSitOneStarted")
    RegisterForModEvent("MantellaLivingWorld_GoOne", "OnLwGoOneStarted")
    RegisterForModEvent("MantellaConversation_Advanced_Action_mantella_lw_npc_orderdrinks", "OnLwOrderDrinksAdvanced")
    RegisterForModEvent("MantellaConversation_Action_mantella_lw_npc_orderdrinks", "OnLwOrderDrinksBasic")
    RegisterForModEvent("MantellaLivingWorld_OrderOne", "OnLwOrderOneStarted")
    RegisterForModEvent("LivingWorld_SitSpell", "OnLwSitSpell")   ; LWSitDown.esp's "Sit Down" spell
    LwRegisterUndress()
    LwRegisterTrade()
    RegisterForCrosshairRef()
    if (!_lwOrderActors)
        _lwOrderActors = new Actor[16]
        _lwOrderIds = new int[16]
        _lwClaimed = new ObjectReference[16]
    endIf
endFunction

; Players usually point at the chair, then look back at the NPC while speaking, so the pointed
; furniture and place are remembered separately from whatever the crosshair is on now.
Event OnCrosshairRefChange(ObjectReference ref)
    if (ref as Actor) ; LIVINGWORLD PATCH: fog, the name over the crosshair is right before it shows
        LivingWorldFog.Apply(ref as Actor, LivingWorldFogKnown, LivingWorldFogActive())
        LivingWorldGuardNameApply(ref as Actor) ; LIVINGWORLD PATCH: guard names
    endIf
    LwNotePointed(ref)
EndEvent

function LwNotePointed(ObjectReference ref)
    if (!ref)
        return
    endIf
    Actor person = ref as Actor
    if (person)
        if (LwCouldBeBartender(person))
            _lwPointedPerson = person
            _lwPointedPersonTime = Utility.GetCurrentRealTime()
        endIf
        return
    endIf
    float now = Utility.GetCurrentRealTime()
    _lwPointedPlace = ref
    _lwPointedPlaceTime = now
    if (LwIsFurniture(ref))
        _lwPointedFurniture = ref
        _lwPointedFurnitureTime = now
    endIf
endFunction

; What the player means by "there": furniture only, or any place that is not a person.
ObjectReference function LwPointedRef(bool furnitureOnly)
    LwNotePointed(Game.GetCurrentCrosshairRef())
    float now = Utility.GetCurrentRealTime()
    if (furnitureOnly)
        if (_lwPointedFurniture && now - _lwPointedFurnitureTime <= LivingWorldPointMemorySeconds)
            return _lwPointedFurniture
        endIf
    elseIf (_lwPointedPlace && now - _lwPointedPlaceTime <= LivingWorldPointMemorySeconds)
        return _lwPointedPlace
    endIf
    return None
endFunction

; ---- event entry points ----

Event OnLwSitAdvanced(Form speaker, Form conversationQuest, int argumentsHandle)
    string kind = SKSE_HTTP.getString(argumentsHandle, "furniture", "pointed")
    Actor[] npcs = LwSources(conversationQuest, argumentsHandle)
    int i = 0
    while (i < npcs.Length)
        if (npcs[i])
            LwSitOne(npcs[i], kind)
        endIf
        i += 1
    endWhile
EndEvent

Event OnLwSitBasic(Form speaker)
    LwSitOne(speaker as Actor, "pointed")
EndEvent

Event OnLwStandUpAdvanced(Form speaker, Form conversationQuest, int argumentsHandle)
    Actor[] npcs = LwSources(conversationQuest, argumentsHandle)
    int i = 0
    while (i < npcs.Length)
        LwStandUp(npcs[i])
        i += 1
    endWhile
EndEvent

Event OnLwStandUpBasic(Form speaker)
    LwStandUp(speaker as Actor)
EndEvent

Event OnLwGoThereAdvanced(Form speaker, Form conversationQuest, int argumentsHandle)
    Actor[] npcs = LwSources(conversationQuest, argumentsHandle)
    int i = 0
    while (i < npcs.Length)
        if (npcs[i])
            LwGoThere(npcs[i])
        endIf
        i += 1
    endWhile
EndEvent

Event OnLwGoThereBasic(Form speaker)
    LwGoThere(speaker as Actor)
EndEvent

Actor[] function LwSources(Form conversationQuest, int argumentsHandle)
    MantellaConversation conv = conversationQuest as MantellaConversation
    string[] names = SKSE_HTTP.getStringArray(argumentsHandle, "source")
    Actor[] result = new Actor[12]
    int i = 0
    while (i < names.Length && i < 12)
        Actor a = conv.GetActorByName(names[i])
        if (a && a != PlayerRef && !a.IsDead())
            result[i] = a
        endIf
        i += 1
    endWhile
    return result
endFunction

; ---- orders: a later order for the same NPC ends the earlier one's hold loop ----

int function LwNewOrder(Actor npc)
    _lwOrderCounter += 1
    int slot = _lwOrderActors.Find(npc)
    if (slot < 0)
        slot = _lwOrderActors.Find(None)
    endIf
    if (slot < 0)
        slot = _lwOrderCounter % _lwOrderActors.Length  ; full: reuse a slot (its loop just ends)
    endIf
    _lwOrderActors[slot] = npc
    _lwOrderIds[slot] = _lwOrderCounter
    return _lwOrderCounter
endFunction

bool function LwOrderStands(Actor npc, int orderId)
    int slot = _lwOrderActors.Find(npc)
    return slot >= 0 && _lwOrderIds[slot] == orderId && !npc.IsDead() && !npc.IsInCombat()
endFunction

function LwEndOrder(Actor npc, int orderId)
    int slot = _lwOrderActors.Find(npc)
    if (slot >= 0 && (orderId == 0 || _lwOrderIds[slot] == orderId))
        _lwOrderActors[slot] = None
        _lwOrderIds[slot] = 0
        _lwClaimed[slot] = None
    endIf
endFunction

; ---- furniture ----

bool function LwIsFurniture(ObjectReference ref)
    return ref && ref.GetBaseObject() && ref.GetBaseObject().GetType() == 40   ; kFurniture
endFunction

; Furniture is recognised by its name ("Chair", "Wooden Bench", "Bedroll", ...), since Skyrim's furniture
; keywords differ between mods. "pointed" and anything unknown accept any furniture.
bool function LwFurnitureMatches(ObjectReference ref, string kind)
    string n = ref.GetBaseObject().GetName()
    if (n == "")
        n = ref.GetDisplayName()
    endIf
    if (kind == "bed")
        return StringUtil.Find(n, "bed") >= 0
    elseIf (kind == "chair" || kind == "bench" || kind == "stool")
        return StringUtil.Find(n, kind) >= 0
    elseIf (kind == "seat")
        return StringUtil.Find(n, "chair") >= 0 || StringUtil.Find(n, "bench") >= 0 || StringUtil.Find(n, "stool") >= 0 || StringUtil.Find(n, "throne") >= 0 || StringUtil.Find(n, "seat") >= 0
    endIf
    return n != ""
endFunction

bool function LwFurnitureFree(ObjectReference ref)
    return !ref.IsFurnitureInUse() && _lwClaimed.Find(ref) < 0 && !ref.IsDisabled()
endFunction

ObjectReference function LwNearestFurniture(Actor npc, string kind)
    Cell c = npc.GetParentCell()
    if (!c)
        return None
    endIf
    ObjectReference best = None
    float bestDistance = LivingWorldFurnitureSearchUnits
    int count = c.GetNumRefs(40)
    int i = 0
    while (i < count)
        ObjectReference ref = c.GetNthRef(i, 40)
        if (ref && LwFurnitureMatches(ref, kind) && LwFurnitureFree(ref))
            float d = npc.GetDistance(ref)
            if (d < bestDistance)
                best = ref
                bestDistance = d
            endIf
        endIf
        i += 1
    endWhile
    return best
endFunction

; ---- sit ----

function LwSitOne(Actor npc, string kind)
    if (!npc || npc == PlayerRef)
        return
    endIf
    if (kind != "pointed" && LwIsSeated(npc))
        return   ; "I'll sit with you" while already sitting: stay put
    endIf
    if (kind == "")
        kind = "pointed"
    endIf
    ObjectReference seat = None
    if (kind == "pointed")
        ObjectReference pointed = LwPointedRef(true)
        if (pointed && LwFurnitureFree(pointed))
            seat = pointed
        else
            kind = "seat"   ; nothing (free) pointed at: the nearest seat instead
        endIf
    endIf
    if (!seat)
        seat = LwNearestFurniture(npc, kind)
    endIf
    if (!seat)
        Debug.Notification(npc.GetDisplayName() + " finds no free " + kind + " nearby.")
        ListenerScript.AddIngameEventToConversation(npc.GetDisplayName() + " looked around but there was no free " + kind + " nearby.")
        return
    endIf
    int orderId = LwNewOrder(npc)
    _lwClaimed[_lwOrderActors.Find(npc)] = seat   ; so the next NPC in a group order picks another seat
    Debug.Notification(npc.GetDisplayName() + " goes to sit down.")
    ; walking and the hold loop run in their own event thread, so several NPCs go at once
    int handle = ModEvent.Create("MantellaLivingWorld_SitOne")
    if (handle)
        ModEvent.PushForm(handle, npc)
        ModEvent.PushForm(handle, seat)
        ModEvent.PushInt(handle, orderId)
        ModEvent.Send(handle)
    endIf
endFunction

Event OnLwSitOneStarted(Form npcForm, Form seatForm, int orderId)
    LwSitAndHold(npcForm as Actor, seatForm as ObjectReference, orderId)
EndEvent

function LwSitAndHold(Actor npc, ObjectReference seat, int orderId)
    if (!npc || !seat)
        return
    endIf
    bool wasWaiting = LwPauseFollowerWait(npc)
    if (npc.GetDistance(seat) > 150.0)
        npc.PathToReference(seat, 1.0)   ; latent: other events keep running meanwhile
    endIf
    if (!LwOrderStands(npc, orderId))
        if (wasWaiting)
            npc.SetActorValue("WaitingForPlayer", 1)
        endIf
        return
    endIf
    seat.Activate(npc)
    Utility.Wait(2.0)
    if (LwOrderStands(npc, orderId) && !LwIsSeated(npc))
        seat.Activate(npc)   ; once more: the first activation is sometimes eaten by the AI
    endIf
    int slot = _lwOrderActors.Find(npc)
    if (slot >= 0)
        _lwClaimed[slot] = None
    endIf
    if (wasWaiting)
        npc.SetActorValue("WaitingForPlayer", 1)
    endIf
    string seatName = seat.GetDisplayName()
    if (LwIsSeated(npc))
        ListenerScript.AddIngameEventToConversation(npc.GetDisplayName() + " sat down on the " + seatName + ".")
    endIf
    ; hold: sit back down if the AI makes them get up
    float until = Utility.GetCurrentRealTime() + LivingWorldHoldSeconds
    int returns = 0
    while (LwOrderStands(npc, orderId) && Utility.GetCurrentRealTime() < until && returns < LivingWorldMaxReturns)
        Utility.Wait(3.0)
        if (LwOrderStands(npc, orderId) && !LwIsSeated(npc))
            if (seat.IsFurnitureInUse())
                LwEndOrder(npc, orderId)   ; someone else took it
            else
                if (npc.GetDistance(seat) > 150.0)
                    npc.PathToReference(seat, 1.0)
                endIf
                if (LwOrderStands(npc, orderId))
                    seat.Activate(npc)
                endIf
                returns += 1
            endIf
        endIf
    endWhile
    LwEndOrder(npc, orderId)
endFunction

bool function LwIsSeated(Actor npc)
    return npc.GetSitState() == 3 || npc.GetSitState() == 2 || npc.GetSleepState() >= 2
endFunction

; Followers told to wait keep their spot through the wait package; clear it while they walk.
bool function LwPauseFollowerWait(Actor npc)
    if (npc.IsPlayerTeammate() && npc.GetActorValue("WaitingForPlayer") == 1)
        npc.SetActorValue("WaitingForPlayer", 0)
        npc.EvaluatePackage()
        return true
    endIf
    return false
endFunction

; ---- "Sit Down" spell (Tools/LWSitDown) ----
; Cast at an NPC: they sit in the chair, bench or stool the player pointed at in the last
; LivingWorldPointMemorySeconds, else the nearest free one, and stay seated like a spoken Sit order.
; Cast at someone already sitting: they stand up. No conversation needed.

Event OnLwSitSpell(Form npcForm)
    Actor npc = npcForm as Actor
    if (!npc || npc == PlayerRef || npc.IsDead())
        return
    endIf
    if (npc.IsChild())
        return   ; children are left out of Living World
    endIf
    if (npc.IsInCombat())
        Debug.Notification(npc.GetDisplayName() + " will not sit down in the middle of a fight.")
        return
    endIf
    if (LwIsSeated(npc))
        LwStandUp(npc)
        return
    endIf
    ObjectReference pointed = LwPointedRef(true)
    if (pointed && LwFurnitureFree(pointed) && LwFurnitureMatches(pointed, "seat"))
        LwSitOne(npc, "pointed")
    else
        LwSitOne(npc, "seat")
    endIf
EndEvent

; ---- stand up ----

function LwStandUp(Actor npc)
    if (!npc)
        return
    endIf
    LwNewOrder(npc)        ; ends any hold loop still running for them
    LwEndOrder(npc, 0)
    if (!LwIsSeated(npc))
        return
    endIf
    Debug.Notification(npc.GetDisplayName() + " gets up.")
    npc.EvaluatePackage()
    Utility.Wait(3.0)
    if (LwIsSeated(npc))
        ; their AI package wants them seated; step them out of the furniture where they are
        npc.MoveTo(npc)
    endIf
endFunction

; ---- go there ----

function LwGoThere(Actor npc)
    if (!npc || npc == PlayerRef)
        return
    endIf
    ObjectReference target = LwPointedRef(false)
    if (!target)
        ListenerScript.AddIngameEventToConversation(npc.GetDisplayName() + " could not tell where " + PlayerRef.GetDisplayName() + " meant.")
        return
    endIf
    if (LwIsFurniture(target) && LwFurnitureFree(target) && LwFurnitureMatches(target, "seat"))
        LwSitOne(npc, "pointed")
        return
    endIf
    int orderId = LwNewOrder(npc)
    Debug.Notification(npc.GetDisplayName() + " heads over there.")
    int handle = ModEvent.Create("MantellaLivingWorld_GoOne")
    if (handle)
        ModEvent.PushForm(handle, npc)
        ModEvent.PushForm(handle, target)
        ModEvent.PushInt(handle, orderId)
        ModEvent.Send(handle)
    endIf
endFunction

Event OnLwGoOneStarted(Form npcForm, Form targetForm, int orderId)
    LwGoAndHold(npcForm as Actor, targetForm as ObjectReference, orderId)
EndEvent

function LwGoAndHold(Actor npc, ObjectReference target, int orderId)
    if (!npc || !target)
        return
    endIf
    bool wasWaiting = LwPauseFollowerWait(npc)
    npc.PathToReference(target, 1.0)
    if (wasWaiting)
        npc.SetActorValue("WaitingForPlayer", 1)
    endIf
    float until = Utility.GetCurrentRealTime() + LivingWorldHoldSeconds
    int returns = 0
    while (LwOrderStands(npc, orderId) && Utility.GetCurrentRealTime() < until && returns < LivingWorldMaxReturns)
        Utility.Wait(3.0)
        if (LwOrderStands(npc, orderId) && npc.GetDistance(target) > 400.0)
            npc.PathToReference(target, 1.0)
            returns += 1
        endIf
    endWhile
    LwEndOrder(npc, orderId)
endFunction

; ---- order drinks from the bar ----
; The NPC walks to the bartender (named by the LLM, else the person the player last pointed at), buys a
; round of two, walks back and hands one to the player. The drink comes from the bartender's own
; inventory, else is the same kind as a bottle standing in the cell (inns have them on the tables), so no
; form IDs are hard-coded. Price: the drink's base value each. The payer is the player (default) or the
; NPC; if they cannot afford it the NPC comes back empty-handed. Queues a purchase perception record.

Actor _lwPointedPerson     ; last person the crosshair rested on (for "get drinks from her")
float _lwPointedPersonTime

Event OnLwOrderDrinksAdvanced(Form speaker, Form conversationQuest, int argumentsHandle)
    MantellaConversation conv = conversationQuest as MantellaConversation
    Actor npc = conv.GetActorByName(SKSE_HTTP.getString(argumentsHandle, "source", ""))
    if (!npc)
        npc = speaker as Actor
    endIf
    string bartenderName = SKSE_HTTP.getString(argumentsHandle, "bartender", "")
    Actor bartender = None
    if (bartenderName != "")
        bartender = conv.GetActorByName(bartenderName)
    endIf
    LwOrderDrinks(npc, bartender, SKSE_HTTP.getString(argumentsHandle, "drink", ""), SKSE_HTTP.getString(argumentsHandle, "payer", "player"))
EndEvent

Event OnLwOrderDrinksBasic(Form speaker)
    LwOrderDrinks(speaker as Actor, None, "", "player")
EndEvent

function LwOrderDrinks(Actor npc, Actor bartender, string wanted, string payer)
    if (!npc || npc == PlayerRef || npc.IsChild())
        return
    endIf
    if (!bartender)
        bartender = LwPointedPerson()
    endIf
    if (!bartender || bartender == npc || bartender == PlayerRef || bartender.IsDead())
        ListenerScript.AddIngameEventToConversation(npc.GetDisplayName() + " did not know who to ask for drinks. (Say the bartender's name, or point at them.)")
        return
    endIf
    if (wanted == "")
        wanted = "mead"
    endIf
    if (payer != "npc")
        payer = "player"
    endIf
    int orderId = LwNewOrder(npc)
    Debug.Notification(npc.GetDisplayName() + " goes to the bar.")
    int handle = ModEvent.Create("MantellaLivingWorld_OrderOne")
    if (handle)
        ModEvent.PushForm(handle, npc)
        ModEvent.PushForm(handle, bartender)
        ModEvent.PushString(handle, wanted)
        ModEvent.PushString(handle, payer)
        ModEvent.PushInt(handle, orderId)
        ModEvent.Send(handle)
    endIf
endFunction

Event OnLwOrderOneStarted(Form npcForm, Form bartenderForm, string wanted, string payer, int orderId)
    LwFetchRound(npcForm as Actor, bartenderForm as Actor, wanted, payer, orderId)
EndEvent

Actor function LwPointedPerson()
    Actor now = Game.GetCurrentCrosshairRef() as Actor
    if (LwCouldBeBartender(now))
        return now
    endIf
    if (_lwPointedPerson && Utility.GetCurrentRealTime() - _lwPointedPersonTime <= LivingWorldPointMemorySeconds)
        return _lwPointedPerson
    endIf
    return None
endFunction

; The people in the conversation are the ones ordering, not the bartender.
bool function LwCouldBeBartender(Actor a)
    return a && a != PlayerRef && !a.IsDead() && !ListenerScript.conversation.Participants.HasForm(a)
endFunction

function LwFetchRound(Actor npc, Actor bartender, string wanted, string payer, int orderId)
    if (!npc || !bartender)
        return
    endIf
    bool wasWaiting = LwPauseFollowerWait(npc)
    npc.PathToReference(bartender, 1.0)
    if (!LwOrderStands(npc, orderId))
        LwRestoreWait(npc, wasWaiting)
        return
    endIf
    string npcName = npc.GetDisplayName()
    Potion drink = LwRoundDrink(bartender, wanted)
    if (!drink)
        npc.PathToReference(PlayerRef, 1.0)
        LwRestoreWait(npc, wasWaiting)
        LwEndOrder(npc, orderId)
        ListenerScript.AddIngameEventToConversation(npcName + " came back from the bar empty-handed: " + bartender.GetDisplayName() + " had no " + wanted + ".")
        return
    endIf
    int each = drink.GetGoldValue()
    if (each < 1)
        each = 1
    endIf
    int total = each * 2
    Form gold = Game.GetFormFromFile(0x0000000F, "Skyrim.esm")   ; Gold001
    Actor payingActor = PlayerRef
    if (payer == "npc")
        payingActor = npc
    endIf
    if (payingActor.GetItemCount(gold) < total)
        npc.PathToReference(PlayerRef, 1.0)
        LwRestoreWait(npc, wasWaiting)
        LwEndOrder(npc, orderId)
        ListenerScript.AddIngameEventToConversation(npcName + " came back from the bar empty-handed: " + payingActor.GetDisplayName() + " did not have the " + total + " gold for two " + drink.GetName() + ".")
        return
    endIf
    payingActor.RemoveItem(gold, total, true, bartender)
    ; take the bartender's own bottles first, then the rest of the round
    int fromBar = bartender.GetItemCount(drink)
    if (fromBar > 2)
        fromBar = 2
    endIf
    if (fromBar > 0)
        bartender.RemoveItem(drink, fromBar, true, npc)
    endIf
    if (fromBar < 2)
        npc.AddItem(drink, 2 - fromBar, true)
    endIf
    LwRecordPurchase(npc, bartender, drink, 2, total, payer)
    Debug.Notification(npcName + " buys two " + drink.GetName() + ".")
    npc.PathToReference(PlayerRef, 1.0)
    LwRestoreWait(npc, wasWaiting)
    LwEndOrder(npc, orderId)
    if (npc.GetItemCount(drink) > 0)
        npc.RemoveItem(drink, 1, false, PlayerRef)   ; not silent: the player sees the drink arrive
    endIf
    string paidBy = "on " + PlayerRef.GetDisplayName() + "'s gold"
    if (payer == "npc")
        paidBy = "as " + npcName + "'s treat"
    endIf
    ListenerScript.AddIngameEventToConversation(npcName + " came back from the bar with two " + drink.GetName() + " (" + total + " gold, " + paidBy + ") and handed one to " + PlayerRef.GetDisplayName() + ".")
endFunction

function LwRestoreWait(Actor npc, bool wasWaiting)
    if (wasWaiting)
        npc.SetActorValue("WaitingForPlayer", 1)
    endIf
endFunction

; The drink to buy: from the bartender's inventory, else the kind of a matching bottle in the cell.
Potion function LwRoundDrink(Actor bartender, string wanted)
    int n = bartender.GetNumItems()
    int i = 0
    while (i < n)
        Potion p = bartender.GetNthForm(i) as Potion
        if (p && p.IsFood() && !p.IsPoison() && StringUtil.Find(p.GetName(), wanted) >= 0 && LivingWorldIsAlcohol(p.GetName()))
            return p
        endIf
        i += 1
    endWhile
    Cell c = bartender.GetParentCell()
    if (!c)
        return None
    endIf
    n = c.GetNumRefs(46)   ; kAlchemy: potions, food and drink placed in the world
    i = 0
    while (i < n)
        ObjectReference ref = c.GetNthRef(i, 46)
        Potion p = None
        if (ref)
            p = ref.GetBaseObject() as Potion
        endIf
        if (p && p.IsFood() && !p.IsPoison() && StringUtil.Find(p.GetName(), wanted) >= 0 && LivingWorldIsAlcohol(p.GetName()))
            return p
        endIf
        i += 1
    endWhile
    return None
endFunction

function LwRecordPurchase(Actor buyer, Actor seller, Potion drink, int qty, int gold, string payer)
    string rec = LivingWorldHeader("purchase") + "|actor=" + LivingWorldActorField(buyer) + "|target=" + LivingWorldActorField(seller) + "|item=" + drink.GetName() + "|item_form=" + drink.GetFormID() + "|qty=" + qty + "|gold=" + gold + "|payer=" + payer + "|party=" + LivingWorldActorField(PlayerRef)
    rec += LivingWorldWitnesses(buyer, seller)
    LivingWorldQueue(rec)
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LIVINGWORLD PATCH: undress and dress (actions)                                                     ;
; The NPC's own choice: the server only offers Undress, and the NPC decides in conversation whether  ;
; to use it (see livingworld/actions/undress.json in MantellaExtension). Nothing here decides that.  ;
; Undress unequips every worn, playable armor and clothing item (weapons stay; nothing leaves the    ;
; inventory, unlike RemoveAllItems) and remembers what it took off. If the NPC's AI puts something    ;
; back on, it comes off again for LivingWorldUndressHoldSeconds, until Dress, combat or death.        ;
; Dress puts the remembered items back on. Both queue an attire record with via=action, so the       ;
; server remembers it as the NPC's choice and witnesses within sight remember seeing it.             ;
; Children are never undressed (LivingWorldIsPerson).                                                ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

float property LivingWorldUndressHoldSeconds = 600.0 auto hidden
int LwUndressItemsPerNpc = 16   ; items remembered per NPC; 8 NPCs x 16 = the 128 of _lwUndressItems

Actor[] _lwUndressed        ; one slot per undressed NPC
int[] _lwUndressOrder       ; a new Undress or Dress for the same NPC changes it, ending the hold loop
Form[] _lwUndressItems      ; slot * LwUndressItemsPerNpc .. + LwUndressItemsPerNpc - 1
int _lwUndressCounter

function LwRegisterUndress()
    RegisterForModEvent("MantellaConversation_Advanced_Action_mantella_lw_npc_undress", "OnLwUndressAdvanced")
    RegisterForModEvent("MantellaConversation_Action_mantella_lw_npc_undress", "OnLwUndressBasic")
    RegisterForModEvent("MantellaConversation_Advanced_Action_mantella_lw_npc_dress", "OnLwDressAdvanced")
    RegisterForModEvent("MantellaConversation_Action_mantella_lw_npc_dress", "OnLwDressBasic")
    RegisterForModEvent("MantellaLivingWorld_UndressHold", "OnLwUndressHoldStarted")
    if (!_lwUndressed)
        _lwUndressed = new Actor[8]
        _lwUndressOrder = new int[8]
        _lwUndressItems = new Form[128]
    endIf
endFunction

Actor function LwSingleSource(Form speaker, Form conversationQuest, int argumentsHandle)
    MantellaConversation conv = conversationQuest as MantellaConversation
    Actor npc = None
    if (conv)
        npc = conv.GetActorByName(SKSE_HTTP.getString(argumentsHandle, "source"))
    endIf
    if (!npc)
        npc = speaker as Actor
    endIf
    return npc
endFunction

Event OnLwUndressAdvanced(Form speaker, Form conversationQuest, int argumentsHandle)
    LwUndress(LwSingleSource(speaker, conversationQuest, argumentsHandle))
EndEvent

Event OnLwUndressBasic(Form speaker)
    LwUndress(speaker as Actor)
EndEvent

Event OnLwDressAdvanced(Form speaker, Form conversationQuest, int argumentsHandle)
    LwDress(LwSingleSource(speaker, conversationQuest, argumentsHandle))
EndEvent

Event OnLwDressBasic(Form speaker)
    LwDress(speaker as Actor)
EndEvent

; the NPC's slot, claiming a free (or the oldest) one if they have none
int function LwUndressSlot(Actor npc, bool claim)
    int slot = _lwUndressed.Find(npc)
    if (slot >= 0 || !claim)
        return slot
    endIf
    slot = _lwUndressed.Find(None)
    if (slot < 0)
        _lwUndressCounter += 1
        slot = _lwUndressCounter % _lwUndressed.Length
    endIf
    _lwUndressed[slot] = npc
    int i = 0
    while (i < LwUndressItemsPerNpc)
        _lwUndressItems[slot * LwUndressItemsPerNpc + i] = None
        i += 1
    endWhile
    return slot
endFunction

; Armor the NPC wears that Undress takes off: playable items only, so skins and body overlays stay.
bool function LwTakesOff(Armor item)
    return item && item.IsPlayable()
endFunction

function LwUndress(Actor npc)
    if (!npc || npc == PlayerRef || !LivingWorldIsPerson(npc))
        return   ; never the player, never children
    endIf
    if (!_lwUndressed)
        LwRegisterUndress()
    endIf
    int slot = LwUndressSlot(npc, true)
    int base = slot * LwUndressItemsPerNpc
    int stored = 0
    while (stored < LwUndressItemsPerNpc && _lwUndressItems[base + stored])
        stored += 1   ; undressing again: keep what was remembered the first time
    endWhile
    int bit = 0
    while (bit < 32)
        Armor item = npc.GetWornForm(Math.LeftShift(1, bit)) as Armor
        if (LwTakesOff(item))
            if (stored < LwUndressItemsPerNpc && LwUndressFind(base, item) < 0)
                _lwUndressItems[base + stored] = item
                stored += 1
            endIf
            npc.UnequipItem(item, false, true)
        endIf
        bit += 1
    endWhile
    _lwUndressCounter += 1
    _lwUndressOrder[slot] = _lwUndressCounter
    Utility.Wait(0.5)
    LivingWorldQueue(LivingWorldAttireRecord(npc) + "|via=action")
    ListenerScript.AddIngameEventToConversation(npc.GetDisplayName() + " took off their clothes.")
    int handle = ModEvent.Create("MantellaLivingWorld_UndressHold")
    if (handle)
        ModEvent.PushForm(handle, npc)
        ModEvent.PushInt(handle, _lwUndressCounter)
        ModEvent.Send(handle)
    endIf
endFunction

int function LwUndressFind(int base, Form item)
    int i = 0
    while (i < LwUndressItemsPerNpc)
        if (_lwUndressItems[base + i] == item)
            return i
        endIf
        i += 1
    endWhile
    return -1
endFunction

bool function LwUndressStands(Actor npc, int orderId)
    int slot = _lwUndressed.Find(npc)
    return slot >= 0 && _lwUndressOrder[slot] == orderId && !npc.IsDead() && !npc.IsInCombat()
endFunction

Event OnLwUndressHoldStarted(Form npcForm, int orderId)
    Actor npc = npcForm as Actor
    if (!npc)
        return
    endIf
    ; NPC AI re-equips its outfit now and then: take the same items off again while the choice stands
    float until = Utility.GetCurrentRealTime() + LivingWorldUndressHoldSeconds
    while (LwUndressStands(npc, orderId) && Utility.GetCurrentRealTime() < until)
        Utility.Wait(3.0)
        int slot = _lwUndressed.Find(npc)
        if (slot >= 0 && LwUndressStands(npc, orderId))
            int base = slot * LwUndressItemsPerNpc
            int i = 0
            while (i < LwUndressItemsPerNpc)
                Armor item = _lwUndressItems[base + i] as Armor
                if (item && npc.IsEquipped(item))
                    npc.UnequipItem(item, false, true)
                endIf
                i += 1
            endWhile
        endIf
    endWhile
EndEvent

function LwDress(Actor npc)
    if (!npc || npc == PlayerRef || !LivingWorldIsPerson(npc))
        return
    endIf
    if (!_lwUndressed)
        LwRegisterUndress()
    endIf
    int slot = _lwUndressed.Find(npc)
    bool any = false
    if (slot >= 0)
        _lwUndressCounter += 1
        _lwUndressOrder[slot] = _lwUndressCounter   ; ends the hold loop
        int base = slot * LwUndressItemsPerNpc
        int i = 0
        while (i < LwUndressItemsPerNpc)
            Form item = _lwUndressItems[base + i]
            if (item && npc.GetItemCount(item) > 0)
                npc.EquipItem(item, false, true)
                any = true
            endIf
            _lwUndressItems[base + i] = None
            i += 1
        endWhile
        _lwUndressed[slot] = None
        _lwUndressOrder[slot] = 0
    endIf
    if (!any)
        ; nothing remembered (or it was given away): let their own outfit dress them
        Outfit usual = npc.GetActorBase().GetOutfit()
        if (usual)
            npc.SetOutfit(usual)
        endIf
    endIf
    Utility.Wait(0.5)
    LivingWorldQueue(LivingWorldAttireRecord(npc) + "|via=action")
    ListenerScript.AddIngameEventToConversation(npc.GetDisplayName() + " got dressed again.")
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LIVINGWORLD PATCH: quiet vanilla chatter during a Mantella conversation                            ;
; When the Living World server asks for it (mantella_lw_quiet_chatter on the start reply), vanilla  ;
; hellos, idle chatter, NPC-to-NPC small talk and comments on the player's actions are turned off   ;
; through game settings until the conversation ends. Combat dialogue and quest force-greets are     ;
; left alone. Game settings are not kept in the save, so the muted values are distinctive and are   ;
; put back on cleanup and on every game load (also after a crash or a load mid-conversation).       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

float[] _lwChatterSaved   ; the values in use before muting (another mod's values are kept)

string function LwChatterSetting(int i)
    if i == 0
        return "fAIMinGreetingDistance"
    elseIf i == 1
        return "fAIGreetingTimer"
    elseIf i == 2
        return "fAIExclusiveGreetingTimer"
    elseIf i == 3
        return "fIdleChatterCommentTimer"
    elseIf i == 4
        return "fIdleChatterCommentTimerMax"
    elseIf i == 5
        return "fAISocialTimerForConversationsMin"
    elseIf i == 6
        return "fAISocialTimerForConversationsMax"
    endIf
    return "fCommentOnPlayerActionsTimer"
endFunction

float function LwChatterVanilla(int i)
    if i == 0
        return 150.0
    elseIf i == 1
        return 5.0
    elseIf i == 2
        return 2.5
    elseIf i == 3
        return 10.0
    elseIf i == 4
        return 20.0
    elseIf i == 5
        return 10.0
    elseIf i == 6
        return 30.0
    endIf
    return 20.0
endFunction

float function LwChatterMuted(int i)
    if i == 0
        return 0.5        ; greet only from half a unit away: never
    endIf
    return 98765.0        ; seconds between lines: never during a conversation
endFunction

function LivingWorldMuteChatter()
    if !_lwChatterSaved || _lwChatterSaved.Length != 8
        _lwChatterSaved = new float[8]
    endIf
    int i = 0
    while i < 8
        string setting = LwChatterSetting(i)
        float current = Game.GetGameSettingFloat(setting)
        if current != LwChatterMuted(i)
            _lwChatterSaved[i] = current
        elseIf _lwChatterSaved[i] == LwChatterMuted(i) || _lwChatterSaved[i] < 0.0
            _lwChatterSaved[i] = LwChatterVanilla(i)
        endIf
        Game.SetGameSettingFloat(setting, LwChatterMuted(i))
        i += 1
    endWhile
endFunction

; Puts back only the settings that still hold the muted value, so a change made since by
; something else is left as it is. Safe to call at any time.
function LivingWorldRestoreChatter()
    int i = 0
    while i < 8
        string setting = LwChatterSetting(i)
        if Game.GetGameSettingFloat(setting) == LwChatterMuted(i)
            float original = LwChatterVanilla(i)
            if _lwChatterSaved && _lwChatterSaved.Length == 8 && _lwChatterSaved[i] != LwChatterMuted(i) && _lwChatterSaved[i] >= 0.0
                original = _lwChatterSaved[i]   ; filled on every mute, so this is the real earlier value
            endIf
            Game.SetGameSettingFloat(setting, original)
        endIf
        i += 1
    endWhile
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LIVINGWORLD PATCH: reputation (S2). Three more things the player does that people see and talk   ;
; about, queued like grabs (see livingworld/perception/records.py in MantellaExtension):            ;
;   gift  - items handed to an adult NPC outside trading (GiftMenu, or given with no menu open).    ;
;           Several items to one person within LwGiftMergeSeconds become one record.                ;
;   theft - when the game itself counts a theft ("Items Stolen") or a picked pocket ("Pockets       ;
;           Picked"), paired with the item the player just took. Nothing is guessed: no count, no  ;
;           record.                                                                                 ;
;   hit   - the player striking an adult NPC who is not an enemy: when the game counts an assault  ;
;           ("Assaults", the victim being the nearest person fighting the player), or when a        ;
;           conversation NPC is hit (MantellaTargetListenerScript.OnHit). One record per person per  ;
;           LwHitCooldownSeconds.                                                                   ;
; Handlers only copy a few values; witnesses are scanned once, when a record is written.            ;
; The server decides who saw what; this script never decides anything with it.                     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

bool property LivingWorldReputationOn = true auto hidden
float property LwGiftMergeSeconds = 10.0 auto hidden
float property LwTheftPairSeconds = 2.0 auto hidden
float property LwHitCooldownSeconds = 15.0 auto hidden

Actor _lwGiftTarget
string _lwGiftItem
int _lwGiftQty
int _lwGiftValue
bool _lwGiftMany
string _lwGiftVia
float _lwGiftAt

Form _lwTakenItem
int _lwTakenQty
ObjectReference _lwTakenFrom
ObjectReference _lwTakenRef
float _lwTakenAt = -100.0
string _lwTheftPending = ""
float _lwTheftPendingAt = -100.0

Actor _lwLastHit
float _lwLastHitAt = -100.0

; Called from LivingWorldRegisterPerception on every load (registering again is harmless).
function LwRegisterReputation()
    _lwGiftTarget = None
    _lwTheftPending = ""
    RegisterForTrackedStatsEvent()
endFunction

; MantellaListenerScript.OnItemRemoved, when the player's item went to an actor.
function LwNoteGiven(Actor receiver, Form item, int count)
    if (!LivingWorldReputationOn || !LivingWorldPerceptionOn || !receiver || receiver == PlayerRef)
        return
    endIf
    ; selling, a follower's pack and planting by pickpocket are not gifts
    if (UI.IsMenuOpen("BarterMenu") || UI.IsMenuOpen("ContainerMenu") || !LivingWorldIsPerson(receiver))
        return
    endIf
    float now = Utility.GetCurrentRealTime()
    if (_lwGiftTarget && (_lwGiftTarget != receiver || now - _lwGiftAt > LwGiftMergeSeconds))
        LwFlushGift()
    endIf
    string itemName = item.GetName()
    if (!_lwGiftTarget)
        _lwGiftTarget = receiver
        _lwGiftItem = itemName
        _lwGiftQty = 0
        _lwGiftValue = 0
        _lwGiftMany = false
        _lwGiftVia = "hand"
        if (UI.IsMenuOpen("GiftMenu"))
            _lwGiftVia = "gift_menu"
        endIf
    elseIf (itemName != _lwGiftItem)
        _lwGiftMany = true
    endIf
    _lwGiftQty += count
    _lwGiftValue += item.GetGoldValue() * count
    _lwGiftAt = now
endFunction

; Writes the pending gift, if any. Also called before each request takes the event queue.
function LwFlushGift()
    Actor target = _lwGiftTarget
    if (!target)
        return
    endIf
    _lwGiftTarget = None
    string item = _lwGiftItem
    int qty = _lwGiftQty
    if (_lwGiftMany)
        item = _lwGiftItem + " and other things"
        qty = 1
    endIf
    string rec = LivingWorldHeader("gift") + "|actor=" + LivingWorldActorField(PlayerRef) + "|target=" + LivingWorldActorField(target) + "|item=" + item + "|qty=" + qty + "|gold=" + _lwGiftValue + "|via=" + _lwGiftVia + "|trank=" + target.GetRelationshipRank(PlayerRef)
    rec += LivingWorldWitnesses(PlayerRef, target)
    LivingWorldQueue(rec)
endFunction

; MantellaListenerScript.OnItemAdded: only remembers what was taken, in case the game calls it a theft.
function LwNoteTaken(Form item, int count, ObjectReference itemRef, ObjectReference source)
    _lwTakenItem = item
    _lwTakenQty = count
    _lwTakenFrom = source
    _lwTakenRef = itemRef
    _lwTakenAt = Utility.GetCurrentRealTime()
    if (_lwTheftPending != "" && _lwTakenAt - _lwTheftPendingAt <= LwTheftPairSeconds)
        string via = _lwTheftPending
        _lwTheftPending = ""
        LwRecordTheft(via)
    endIf
endFunction

Event OnTrackedStatsEvent(string asStat, int aiStatValue)
    if (!LivingWorldReputationOn || !LivingWorldPerceptionOn)
        return
    endIf
    string via = ""
    if (asStat == "Items Stolen")
        via = "take"
    elseIf (asStat == "Pockets Picked")
        via = "pickpocket"
    elseIf (asStat == "Assaults")
        LwAssault()
        return
    else
        return
    endIf
    float now = Utility.GetCurrentRealTime()
    if (_lwTakenItem && now - _lwTakenAt <= LwTheftPairSeconds)
        LwRecordTheft(via)
    else
        ; the item may arrive just after the count: OnItemAdded pairs them
        _lwTheftPending = via
        _lwTheftPendingAt = now
    endIf
EndEvent

function LwRecordTheft(string via)
    Form item = _lwTakenItem
    if (!item)
        return
    endIf
    _lwTakenItem = None
    Actor victim = _lwTakenFrom as Actor
    string owner = ""
    if (victim)
        if (victim.IsChild())
            return   ; children are left out of every Living World system
        endIf
        owner = victim.GetDisplayName()
    else
        ActorBase ownerBase = None
        if (_lwTakenFrom)
            ownerBase = _lwTakenFrom.GetActorOwner()
        endIf
        if (!ownerBase && _lwTakenRef)
            ownerBase = _lwTakenRef.GetActorOwner()
        endIf
        if (ownerBase)
            owner = ownerBase.GetName()
        endIf
    endIf
    string rec = LivingWorldHeader("theft") + "|actor=" + LivingWorldActorField(PlayerRef)
    if (victim && via == "pickpocket")
        rec += "|target=" + LivingWorldActorField(victim)
    endIf
    rec += "|item=" + item.GetName() + "|qty=" + _lwTakenQty + "|gold=" + (item.GetGoldValue() * _lwTakenQty) + "|via=" + via + "|owner=" + owner
    rec += LivingWorldWitnesses(PlayerRef, victim)
    LivingWorldQueue(rec)
endFunction

; The game counted an assault: the victim is the nearest adult person fighting the player.
function LwAssault()
    Actor[] nearby = ListenerScript.ScanNearbyActors()
    Actor best = None
    float bestDistance = 600.0   ; about 8.5 m
    int i = 0
    while (i < nearby.Length)
        Actor a = nearby[i]
        if (a && a != PlayerRef && LivingWorldIsPerson(a) && a.GetCombatTarget() == PlayerRef)
            float d = a.GetDistance(PlayerRef)
            if (d < bestDistance)
                best = a
                bestDistance = d
            endIf
        endIf
        i += 1
    endWhile
    if (best)
        LwRecordHit(best, None, "assault")
    endIf
endFunction

; Also called from MantellaTargetListenerScript.OnHit when the player hits a conversation NPC.
function LwRecordHit(Actor victim, Form hitSource, string via)  ; not 'weapon': Papyrus names ignore case, so it clashes with the Weapon type
    if (!LivingWorldReputationOn || !LivingWorldPerceptionOn || !victim || victim == PlayerRef || !LivingWorldIsPerson(victim))
        return
    endIf
    if (_lwScAny && LwSceneSlap(victim))
        return   ; a slap during an intimate scene is part of the scene (counted there), not an attack
    endIf
    if (via != "assault" && victim.IsHostileToActor(PlayerRef))
        return   ; fighting an enemy is not news
    endIf
    Spell castSpell = hitSource as Spell
    if (castSpell && !castSpell.IsHostile())
        return   ; an animation, expression or test spell cast on someone is not an attack
    endIf
    float now = Utility.GetCurrentRealTime()
    if (victim == _lwLastHit && now - _lwLastHitAt < LwHitCooldownSeconds)
        return
    endIf
    _lwLastHit = victim
    _lwLastHitAt = now
    string weaponName = ""
    if (hitSource)
        weaponName = hitSource.GetName()
    endIf
    string rec = LivingWorldHeader("hit") + "|actor=" + LivingWorldActorField(PlayerRef) + "|target=" + LivingWorldActorField(victim) + "|item=" + weaponName + "|via=" + via + "|trank=" + victim.GetRelationshipRank(PlayerRef)
    rec += LivingWorldWitnesses(PlayerRef, victim)
    LivingWorldQueue(rec)
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LIVINGWORLD PATCH: body language, step 1 (BL1): proximity and gaze                                 ;
; Up to four nearby NPCs are watched every half second (otherwise one look around every two         ;
; seconds). Each reacts on its own, from its expression profile: the server sends one per            ;
; conversation participant (mantella_lw_body: Name|comfort m|gaze|guard|steps back); anyone else     ;
; gets a default from their relationship rank with the player.                                       ;
; - Inside their comfort distance for 1.5 s: "crowd" record, a step back (unless they hold their     ;
;   ground), arms folded when guarded. They relax only once the player is 30% beyond it.             ;
; - Gaze (outside Mantella conversations, which set their own look-at): hold the player's gaze,      ;
;   glance now and then, or look away when the player faces them.                                    ;
; - Records (type=presence, MantellaExtension livingworld/bodylang/presence.py): approach, crowd,    ;
;   backed_off (only when the player moved away, never because the NPC stepped back), weapon, stare. ;
; Loop guards: only the player's behaviour is ever recorded; NPCs never step toward anyone; every    ;
; reaction has a cooldown; at most 4 reactions per NPC per minute and 12 records per minute in all.  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

bool property LivingWorldBodyLanguageOn = true auto hidden   ; the server's start reply switches it (MANTELLA_LW_BODY_LANGUAGE)
float property LwBodyWatchMeters = 6.0 auto hidden
float property LwBodyTickSeconds = 0.5 auto hidden
float property LwBodyScanSeconds = 2.0 auto hidden

Actor[] _lwbActors          ; the watched NPCs (4 slots)
float[] _lwbComfort         ; their profile
float[] _lwbGaze
float[] _lwbGuard
bool[] _lwbStep
bool[] _lwbInside           ; crowding state
float[] _lwbInsideSince
bool[] _lwbReported
float[] _lwbMinDist
float[] _lwbEntryX          ; where the player stood when crowding began
float[] _lwbEntryY
int[] _lwbCrowdN
float[] _lwbLastCrowdAt
float[] _lwbLastStepAt
float[] _lwbOffsetUntil     ; a step back holds until then
float[] _lwbLastArmsAt
float[] _lwbArmsUntil
float[] _lwbLastFarAt
float[] _lwbLastApproachAt
bool[] _lwbLookHeld
float[] _lwbGlanceUntil
float[] _lwbNextGlanceAt
float[] _lwbHeadAwayUntil
float[] _lwbStareSince
float[] _lwbLastStareAt
float[] _lwbLastWeaponAt
float[] _lwbReact1          ; times of the last four reactions (per-minute cap)
float[] _lwbReact2
float[] _lwbReact3
float[] _lwbReact4
Actor[] _lwbProfActors      ; profiles the server sent, by actor (ring of 16)
float[] _lwbProfComfort
float[] _lwbProfGaze
float[] _lwbProfGuard
bool[] _lwbProfStep
float[] _lwbProfPeek        ; how readily she glances at the naked player (-1: not sent)
float[] _lwbPeek            ; per slot
float[] _lwbPeekUntil       ; per slot: a glance down in progress until then
float[] _lwbNextPeekAt
float[] _lwbPeekRecAt
int _lwbProfNext = 0
float _lwbDueAt = 0.0
float _lwbScanDueAt = 0.0
bool _lwbWeaponWas = false
float _lwbRecWindowAt = 0.0
int _lwbRecCount = 0
Idle _lwbArmsIdle

; Called from LivingWorldRegisterPerception on every load: undoes anything a save kept half done.
function LwBodyReset()
    if (_lwbActors && _lwbActors.Length == 4)
        int i = 0
        while (i < 4)
            LwBodyRelease(i)
            i += 1
        endWhile
    endIf
    _lwbActors = new Actor[4]
    _lwbComfort = new float[4]
    _lwbGaze = new float[4]
    _lwbGuard = new float[4]
    _lwbStep = new bool[4]
    _lwbInside = new bool[4]
    _lwbInsideSince = new float[4]
    _lwbReported = new bool[4]
    _lwbMinDist = new float[4]
    _lwbEntryX = new float[4]
    _lwbEntryY = new float[4]
    _lwbCrowdN = new int[4]
    _lwbLastCrowdAt = new float[4]
    _lwbLastStepAt = new float[4]
    _lwbOffsetUntil = new float[4]
    _lwbLastArmsAt = new float[4]
    _lwbArmsUntil = new float[4]
    _lwbLastFarAt = new float[4]
    _lwbLastApproachAt = new float[4]
    _lwbLookHeld = new bool[4]
    _lwbGlanceUntil = new float[4]
    _lwbNextGlanceAt = new float[4]
    _lwbHeadAwayUntil = new float[4]
    _lwbStareSince = new float[4]
    _lwbLastStareAt = new float[4]
    _lwbLastWeaponAt = new float[4]
    _lwbReact1 = new float[4]
    _lwbReact2 = new float[4]
    _lwbReact3 = new float[4]
    _lwbReact4 = new float[4]
    _lwbPeek = new float[4]
    _lwbPeekUntil = new float[4]
    _lwbNextPeekAt = new float[4]
    _lwbPeekRecAt = new float[4]
    if (!_lwbProfPeek || _lwbProfPeek.Length != 16 || !_lwbProfActors || _lwbProfActors.Length != 16)
        _lwbProfPeek = new float[16]
        int k = 0
        while (k < 16)
            _lwbProfPeek[k] = -1.0   ; no peek from the server yet: the default from the relationship rank
            k += 1
        endWhile
    endIf
    if (!_lwbProfActors || _lwbProfActors.Length != 16)
        _lwbProfActors = new Actor[16]
        _lwbProfComfort = new float[16]
        _lwbProfGaze = new float[16]
        _lwbProfGuard = new float[16]
        _lwbProfStep = new bool[16]
        _lwbProfNext = 0
    endIf
    _lwbArmsIdle = Game.GetFormFromFile(0x000FF7F4, "Skyrim.esm") as Idle   ; IdleOffsetArmsCrossedStart
    _lwbWeaponWas = LwPlayerArmed()
    _lwbDueAt = 0.0
    _lwbScanDueAt = 0.0
endFunction

; Undo whatever this slot's NPC is doing for us: look-at, head turned away, step back, folded arms.
function LwBodyRelease(int i)
    Actor a = _lwbActors[i]
    if (a)
        if (_lwbLookHeld[i] || _lwbGlanceUntil[i] > 0.0 || (_lwbPeekUntil && _lwbPeekUntil[i] > 0.0))
            a.ClearLookAt()
        endIf
        if (_lwbHeadAwayUntil[i] > 0.0)
            a.SetHeadTracking(true)
        endIf
        if (_lwbOffsetUntil[i] > 0.0)
            a.ClearKeepOffsetFromActor()
        endIf
        if (_lwbArmsUntil[i] > 0.0)
            Debug.SendAnimationEvent(a, "OffsetStop")
        endIf
    endIf
    _lwbActors[i] = None
    _lwbInside[i] = false
    _lwbReported[i] = false
    _lwbLookHeld[i] = false
    _lwbGlanceUntil[i] = 0.0
    _lwbHeadAwayUntil[i] = 0.0
    _lwbOffsetUntil[i] = 0.0
    _lwbArmsUntil[i] = 0.0
    _lwbStareSince[i] = 0.0
    if (_lwbPeekUntil)
        _lwbPeekUntil[i] = 0.0
    endIf
endFunction

; The server's start reply says whether body language is on (mantella_lw_body_on). Off lets everyone go.
function LivingWorldSetBodyLanguage(bool on)
    if (on == LivingWorldBodyLanguageOn)
        return
    endIf
    LivingWorldBodyLanguageOn = on
    if (!on && _lwbActors)
        int i = 0
        while (i < 4)
            LwBodyRelease(i)
            i += 1
        endWhile
    elseIf (on && !_lwProbeOn)
        _lwbDueAt = 0.0
        LwScheduleNext(Utility.GetCurrentRealTime())
    endIf
endFunction

; The server's profiles (mantella_lw_body on an NPC line): "Name|comfort|gaze|guard|step|peek" (peek: newer servers).
function LivingWorldBodyProfiles(string[] profiles, MantellaConversation conv)
    if (!profiles || !_lwbProfActors)
        return
    endIf
    int p = 0
    while (p < profiles.Length)
        string[] parts = StringUtil.Split(profiles[p], "|")
        if (parts.Length >= 5)
            Actor a = conv.GetActorByName(parts[0])
            if (a)
                int at = _lwbProfActors.Find(a)
                if (at < 0)
                    at = _lwbProfNext
                    _lwbProfNext = (_lwbProfNext + 1) % 16
                    _lwbProfActors[at] = a
                endIf
                _lwbProfComfort[at] = parts[1] as float
                _lwbProfGaze[at] = parts[2] as float
                _lwbProfGuard[at] = parts[3] as float
                _lwbProfStep[at] = parts[4] == "1"
                if (_lwbProfPeek)
                    if (parts.Length >= 6)
                        _lwbProfPeek[at] = parts[5] as float
                    else
                        _lwbProfPeek[at] = -1.0
                    endIf
                endIf
                int slot = _lwbActors.Find(a)
                if (slot >= 0)
                    LwBodyLoadProfile(slot, a)
                endIf
            endIf
        endIf
        p += 1
    endWhile
endFunction

function LwBodyLoadProfile(int i, Actor a)
    int at = _lwbProfActors.Find(a)
    int rank = a.GetRelationshipRank(PlayerRef)
    _lwbPeek[i] = LwPeekDefault(a, rank)
    if (at >= 0)
        _lwbComfort[i] = _lwbProfComfort[at]
        _lwbGaze[i] = _lwbProfGaze[at]
        _lwbGuard[i] = _lwbProfGuard[at]
        _lwbStep[i] = _lwbProfStep[at]
        if (_lwbProfPeek && _lwbProfPeek[at] >= 0.0)
            _lwbPeek[i] = _lwbProfPeek[at]
        endIf
        return
    endIf
    ; no profile yet: a default from how they know the player
    _lwbComfort[i] = 1.0
    _lwbGaze[i] = 0.5
    _lwbGuard[i] = 0.3
    _lwbStep[i] = true
    if (rank >= 2)
        _lwbComfort[i] = 0.7
        _lwbGaze[i] = 0.7
        _lwbGuard[i] = 0.15
    elseIf (rank == 1)
        _lwbComfort[i] = 0.85
        _lwbGaze[i] = 0.6
    elseIf (rank < 0)
        _lwbComfort[i] = 1.4
        _lwbGaze[i] = 0.3
        _lwbGuard[i] = 0.65
    endIf
endFunction

bool function LwBodyBusy(Actor a)
    return a.IsInCombat() || a.GetSitState() != 0 || a.IsOnMount() || a.IsPlayerTeammate() || a.IsUnconscious() || a.IsBleedingOut()
endFunction

bool function LwBodyCanReact(int i, float now)
    if (now - _lwbReact4[i] < 60.0)   ; the oldest of the last four is less than a minute old
        return false
    endIf
    return true
endFunction

function LwBodyReacted(int i, float now)
    _lwbReact4[i] = _lwbReact3[i]
    _lwbReact3[i] = _lwbReact2[i]
    _lwbReact2[i] = _lwbReact1[i]
    _lwbReact1[i] = now
endFunction

function LwBodyRecord(Actor a, string what, string extra)
    float now = Utility.GetCurrentRealTime()
    if (now - _lwbRecWindowAt > 60.0)
        _lwbRecWindowAt = now
        _lwbRecCount = 0
    endIf
    if (_lwbRecCount >= 12)
        return
    endIf
    _lwbRecCount += 1
    LivingWorldQueue(LivingWorldHeader("presence") + "|actor=" + LivingWorldActorField(PlayerRef) + "|target=" + LivingWorldActorField(a) + "|what=" + what + extra)
endFunction

; Fill free slots with conversation participants and the closest person, drop anyone gone or far.
function LwBodyScan()
    float now = Utility.GetCurrentRealTime()
    int i = 0
    while (i < 4)
        Actor a = _lwbActors[i]
        if (a && (!a.Is3DLoaded() || !LivingWorldIsPerson(a) || a.GetDistance(PlayerRef) / 71.0210 > LwBodyWatchMeters + 2.0))
            LwBodyRelease(i)
        endIf
        i += 1
    endWhile
    MantellaConversation conv = ListenerScript.conversation
    if (conv && conv.IsRunning())
        FormList participants = conv.Participants
        int p = 0
        while (p < participants.GetSize())
            LwBodyAdd(participants.GetAt(p) as Actor, now)
            p += 1
        endWhile
    endIf
    Actor closest = Game.FindClosestActorFromRef(PlayerRef, LwBodyWatchMeters * 71.0210)
    if (closest) ; LIVINGWORLD PATCH: fog, someone who walks up and greets the player
        LivingWorldFog.Apply(closest, LivingWorldFogKnown, LivingWorldFogActive())
        LivingWorldGuardNameApply(closest) ; LIVINGWORLD PATCH: guard names
    endIf
    LwBodyAdd(closest, now)
endFunction

function LwBodyAdd(Actor a, float now)
    if (!a || a == PlayerRef || _lwbActors.Find(a) >= 0 || !a.Is3DLoaded() || !LivingWorldIsPerson(a))
        return
    endIf
    if (_lwScAny && LwInScene(a) >= 0)
        return   ; in an intimate scene: OStim moves them, and being close is the point
    endIf
    if (a.GetDistance(PlayerRef) / 71.0210 > LwBodyWatchMeters)
        return
    endIf
    int i = _lwbActors.Find(None)
    if (i < 0)
        return
    endIf
    _lwbActors[i] = a
    LwBodyLoadProfile(i, a)
    _lwbInside[i] = false
    _lwbReported[i] = false
    _lwbLastFarAt[i] = 0.0   ; other cooldowns stay with the slot, so leaving and coming back resets nothing
    _lwbStareSince[i] = 0.0
endFunction

; Weapon drawn with something to fear in hand. Skyrim counts raised fists as "weapon drawn" too, and in
; VR (VRIK hand poses, holding the hands out) that happens without the player meaning it, so empty
; hands, a torch or a shield alone do not count. A sword, axe, bow, staff or a readied spell does.
bool function LwPlayerArmed()
    if (!PlayerRef.IsWeaponDrawn())
        return false
    endIf
    return LwHandArmed(PlayerRef.GetEquippedItemType(0)) || LwHandArmed(PlayerRef.GetEquippedItemType(1))
endFunction

; GetEquippedItemType: 0 fists, 1-8 weapons (8 staff), 9 spell, 10 shield, 11 torch, 12 crossbow.
bool function LwHandArmed(int t)
    return (t >= 1 && t <= 9) || t == 12
endFunction

; One body language step. Returns true while anyone is watched (the next step comes sooner).
bool function LwBodyTick(float now)
    if (!LivingWorldBodyLanguageOn || !_lwbActors || Utility.IsInMenuMode())
        return false
    endIf
    if (now >= _lwbScanDueAt)
        LwBodyScan()
        _lwbScanDueAt = now + LwBodyScanSeconds
    endIf
    bool weaponOut = LwPlayerArmed()
    bool weaponDrawnNow = weaponOut && !_lwbWeaponWas
    if (weaponDrawnNow && Utility.GetCurrentRealTime() - _lwErectEventAt < 3.0)
        weaponDrawnNow = false   ; the arousal animation, not a weapon (see LwSetErect)
    endIf
    _lwbWeaponWas = weaponOut
    MantellaConversation conv = ListenerScript.conversation
    bool talking = conv && conv.IsRunning()
    bool any = false
    int i = 0
    while (i < 4)
        Actor a = _lwbActors[i]
        if (a)
            any = true
            LwBodyStep(i, a, now, weaponDrawnNow, talking && conv.Participants.HasForm(a))
        endIf
        i += 1
    endWhile
    return any
endFunction

function LwBodyStep(int i, Actor a, float now, bool weaponDrawnNow, bool inTalk)
    float d = a.GetDistance(PlayerRef) / 71.0210
    float comfort = _lwbComfort[i]
    bool busy = LwBodyBusy(a)
    ; timers running out
    if (_lwbOffsetUntil[i] > 0.0 && now >= _lwbOffsetUntil[i])
        a.ClearKeepOffsetFromActor()
        _lwbOffsetUntil[i] = 0.0
    endIf
    if (_lwbArmsUntil[i] > 0.0 && now >= _lwbArmsUntil[i])
        Debug.SendAnimationEvent(a, "OffsetStop")
        _lwbArmsUntil[i] = 0.0
    endIf
    if (a.IsInCombat())
        LwBodyRelease(i)   ; combat AI is in charge
        return
    endIf

    ; approach: from beyond 5 m to within 3 m in a few seconds
    if (d > 5.0)
        _lwbLastFarAt[i] = now
    elseIf (d < 3.0 && _lwbLastFarAt[i] > 0.0 && now - _lwbLastFarAt[i] < 4.0 && now - _lwbLastApproachAt[i] > 60.0)
        _lwbLastApproachAt[i] = now
        _lwbLastFarAt[i] = 0.0
        LwBodyRecord(a, "approach", "|dist=" + d)
    endIf

    ; crowding, with hysteresis
    if (!_lwbInside[i] && d < comfort)
        _lwbInside[i] = true
        _lwbInsideSince[i] = now
        _lwbReported[i] = false
        _lwbMinDist[i] = d
        _lwbEntryX[i] = PlayerRef.GetPositionX()
        _lwbEntryY[i] = PlayerRef.GetPositionY()
    elseIf (_lwbInside[i])
        if (d < _lwbMinDist[i])
            _lwbMinDist[i] = d
        endIf
        if (d > comfort * 1.3)
            _lwbInside[i] = false
            if (_lwbReported[i])
                float dx = PlayerRef.GetPositionX() - _lwbEntryX[i]
                float dy = PlayerRef.GetPositionY() - _lwbEntryY[i]
                if (Math.sqrt(dx * dx + dy * dy) / 71.0210 >= 0.3)   ; the player moved away, not just the NPC
                    LwBodyRecord(a, "backed_off", "|dist=" + d)
                endIf
            endIf
            _lwbReported[i] = false
        else
            if (!_lwbReported[i] && now - _lwbInsideSince[i] >= 1.5)
                if (now - _lwbLastCrowdAt[i] < 180.0)
                    _lwbCrowdN[i] = _lwbCrowdN[i] + 1
                else
                    _lwbCrowdN[i] = 1
                endIf
                _lwbLastCrowdAt[i] = now
                _lwbReported[i] = true
                LwBodyRecord(a, "crowd", "|dist=" + _lwbMinDist[i] + "|dur=" + (now - _lwbInsideSince[i]) + "|n=" + _lwbCrowdN[i])
            endIf
            if (_lwbReported[i] && !busy)
                if (_lwbStep[i] && now - _lwbLastStepAt[i] >= 10.0 && LwBodyCanReact(i, now))
                    ; step back along the line from the player, never toward: offset in the player's frame
                    float ang = PlayerRef.GetHeadingAngle(a)
                    float r = comfort * 1.35 * 71.0210
                    a.KeepOffsetFromActor(PlayerRef, r * Math.sin(ang), r * Math.cos(ang), 0.0, 0.0, 0.0, ang + 180.0, 40.0, 20.0)
                    _lwbOffsetUntil[i] = now + 2.5
                    _lwbLastStepAt[i] = now
                    LwBodyReacted(i, now)
                endIf
                if (_lwbGuard[i] >= 0.6 && _lwbArmsUntil[i] == 0.0 && now - _lwbLastArmsAt[i] >= 20.0 && _lwbArmsIdle && LwBodyCanReact(i, now))
                    if (a.PlayIdle(_lwbArmsIdle))
                        _lwbArmsUntil[i] = now + 6.0
                        _lwbLastArmsAt[i] = now
                        LwBodyReacted(i, now)
                    endIf
                endIf
            endIf
        endIf
    endIf

    ; facing: the player's body heading (the headset's direction is not readable from Papyrus)
    bool facing = Math.abs(PlayerRef.GetHeadingAngle(a)) < 15.0
    if (d < 2.0 && facing)
        if (_lwbStareSince[i] == 0.0)
            _lwbStareSince[i] = now
        elseIf (now - _lwbStareSince[i] >= 5.0 && now - _lwbLastStareAt[i] >= 90.0)
            _lwbLastStareAt[i] = now
            LwBodyRecord(a, "stare", "|dist=" + d + "|dur=" + (now - _lwbStareSince[i]))
        endIf
    else
        _lwbStareSince[i] = 0.0
    endIf

    if (weaponDrawnNow && d < 6.0 && now - _lwbLastWeaponAt[i] >= 30.0)
        _lwbLastWeaponAt[i] = now
        LwBodyRecord(a, "weapon", "|dist=" + d)
    endIf

    if (LwBodyPeek(i, a, d, now, inTalk, busy))
        return   ; her eyes are down on the naked player for a moment
    endIf

    ; gaze: Mantella sets look-at between speakers in its conversations, so only outside them
    if (inTalk || busy)
        if (_lwbLookHeld[i] || _lwbGlanceUntil[i] > 0.0)
            a.ClearLookAt()
            _lwbLookHeld[i] = false
            _lwbGlanceUntil[i] = 0.0
        endIf
        if (_lwbHeadAwayUntil[i] > 0.0)
            a.SetHeadTracking(true)
            _lwbHeadAwayUntil[i] = 0.0
        endIf
        return
    endIf
    if (_lwbHeadAwayUntil[i] > 0.0 && now >= _lwbHeadAwayUntil[i])
        a.SetHeadTracking(true)
        _lwbHeadAwayUntil[i] = 0.0
    endIf
    if (_lwbGlanceUntil[i] > 0.0 && now >= _lwbGlanceUntil[i])
        a.ClearLookAt()
        _lwbGlanceUntil[i] = 0.0
    endIf
    if (d >= 4.0)
        if (_lwbLookHeld[i])
            a.ClearLookAt()
            _lwbLookHeld[i] = false
        endIf
        return
    endIf
    float gaze = _lwbGaze[i]
    if (gaze >= 0.6)
        if (!_lwbLookHeld[i])
            a.SetLookAt(PlayerRef)
            _lwbLookHeld[i] = true
        endIf
    else
        if (_lwbLookHeld[i])
            a.ClearLookAt()
            _lwbLookHeld[i] = false
        endIf
        if (gaze >= 0.35)
            if (_lwbGlanceUntil[i] == 0.0 && now >= _lwbNextGlanceAt[i])
                a.SetLookAt(PlayerRef)
                _lwbGlanceUntil[i] = now + 2.0
                _lwbNextGlanceAt[i] = now + 8.0
            endIf
        elseIf (facing && d < 3.0 && _lwbHeadAwayUntil[i] == 0.0 && now >= _lwbNextGlanceAt[i])
            a.SetHeadTracking(false)   ; looks away from the player's gaze for a moment
            _lwbHeadAwayUntil[i] = now + 3.0
            _lwbNextGlanceAt[i] = now + 9.0
        endIf
    endIf
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LIVINGWORLD PATCH: intimate scenes (OStim)                                                         ;
; OStim's own thread events say when a scene starts, changes and ends (OStim Standalone 7.5.1b,     ;
; skse/src/GameAPI/GameEvents.cpp: ostim_thread_start/_scenechanged/_end carry the thread id as the ;
; number; ostim_actor_orgasm comes from the actor; ostim_event carries spanks). Up to 4 scenes are  ;
; followed at once, with up to 3 people each, the player first when they are in it.                 ;
; While the player is in a scene with someone, their hands on that partner (HIGGS grabs) and their  ;
; hits on them are counted into the scene instead of being sent as grabs and hits: no reaction, no ;
; guard, no "grabbed" or "punched" line. Outside a scene, or on anyone not in the player's scene,   ;
; nothing changes. When a scene ends, one "scene" record is queued (MantellaExtension               ;
; livingworld/intimacy); while it runs, each request carries a snapshot (mantella_lw_scene).        ;
; All OStim calls go through LivingWorldOStim.psc. The server's start reply switches this           ;
; (mantella_lw_intimacy_on, MANTELLA_LW_INTIMACY).                                                   ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

bool property LivingWorldIntimacyOn = true auto hidden
float property LwSceneLineSeconds = 8.0 auto hidden   ; at most one scene line to a conversation this often

int[] _lwScThread          ; 4 slots: the OStim thread id, -1 when free
Actor[] _lwScA             ; 12: slot * 3 + 0..2, the player first when they are in it
string[] _lwScActs         ; OStim action types seen so far, comma-separated
string[] _lwScScene        ; the scene playing now
float[] _lwScStart
int[] _lwScTouch
int[] _lwScSlap
int[] _lwScClimax
bool[] _lwScForced
int[] _lwScGen             ; per slot: bumped each time a scene takes the slot, so only its newest watch loop runs
bool _lwScAny = false      ; any slot in use: keeps the grab and hit handlers free when no scene runs
float _lwScLineAt = -100.0

; Called from LivingWorldRegisterPerception on every load. OStim does not carry scenes across a load.
function LwRegisterIntimacy()
    _lwScThread = new int[4]
    _lwScGen = new int[4]
    _lwScA = new Actor[12]
    _lwScActs = new string[4]
    _lwScScene = new string[4]
    _lwScStart = new float[4]
    _lwScTouch = new int[4]
    _lwScSlap = new int[4]
    _lwScClimax = new int[4]
    _lwScForced = new bool[4]
    _lwScW = new Actor[32]
    _lwScWLos = new bool[32]
    _lwScWM = new float[32]
    int i = 0
    while (i < 4)
        _lwScThread[i] = -1
        i += 1
    endWhile
    _lwScAny = false
    _lwNoPo3 = false
    _lwScFallbackAt = -100.0
    RegisterForModEvent("ostim_thread_start", "OnLwOStimStart")
    RegisterForModEvent("ostim_thread_scenechanged", "OnLwOStimScene")
    RegisterForModEvent("ostim_thread_end", "OnLwOStimEnd")
    RegisterForModEvent("ostim_actor_orgasm", "OnLwOStimClimax")
    RegisterForModEvent("ostim_event", "OnLwOStimEvent")
    RegisterForModEvent("LivingWorld_SceneWatch", "OnLwSceneWatch")
    LwRegisterArousalAndEyes()
    LwRegisterConfrontAndDecency() ; LIVINGWORLD PATCH: caught in the act, public decency
endFunction

int function LwSceneSlot(int threadId)
    if (!_lwScAny || !_lwScThread)
        return -1
    endIf
    return _lwScThread.Find(threadId)
endFunction

; The slot of the scene the actor is in, or -1.
int function LwInScene(Actor a)
    if (!_lwScAny || !a)
        return -1
    endIf
    int k = _lwScA.Find(a)
    if (k < 0)
        return -1
    endIf
    int slot = k / 3
    if (_lwScThread[slot] < 0)
        return -1
    endIf
    return slot
endFunction

; True when the player and this person are in the same scene right now.
bool function LwSceneWithPlayer(Actor a)
    if (!_lwScAny || !a || a == PlayerRef)
        return false
    endIf
    int slot = LwInScene(a)
    return slot >= 0 && _lwScA[slot * 3] == PlayerRef
endFunction

; A HIGGS grab on the player's scene partner: counted into the scene. True when it was.
bool function LwSceneTouch(Actor target)
    if (!LwSceneWithPlayer(target))
        return false
    endIf
    int slot = LwInScene(target)
    _lwScTouch[slot] = _lwScTouch[slot] + 1
    return true
endFunction

; A hit on the player's scene partner: counted as a slap. True when it was.
bool function LwSceneSlap(Actor target)
    if (!LwSceneWithPlayer(target))
        return false
    endIf
    int slot = LwInScene(target)
    _lwScSlap[slot] = _lwScSlap[slot] + 1
    return true
endFunction

; The conversation line for a slap during a scene (MantellaTargetListenerScript.OnHit), or "" this soon after another.
string function LwSceneHitLine(Actor target)
    float now = Utility.GetCurrentRealTime()
    if (now - _lwScLineAt < LwSceneLineSeconds)
        return ""
    endIf
    _lwScLineAt = now
    return PlayerRef.GetDisplayName() + " slaps " + target.GetDisplayName() + " as part of their intimate scene, not as an attack."
endFunction

function LwSceneSay(int slot, string text, bool always)
    if (_lwScA[slot * 3] != PlayerRef)
        if (!ListenerScript.conversation.IsRunning() || !_lwScA[slot * 3 + 1] || _lwScA[slot * 3 + 1].GetDistance(PlayerRef) / 71.0210 > LivingWorldWitnessScanMeters)
            return   ; other people's scene: only a conversation close enough to see it hears of it
        endIf
    endIf
    float now = Utility.GetCurrentRealTime()
    if (!always && now - _lwScLineAt < LwSceneLineSeconds)
        return
    endIf
    _lwScLineAt = now
    ListenerScript.AddIngameEventToConversation(text)
endFunction

string function LwSceneNames(int slot)
    string names = _lwScA[slot * 3].GetDisplayName()
    if (_lwScA[slot * 3 + 2])
        names += ", " + _lwScA[slot * 3 + 1].GetDisplayName() + " and " + _lwScA[slot * 3 + 2].GetDisplayName()
    elseIf (_lwScA[slot * 3 + 1])
        names += " and " + _lwScA[slot * 3 + 1].GetDisplayName()
    endIf
    return names
endFunction

; Starts following a thread. Returns its slot, or -1 (no room, fewer than two people, or a child).
int function LwSceneBegin(int threadId)
    int slot = _lwScThread.Find(-1)
    if (slot < 0)
        return -1
    endIf
    ; Claim the slot before any call out of this script. OStim sends thread_start and the first
    ; scenechanged together; the call to LivingWorldOStim.Actors lets the other handler run, and
    ; before this it also found no slot for the thread and began the same scene a second time
    ; (two witness loops for one scene, seen in the 2026-11-10 log).
    _lwScThread[slot] = threadId
    _lwScAny = true   ; LwSceneSlot looks at nothing while this is false
    _lwScA[slot * 3] = None
    _lwScA[slot * 3 + 1] = None
    _lwScA[slot * 3 + 2] = None
    Actor[] actors = LivingWorldOStim.Actors(threadId)
    if (!actors || actors.Length < 2)
        _lwScThread[slot] = -1
        _lwScAny = _lwScThread[0] >= 0 || _lwScThread[1] >= 0 || _lwScThread[2] >= 0 || _lwScThread[3] >= 0
        return -1   ; one person alone is not a scene with anyone
    endIf
    int i = 0
    while (i < actors.Length)
        if (actors[i] && actors[i].IsChild())
            _lwScThread[slot] = -1
            _lwScAny = _lwScThread[0] >= 0 || _lwScThread[1] >= 0 || _lwScThread[2] >= 0 || _lwScThread[3] >= 0
            return -1   ; children are left out of every Living World system
        endIf
        i += 1
    endWhile
    _lwScA[slot * 3] = None
    _lwScA[slot * 3 + 1] = None
    _lwScA[slot * 3 + 2] = None
    int n = 0
    if (actors.Find(PlayerRef) >= 0)
        _lwScA[slot * 3] = PlayerRef
        n = 1
    endIf
    i = 0
    while (i < actors.Length && n < 3)
        if (actors[i] && actors[i] != PlayerRef)
            _lwScA[slot * 3 + n] = actors[i]
            n += 1
        endIf
        i += 1
    endWhile
    _lwScActs[slot] = ""
    _lwScScene[slot] = ""
    _lwScStart[slot] = Utility.GetCurrentRealTime()
    _lwScTouch[slot] = 0
    _lwScSlap[slot] = 0
    _lwScClimax[slot] = 0
    _lwScForced[slot] = false
    if (_lwScConfronted)
        _lwScConfronted[slot] = false
    endIf
    LwSceneClearWitnesses(slot)
    _lwScAny = true
    ; a hand already holding a partner when the scene starts: that hold belongs to the scene now
    if (_lwLeftHeld && LwInScene(_lwLeftHeld) == slot && _lwScA[slot * 3] == PlayerRef)
        _lwLeftHeld = None
    endIf
    if (_lwRightHeld && LwInScene(_lwRightHeld) == slot && _lwScA[slot * 3] == PlayerRef)
        _lwRightHeld = None
    endIf
    LwBodyLetGo(slot)
    _lwScGen[slot] = _lwScGen[slot] + 1
    SendModEvent("LivingWorld_SceneWatch", _lwScGen[slot] as string, threadId as float)   ; who sees it, all through the scene
    return slot
endFunction

; Body language lets go of everyone in the scene (no stepping back from a partner, no folded arms).
function LwBodyLetGo(int slot)
    if (!_lwbActors)
        return
    endIf
    int k = 0
    while (k < 3)
        Actor a = _lwScA[slot * 3 + k]
        if (a)
            int i = _lwbActors.Find(a)
            if (i >= 0)
                LwBodyRelease(i)
            endIf
        endIf
        k += 1
    endWhile
endFunction

; Adds the scene's action types to what the slot has seen; returns the new ones, comma-separated.
string function LwSceneNoteActs(int slot, string sceneId)
    if (sceneId == "")
        return ""
    endIf
    _lwScScene[slot] = sceneId
    if (LivingWorldOStim.Aggressive(sceneId))
        _lwScForced[slot] = true
    endIf
    string[] types = LivingWorldOStim.ActionTypes(sceneId)
    string added = ""
    int i = 0
    while (i < types.Length)
        string t = types[i]
        if (t != "" && StringUtil.Find("," + _lwScActs[slot] + ",", "," + t + ",") < 0)
            if (_lwScActs[slot] == "")
                _lwScActs[slot] = t
            else
                _lwScActs[slot] = _lwScActs[slot] + "," + t
            endIf
            if (added == "")
                added = t
            else
                added += ", " + t
            endIf
        endIf
        i += 1
    endWhile
    return added
endFunction

Event OnLwOStimStart(string eventName, string strArg, float numArg, Form sender)
    if (!LivingWorldIntimacyOn || !LivingWorldPerceptionOn || LwSceneSlot(numArg as int) >= 0)
        return
    endIf
    int slot = LwSceneBegin(numArg as int)
    if (slot >= 0)
        LwSceneNoteActs(slot, LivingWorldOStim.Scene(numArg as int))
        LwSceneSay(slot, LwSceneNames(slot) + " begin an intimate scene together.", true)
        Debug.Trace("Mantella Living World: following OStim thread " + (numArg as int) + " (" + LwSceneNames(slot) + ")")
    endIf
EndEvent

Event OnLwOStimScene(string eventName, string sceneId, float numArg, Form sender)
    if (!LivingWorldIntimacyOn || !LivingWorldPerceptionOn)
        return
    endIf
    int threadId = numArg as int
    int slot = LwSceneSlot(threadId)
    if (slot < 0)
        slot = LwSceneBegin(threadId)   ; started before this load, or the start event was missed
        if (slot < 0)
            return
        endIf
    endIf
    string added = LwSceneNoteActs(slot, sceneId)
    if (added != "")
        LwSceneSay(slot, "In their intimate scene, " + LwSceneNames(slot) + " are now: " + added + ".", false)
    endIf
EndEvent

Event OnLwOStimClimax(string eventName, string sceneId, float numArg, Form sender)
    int slot = LwSceneSlot(numArg as int)
    if (slot >= 0)
        _lwScClimax[slot] = _lwScClimax[slot] + 1
        LwSceneClimaxRecord(slot, sender as Actor)
    endIf
EndEvent

Event OnLwOStimEvent(int threadId, string eventType, Form eventActor, Form eventTarget, Form eventPerformer)
    int slot = LwSceneSlot(threadId)
    if (slot >= 0 && LivingWorldOStim.IsSpank(eventType))
        _lwScSlap[slot] = _lwScSlap[slot] + 1
    endIf
EndEvent

Event OnLwOStimEnd(string eventName, string strArg, float numArg, Form sender)
    int slot = LwSceneSlot(numArg as int)
    if (slot >= 0)
        LwSceneFlush(slot)
    endIf
EndEvent

; The scene's people, acts and counts as record fields (shared by the end record and the snapshot).
string function LwSceneFields(int slot)
    string rec = "|thread=" + _lwScThread[slot] + "|scene=" + _lwScScene[slot] + "|actor=" + LivingWorldActorField(_lwScA[slot * 3]) + "|target=" + LivingWorldActorField(_lwScA[slot * 3 + 1])
    if (_lwScA[slot * 3 + 2])
        rec += "|party=" + LivingWorldActorField(_lwScA[slot * 3 + 2])
    endIf
    string forced = "0"
    if (_lwScForced[slot])
        forced = "1"
    endIf
    rec += "|acts=" + _lwScActs[slot] + "|touch=" + _lwScTouch[slot] + "|slap=" + _lwScSlap[slot] + "|forced=" + forced + "|climax=" + _lwScClimax[slot] + "|dur=" + (Utility.GetCurrentRealTime() - _lwScStart[slot])
    if (_lwScA[slot * 3] == PlayerRef)
        float size = LwPlayerGenitalScale()
        if (size > 0.0)
            rec += "|psize=" + size
        endIf
    endIf
    return rec
endFunction

; The New Gentleman sizes a man by scaling this one bone (size class x race multiplier, TNG 4.2.7
; Core::SetActorSize). Reading the bone needs no TNG script. -1 when the player is not a man or has no such bone.
float function LwPlayerGenitalScale()
    if (PlayerRef.GetActorBase().GetSex() != 0 || !NetImmerse.HasNode(PlayerRef, "NPC GenitalsBase [GenBase]", false))
        return -1.0
    endIf
    return NetImmerse.GetNodeScale(PlayerRef, "NPC GenitalsBase [GenBase]", false)
endFunction

; The scene ended: queue one record and free the slot.
function LwSceneFlush(int slot)
    string names = LwSceneNames(slot)
    string rec = LivingWorldHeader("scene") + "|via=end" + LwSceneFields(slot)
    LwSceneSample(slot)
    rec += LwSceneWitnessFields(slot)   ; everyone who saw any part of it, not only who is there at the end
    LivingWorldQueue(rec)
    LwSceneSay(slot, "The intimate scene between " + names + " has ended.", true)
    _lwScThread[slot] = -1
    _lwScA[slot * 3] = None
    _lwScA[slot * 3 + 1] = None
    _lwScA[slot * 3 + 2] = None
    _lwScAny = _lwScThread[0] >= 0 || _lwScThread[1] >= 0 || _lwScThread[2] >= 0 || _lwScThread[3] >= 0
endFunction

; MantellaConversation.BuildContext sends this with every request: one record per scene running near the player.
string[] function LwSceneSnapshot()
    string[] result = Utility.CreateStringArray(0)
    if (!_lwScAny || !LivingWorldIntimacyOn)
        return result
    endIf
    int slot = 0
    while (slot < 4)
        Actor a = _lwScA[slot * 3]
        if (_lwScThread[slot] >= 0 && a && a.GetDistance(PlayerRef) / 71.0210 <= LivingWorldWitnessScanMeters)
            result = Utility.ResizeStringArray(result, result.Length + 1)
            result[result.Length - 1] = LivingWorldHeader("scene") + "|via=now" + LwSceneFields(slot) + LivingWorldWitnesses(a, _lwScA[slot * 3 + 1])
        endIf
        slot += 1
    endWhile
    return result
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LIVINGWORLD PATCH: who sees an intimate scene, climaxes, arousal, covered eyes                     ;
; Witnesses: every few seconds while a scene runs (the player's own or one between NPCs), the adult ;
; people near it are looked at and the best view each had is kept (up to 8 a scene). The end record ;
; lists all of them, so someone who walked in and left again still saw it. Children never count.    ;
; Climax: OStim's ostim_actor_orgasm (the sender is who climaxed) queues a "climax" record with the ;
; scene's current OStim action types, so the server can tell where it landed (OCum shows it).      ;
; Arousal: rapid taps of LwArousalKey raise the player's erection (The New Gentleman's own          ;
; SOSBend animation events, TNG 4.2.7 TNG_MCM.RiseAndDrop); one lone tap lets it go down; after     ;
; LwArousalHoldSeconds without a tap it goes down by itself. Crossing "visibly aroused" queues an    ;
; "arousal" record, with witnesses when the player has nothing on the body.                         ;
; Covered eyes: the LWCoverEyes plugin's power darkens the screen and sends                         ;
; LivingWorld_EyesCovered (1 covered, 0 not); an "eyes" record tells the NPCs around.               ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

float property LwSceneWatchSeconds = 4.0 auto hidden
; Without Papyrus Extender's FindAllReferencesWithKeyword the only other way to find people is Mantella's
; nearby-actor quest (a quest start and stop each time). Doing that every few seconds through a whole scene,
; on top of OStim and OCum, piled up Papyrus stacks until the game froze for 30 s (2026-11-10, twice).
; So that scan runs at most this often while a scene is watched.
float property LwSceneFallbackSeconds = 20.0 auto hidden
bool _lwNoPo3 = false          ; PeopleNear came back None once: the Extender call is not there, stop asking
float _lwScFallbackAt = -100.0
Actor[] _lwScW        ; 4 slots x 8 witnesses
bool[] _lwScWLos      ; whether they had a line of sight (the best they had)
float[] _lwScWM       ; how far they were then (m)

function LwSceneClearWitnesses(int slot)
    if (!_lwScW)
        _lwScW = new Actor[32]
        _lwScWLos = new bool[32]
        _lwScWM = new float[32]
    endIf
    int k = 0
    while (k < 8)
        _lwScW[slot * 8 + k] = None
        _lwScWLos[slot * 8 + k] = false
        _lwScWM[slot * 8 + k] = 0.0
        k += 1
    endWhile
endFunction

Event OnLwSceneWatch(string eventName, string strArg, float numArg, Form sender)
    int threadId = numArg as int
    int gen = strArg as int
    int slot = LwSceneSlot(threadId)
    ; one loop per scene: a loop whose scene ended (or was begun again) stops
    while (slot >= 0 && _lwScGen && _lwScGen[slot] == gen)
        LwSceneSample(slot, false)
        Utility.Wait(LwSceneWatchSeconds)
        slot = LwSceneSlot(threadId)
    endWhile
EndEvent

; Looks at the adult people around the scene now and keeps the best view each had.
; once: the scene's start, climax or end (always looks). Otherwise a watch tick, which skips the slow
; fallback scan unless LwSceneFallbackSeconds have passed.
function LwSceneSample(int slot, bool once = true)
    Actor doer = _lwScA[slot * 3]
    Actor center = _lwScA[slot * 3 + 1]
    if (!doer || !center || !center.Is3DLoaded())
        return
    endIf
    Actor[] near
    if (!_lwNoPo3)
        near = LivingWorldPO3.PeopleNear(center, LivingWorldWitnessScanMeters * 71.0210, _lwActorTypeNPC)
        if (!near)
            _lwNoPo3 = true   ; the scene's own people are always found, so None means the call is missing
        endIf
    endIf
    if (!near || near.Length == 0)
        float now = Utility.GetCurrentRealTime()
        if (!once && now - _lwScFallbackAt < LwSceneFallbackSeconds)
            return
        endIf
        _lwScFallbackAt = now
        near = ListenerScript.ScanNearbyActors()   ; no Papyrus Extender: Mantella's five nearest to the player
    endIf
    int i = 0
    while (i < near.Length)
        Actor w = near[i]
        if (w && w != PlayerRef && LivingWorldIsPerson(w) && LwInScene(w) < 0)
            float meters = w.GetDistance(center) / 71.0210
            if (meters <= LivingWorldWitnessScanMeters)
                bool sees = w.HasLOS(center) || w.HasLOS(doer)
                LwSceneKeepWitness(slot, w, meters, sees)
                if (sees && meters <= LwConfrontMeters && LwConfrontOn)
                    LwMaybeConfront(slot, w)   ; their own partner in it: they walk in and speak up
                endIf
            endIf
        endIf
        i += 1
    endWhile
endFunction

function LwSceneKeepWitness(int slot, Actor w, float meters, bool los)
    int base = slot * 8
    int k = 0
    int free = -1
    while (k < 8)
        Actor known = _lwScW[base + k]
        if (known == w)
            if ((los && !_lwScWLos[base + k]) || (los == _lwScWLos[base + k] && meters < _lwScWM[base + k]))
                _lwScWLos[base + k] = los
                _lwScWM[base + k] = meters
            endIf
            return
        elseIf (!known && free < 0)
            free = base + k
        endIf
        k += 1
    endWhile
    if (free >= 0)
        _lwScW[free] = w
        _lwScWLos[free] = los
        _lwScWM[free] = meters
    endIf
endFunction

; The kept witnesses as "|w=" fields (same layout as LivingWorldWitnesses).
string function LwSceneWitnessFields(int slot)
    Actor doer = _lwScA[slot * 3]
    Actor target = _lwScA[slot * 3 + 1]
    string result = ""
    int k = 0
    while (k < 8)
        Actor w = _lwScW[slot * 8 + k]
        if (w)
            string los = "0"
            if (_lwScWLos[slot * 8 + k])
                los = "1"
            endIf
            string rankTarget = ""
            if (target)
                rankTarget = w.GetRelationshipRank(target) as string
            endIf
            result += "|w=" + _lwScWM[slot * 8 + k] + "^" + los + "^" + w.GetRelationshipRank(doer) + "^" + rankTarget + "^" + LivingWorldActorField(w)
        endIf
        k += 1
    endWhile
    return result
endFunction

; Someone in a followed scene climaxed. One record, with what the scene is doing right now.
function LwSceneClimaxRecord(int slot, Actor who)
    if (!who || !LivingWorldIntimacyOn || LwInScene(who) != slot)
        return
    endIf
    Actor onto = None
    int k = 0
    while (k < 3 && !onto)
        Actor a = _lwScA[slot * 3 + k]
        if (a && a != who)
            onto = a
        endIf
        k += 1
    endWhile
    if (!onto)
        return
    endIf
    string[] types = LivingWorldOStim.ActionTypes(_lwScScene[slot])
    string acts = ""
    int i = 0
    while (i < types.Length)
        if (types[i] != "")
            if (acts != "")
                acts += ","
            endIf
            acts += types[i]
        endIf
        i += 1
    endWhile
    string sex = "m"
    if (who.GetActorBase().GetSex() == 1)
        sex = "f"
    endIf
    LwSceneSample(slot)
    LivingWorldQueue(LivingWorldHeader("climax") + "|thread=" + _lwScThread[slot] + "|scene=" + _lwScScene[slot] + "|actor=" + LivingWorldActorField(who) + "|target=" + LivingWorldActorField(onto) + "|acts=" + acts + "|sex=" + sex + LwSceneWitnessFields(slot))
    LwSceneSay(slot, who.GetDisplayName() + " reaches climax with " + onto.GetDisplayName() + ".", true)
endFunction

; ---- arousal (The New Gentleman) ----

int property LwArousalKey = 76 auto hidden            ; DirectX scan code; 76 = NumPad 5. The server can change it.
float property LwArousalTapGap = 0.6 auto hidden       ; taps closer together than this are "rapid"
float property LwArousalHoldSeconds = 120.0 auto hidden
int property LwArousalVisibleLevel = -4 auto hidden   ; TNG bend from -10 (soft) to 9: from here on it shows
int _lwErect = -10
float _lwErectEventAt = -100.0   ; real time of the last arousal animation event
float _lwTapAt = -100.0
int _lwArousalWatch = 0
bool _lwErectShown = false
bool _lwEyesCovered = false
int _lwArousalKeyBound = 0

function LwRegisterArousalAndEyes()
    RegisterForModEvent("LivingWorld_ArousalLone", "OnLwArousalLone")
    RegisterForModEvent("LivingWorld_ArousalFade", "OnLwArousalFade")
    RegisterForModEvent("LivingWorld_EyesCovered", "OnLwEyesCovered")
    RegisterForModEvent("LivingWorld_ArousalStep", "OnLwArousalStep") ; the Arousal power (Spell Wheel friendly)
    _lwArousalKeyBound = 0   ; register the key again on every load: a saved "already bound" must not skip it
    LwSetArousalKey(LwArousalKey)
    _lwErect = -10        ; animation graphs start over on a load
    _lwErectShown = false
endFunction

; The start reply's mantella_lw_arousal_key (MANTELLA_LW_AROUSAL_KEY); 0 switches the key off.
function LwSetArousalKey(int keyCode)
    if (_lwArousalKeyBound > 0 && _lwArousalKeyBound != keyCode)
        UnregisterForKey(_lwArousalKeyBound)
        _lwArousalKeyBound = 0
    endIf
    LwArousalKey = keyCode
    if (keyCode > 0)
        RegisterForKey(keyCode)   ; registering again is harmless
        _lwArousalKeyBound = keyCode
    endIf
endFunction

; The "Arousal" lesser power (LWCoverEyes.esp), for VR where a keyboard key is awkward. Each cast is one
; step up: visible (-4), then 2, then fully (9); a cast when already fully up lets it go down.
Event OnLwArousalStep(string eventName, string strArg, float numArg, Form sender)
    if (!LivingWorldIntimacyOn || PlayerRef.GetActorBase().GetSex() != 0)
        return
    endIf
    if (_lwErect >= 9)
        LwSetErect(-10)
        return
    elseIf (_lwErect < LwArousalVisibleLevel)
        LwSetErect(LwArousalVisibleLevel)
    elseIf (_lwErect < 2)
        LwSetErect(2)
    else
        LwSetErect(9)
    endIf
    _lwArousalWatch += 1
    SendModEvent("LivingWorld_ArousalFade", "", _lwArousalWatch as float)
EndEvent

function LwArousalTap()
    Debug.Trace("[LivingWorld] arousal key: intimacy=" + LivingWorldIntimacyOn + " sex=" + PlayerRef.GetActorBase().GetSex() + " level=" + _lwErect)
    if (!LivingWorldIntimacyOn || PlayerRef.GetActorBase().GetSex() != 0)
        return   ; The New Gentleman's erection is for men
    endIf
    float now = Utility.GetCurrentRealTime()
    bool rapid = now - _lwTapAt <= LwArousalTapGap
    _lwTapAt = now
    if (rapid)
        LwSetErect(_lwErect + 3)
    elseIf (_lwErect > -10)
        SendModEvent("LivingWorld_ArousalLone", "", now)   ; a lone tap lets it go down, unless more follow at once
    endIf
    _lwArousalWatch += 1
    SendModEvent("LivingWorld_ArousalFade", "", _lwArousalWatch as float)
endFunction

Event OnLwArousalLone(string eventName, string strArg, float tapAt, Form sender)
    Utility.Wait(LwArousalTapGap + 0.1)
    if (_lwTapAt == tapAt)
        LwSetErect(-10)
    endIf
EndEvent

Event OnLwArousalFade(string eventName, string strArg, float token, Form sender)
    Utility.Wait(LwArousalHoldSeconds)
    while (token == _lwArousalWatch && _lwErect > -10)
        if (_lwScAny && LwInScene(PlayerRef) >= 0)
            return   ; OStim drives it during a scene
        endIf
        LwSetErect(_lwErect - 2)
        Utility.Wait(3.0)
    endWhile
EndEvent

function LwSetErect(int level)
    if (level > 9)
        level = 9
    endIf
    bool wasDrawn = PlayerRef.IsWeaponDrawn()
    _lwErectEventAt = Utility.GetCurrentRealTime()
    if (level <= -10)
        level = -10
        Debug.SendAnimationEvent(PlayerRef, "SOSFlaccid")
    else
        Debug.SendAnimationEvent(PlayerRef, "SOSBend" + level)
    endIf
    _lwErect = level
    ; TNG's SOSBend/SOSFlaccid go through the player's behavior graph, and on the VR body that can flip
    ; the weapon-drawn state (guards and NPCs then react as if a weapon came out). Put it back.
    if (!wasDrawn)
        Utility.Wait(0.25)
        if (PlayerRef.IsWeaponDrawn())
            PlayerRef.SheatheWeapon()
            _lwErectEventAt = Utility.GetCurrentRealTime()
        endIf
    endIf
    bool shown = level >= LwArousalVisibleLevel
    if (shown != _lwErectShown)
        _lwErectShown = shown
        LwArousalRecord(shown)
    endIf
endFunction

function LwArousalRecord(bool erect)
    string cover = LivingWorldCover(PlayerRef)
    string via = "soft"
    if (erect)
        via = "erect"
    endIf
    string rec = LivingWorldHeader("arousal") + "|via=" + via + "|actor=" + LivingWorldActorField(PlayerRef) + "|cover=" + cover + "|level=" + _lwErect
    float size = LwPlayerGenitalScale()
    if (size > 0.0)
        rec += "|psize=" + size
    endIf
    bool inScene = _lwScAny && LwInScene(PlayerRef) >= 0
    if (cover == "none" && !inScene)
        rec += LivingWorldWitnesses(PlayerRef, None)
    endIf
    LivingWorldQueue(rec)
    if (erect && cover == "none" && !inScene && ListenerScript.conversation.IsRunning())
        ListenerScript.AddIngameEventToConversation(PlayerRef.GetDisplayName() + " is naked and visibly aroused.")
    endIf
endFunction

; ---- covered eyes (LWCoverEyes plugin) ----

Event OnLwEyesCovered(string eventName, string strArg, float covered, Form sender)
    bool now = covered > 0.5
    if (now == _lwEyesCovered)
        return
    endIf
    _lwEyesCovered = now
    string via = "uncovered"
    string line = PlayerRef.GetDisplayName() + " uncovers their eyes and can see again."
    if (now)
        via = "covered"
        line = PlayerRef.GetDisplayName() + " covers their eyes and cannot see anything, but can still hear everything."
    endIf
    if (LivingWorldPerceptionOn)
        LivingWorldQueue(LivingWorldHeader("eyes") + "|via=" + via + "|actor=" + LivingWorldActorField(PlayerRef) + LivingWorldWitnesses(PlayerRef, None))
    endIf
    if (ListenerScript.conversation.IsRunning())
        ListenerScript.AddIngameEventToConversation(line)
    endIf
EndEvent

bool function LwEyesCovered()
    return _lwEyesCovered
endFunction

; ---- LIVINGWORLD PATCH: fog (names unknown until told; livingworld/fog on the server) ----
; Kept in the save, so an older save brings back the names the player knew then. Until the server first
; says (with a conversation start), strangers are hidden: on a new game the player knows nobody. The first
; conversation brings the server's list (everyone already met) or switches the fog off (MANTELLA_LW_FOG=0).
bool LivingWorldFogSynced = false
bool LivingWorldFogOn = false
string[] LivingWorldFogKnown

bool function LivingWorldFogActive()
    return LivingWorldFogOn || !LivingWorldFogSynced
endFunction

; The start reply: fog on or off, and every real name the player knows
function LivingWorldFogSet(bool fogOn, string[] known, MantellaConversation conv)
    LivingWorldFogOn = fogOn
    LivingWorldFogKnown = known
    LivingWorldFogSynced = true
    LivingWorldFogSweep(conv)
endFunction

; An NPC line: names the player just learned
function LivingWorldFogReveal(string[] names, MantellaConversation conv)
    if (!names || names.Length == 0)
        return
    endIf
    if (!LivingWorldFogKnown)
        LivingWorldFogKnown = Utility.CreateStringArray(0)
    endIf
    int i = 0
    while (i < names.Length)
        if (names[i] != "" && LivingWorldFogKnown.Find(names[i]) < 0)
            LivingWorldFogKnown = Utility.ResizeStringArray(LivingWorldFogKnown, LivingWorldFogKnown.Length + 1)
            LivingWorldFogKnown[LivingWorldFogKnown.Length - 1] = names[i]
        endIf
        i += 1
    endWhile
    LivingWorldFogSweep(conv)
endFunction

; The conversation's people and the ones nearby, shown by name or as strangers
function LivingWorldFogSweep(MantellaConversation conv)
    if (!LivingWorldFogSynced || !conv)
        return
    endIf
    FormList participants = conv.Participants
    int p = 0
    while (p < participants.GetSize())
        LivingWorldFog.Apply(participants.GetAt(p) as Actor, LivingWorldFogKnown, LivingWorldFogOn)
        p += 1
    endWhile
    Actor[] nearby = conv.GetCachedNearbyActors()
    int n = 0
    while (nearby && n < nearby.Length)
        if (nearby[n])
            LivingWorldFog.Apply(nearby[n], LivingWorldFogKnown, LivingWorldFogOn)
        endIf
        n += 1
    endWhile
endFunction

; ---- LIVINGWORLD PATCH: guard names (livingworld/guard/names.py on the server) ----
; Generic guards ("Whiterun Guard") shown by the personal name the server gave them, once the player has
; learned it. Keyed by the guard's reference form ID. Kept in the save, like the names SetDisplayName gave,
; so an older save brings back what the player knew then. The real name (LivingWorldFog.RealName) still goes
; to the server, so who the guard is does not change. A name of "" puts the shared name back.
bool LivingWorldGuardNamesOff = false
int[] LivingWorldGuardNameIds
string[] LivingWorldGuardNameNames

; The start reply: names on, or off (MANTELLA_LW_GUARD_NAMES=0: every renamed guard gets the shared name back)
function LivingWorldGuardNamesOn(bool namesOn, MantellaConversation conv)
    if (namesOn)
        LivingWorldGuardNamesOff = false
        return
    endIf
    if (LivingWorldGuardNamesOff)
        return
    endIf
    LivingWorldGuardNamesOff = true
    int i = 0
    while (LivingWorldGuardNameIds && i < LivingWorldGuardNameIds.Length)
        LivingWorldGuardNameNames[i] = ""
        i += 1
    endWhile
    LivingWorldGuardNamesSweep(conv)
endFunction

; Guards to show by name from now on
function LivingWorldGuardNamesAdd(int[] ids, string[] names, MantellaConversation conv)
    if (!ids || !names || ids.Length == 0)
        return
    endIf
    if (!LivingWorldGuardNameIds)
        LivingWorldGuardNameIds = Utility.CreateIntArray(0)
        LivingWorldGuardNameNames = Utility.CreateStringArray(0)
    endIf
    int i = 0
    while (i < ids.Length && i < names.Length)
        int at = LivingWorldGuardNameIds.Find(ids[i])
        if (at < 0)
            at = LivingWorldGuardNameIds.Length
            LivingWorldGuardNameIds = Utility.ResizeIntArray(LivingWorldGuardNameIds, at + 1)
            LivingWorldGuardNameNames = Utility.ResizeStringArray(LivingWorldGuardNameNames, at + 1)
            LivingWorldGuardNameIds[at] = ids[i]
        endIf
        LivingWorldGuardNameNames[at] = names[i]
        i += 1
    endWhile
    LivingWorldGuardNamesSweep(conv)
endFunction

function LivingWorldGuardNamesSweep(MantellaConversation conv)
    if (!conv || !LivingWorldGuardNameIds)
        return
    endIf
    FormList participants = conv.Participants
    int p = 0
    while (p < participants.GetSize())
        LivingWorldGuardNameApply(participants.GetAt(p) as Actor)
        p += 1
    endWhile
    Actor[] nearby = conv.GetCachedNearbyActors()
    int n = 0
    while (nearby && n < nearby.Length)
        LivingWorldGuardNameApply(nearby[n])
        n += 1
    endWhile
endFunction

; Show this guard by their own name (or put the shared name back)
function LivingWorldGuardNameApply(Actor a)
    if (!a || !LivingWorldGuardNameIds || LivingWorldGuardNameIds.Length == 0)
        return
    endIf
    int at = LivingWorldGuardNameIds.Find(a.GetFormID())
    if (at < 0)
        return
    endIf
    string name = LivingWorldGuardNameNames[at]
    string shown = a.GetDisplayName()
    if (name == "" || LivingWorldGuardNamesOff)
        string shared = LivingWorldFog.GuardSharedName(a)
        if (shared != "" && shown != shared)
            a.SetDisplayName(shared)
        endIf
    elseIf (shown != name)
        a.SetDisplayName(name)
    endIf
endFunction

; An NPC line: places the NPC told the player about get their map marker (not marked as visited)
function LivingWorldFogMarkers(int[] ids, string[] plugins, string[] names)
    int i = 0
    while (ids && i < ids.Length)
        string plugin = "Skyrim.esm"
        if (plugins && i < plugins.Length && plugins[i] != "")
            plugin = plugins[i]
        endIf
        ObjectReference marker = Game.GetFormFromFile(ids[i], plugin) as ObjectReference
        if (marker)
            marker.AddToMap(false)
            if (names && i < names.Length)
                Debug.Notification(names[i] + " added to your map")
            endIf
        endIf
        i += 1
    endWhile
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LIVINGWORLD PATCH: caught in the act, public decency, wandering eyes                              ;
; Caught: while a scene is watched (LwSceneSample), a witness with a clear view of their own partner ;
; in it, from close by, walks in on it and speaks up. Partners are vanilla lovers (rank 4) or a      ;
; couple from the server's list (mantella_lw_couples, "A|B" real names, MantellaExtension           ;
; intimacy/confront.py). They join a running conversation, or one starts with them, the scene's      ;
; people and the player (only when the player is close enough to hear it). Once per scene.           ;
; Decency: the player has had nothing on the body slot for a while, outside water, a scene or their  ;
; own house, and a guard close by can see them: the guard comes over (react record via=decency,     ;
; guard/decency.py says what they do: a warning, then a fine).                                       ;
; Wandering eyes: see LwBodyPeek (body language). A woman's glance down at the naked player.         ;
; The server's start reply switches each (mantella_lw_confront_on / _decency_on / _peek_on).        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

bool property LwConfrontOn = true auto hidden
bool property LwDecencyOn = true auto hidden
bool property LwPeekOn = true auto hidden
string[] property LwCouples auto hidden
float property LwConfrontMeters = 10.0 auto hidden      ; a partner further than this has not really walked in on it
float property LwConfrontCooldown = 120.0 auto hidden   ; seconds between confrontations, any scene
; (set again on every load in LwRegisterConfrontAndDecency: a save keeps the values it was first given)
float property LwDecencyGraceSeconds = 5.0 auto hidden  ; naked this long before a guard minds (changing clothes is fine)
float property LwDecencyCooldown = 120.0 auto hidden    ; seconds between guards coming over about it
float property LwDecencyScanSeconds = 1.5 auto hidden   ; how often to look for a guard while naked (every 2 s regular check)
float property LwDecencyGuardMeters = 35.0 auto hidden
float property LwPeekMeters = 6.0 auto hidden

bool[] _lwScConfronted      ; per scene slot: someone already walked in on it
float _lwConfrontAt = -1000.0
Actor _lwConfrontWho
Actor _lwConfrontPartner
int _lwConfrontSlot = -1
float _lwNakedSince = 0.0   ; real time the player's body slot went empty (0: covered)
float _lwSwamAt = -1000.0
float _lwDecencyAt = -1000.0
float _lwDecencyScanAt = -1000.0
Actor _lwDecencyGuard
Keyword _lwPlayerHouseKw
ObjectReference _lwPeekMarker

; Called from LwRegisterIntimacy on every load.
function LwRegisterConfrontAndDecency()
    _lwScConfronted = new bool[4]
    _lwConfrontWho = None
    _lwConfrontPartner = None
    _lwDecencyGuard = None
    _lwNakedSince = 0.0
    _lwPlayerHouseKw = Keyword.GetKeyword("LocTypePlayerHouse")
    LwDecencyGraceSeconds = 5.0      ; build22: guards notice sooner and from further away (build21: 20 s, 8 s, 20 m, 180 s)
    LwDecencyScanSeconds = 1.5
    LwDecencyGuardMeters = 35.0
    LwDecencyCooldown = 120.0
    RegisterForModEvent("LivingWorld_Confront", "OnLwConfront")
    RegisterForModEvent("LivingWorld_Decency", "OnLwDecency")
    RegisterForModEvent("LivingWorld_Surrender", "OnLwSurrender")   ; LIVINGWORLD PATCH: the LWSaloniaSurrender plugin
    RegisterForModEvent("LivingWorld_SurrenderReplace", "OnLwSurrenderReplace")   ; ...and its persistent copy of her
    RegisterForModEvent("LivingWorld_SideJob", "OnLwSideJob")   ; LIVINGWORLD PATCH: the plugin's side job dialogue choices
endFunction

; The name the server knows someone by (the player by their own name).
string function LwRealName(Actor a)
    if (a == PlayerRef)
        return PlayerRef.GetDisplayName()
    endIf
    return LivingWorldFog.RealName(a)
endFunction

bool function LwArePartners(Actor a, Actor b)
    if (!a || !b || a == b)
        return false
    endIf
    if (a.GetRelationshipRank(b) >= 4)
        return true   ; vanilla lovers: spouses are set up this way
    endIf
    if (!LwCouples || LwCouples.Length == 0)
        return false
    endIf
    string na = LwRealName(a)
    string nb = LwRealName(b)
    return LwCouples.Find(na + "|" + nb) >= 0 || LwCouples.Find(nb + "|" + na) >= 0
endFunction

; From LwSceneSample: a witness who can see the scene from close by. Starts a confrontation when one of the
; scene's people is their partner. The conversation itself starts on its own stack (OnLwConfront).
function LwMaybeConfront(int slot, Actor w)
    if (!LivingWorldIntimacyOn || !_lwScConfronted || _lwScConfronted[slot] || _lwScForced[slot] || _lwConfrontWho)
        return   ; a forced scene is an assault, not a lovers' quarrel (the server remembers it that way)
    endIf
    float now = Utility.GetCurrentRealTime()
    if (now - _lwConfrontAt < LwConfrontCooldown || w.IsInCombat() || w.GetSleepState() >= 3 || w.IsUnconscious())
        return
    endIf
    Actor partner = None
    int k = 0
    while (k < 3 && !partner)
        Actor p = _lwScA[slot * 3 + k]
        if (p && LwArePartners(w, p))
            partner = p
        endIf
        k += 1
    endWhile
    if (!partner)
        return
    endIf
    _lwScConfronted[slot] = true
    _lwConfrontAt = now
    _lwConfrontWho = w
    _lwConfrontPartner = partner
    _lwConfrontSlot = slot
    SendModEvent("LivingWorld_Confront")
endFunction

Event OnLwConfront(string eventName, string strArg, float numArg, Form sender)
    Actor w = _lwConfrontWho
    Actor partner = _lwConfrontPartner
    int slot = _lwConfrontSlot
    _lwConfrontWho = None
    _lwConfrontPartner = None
    if (!w || !partner || slot < 0 || _lwScThread[slot] < 0)
        return
    endIf
    LwConfront(slot, w, partner)
EndEvent

function LwConfront(int slot, Actor w, Actor partner)
    MantellaConversation conv = ListenerScript.conversation
    string who = LwRealName(w)
    string partnerName = LwRealName(partner)
    string others = ""
    int k = 0
    while (k < 3)
        Actor p = _lwScA[slot * 3 + k]
        if (p && p != partner && p != w)
            if (others != "")
                others += " and "
            endIf
            others += LwRealName(p)
        endIf
        k += 1
    endWhile
    string ev
    if (partner == PlayerRef)
        ev = who + " walks in on " + partnerName + " being intimate with " + others + ". " + who + " is " + partnerName + "'s own partner and confronts them about it right now."
    else
        ev = who + " walks in on " + partnerName + ", " + who + "'s own partner, being intimate with " + others + ", and confronts them about it right now."
    endIf
    bool playerIn = _lwScA[slot * 3] == PlayerRef
    Actor center = _lwScA[slot * 3 + 1]
    Debug.Trace("Mantella Living World: " + who + " walks in on " + partnerName + " (scene slot " + slot + ")")
    if (conv.IsRunning())
        if (!conv.Participants.HasForm(w))
            Actor[] add = new Actor[1]
            add[0] = w
            conv.AddActorsToConversation(add)
        endIf
        Debug.Notification(w.GetDisplayName() + " has walked in on you.")
        conv.AddIngameEvent(ev)
        return
    endIf
    if (!playerIn && (!center || center.GetDistance(PlayerRef) / 71.0210 > LivingWorldWitnessScanMeters))
        return   ; nobody to hear it; the scene's end record still keeps what they saw
    endIf
    Actor[] actors = new Actor[5]
    actors[0] = PlayerRef
    actors[1] = w
    int n = 2
    k = 0
    while (k < 3 && n < 5)
        Actor q = _lwScA[slot * 3 + k]
        if (q && q != PlayerRef && q != w)
            actors[n] = q
            n += 1
        endIf
        k += 1
    endWhile
    Actor[] people = LwTrimActors(actors, n)
    conv.Start()
    Debug.Notification(w.GetDisplayName() + " has walked in on you.")
    conv.AddIngameEvent(ev)
    conv.StartConversation(people)
    if (playerIn)
        conv.TriggerApproachMoveAction(w)
    endIf
endFunction

Actor[] function LwTrimActors(Actor[] arr, int n)
    if (n == 3)
        Actor[] three = new Actor[3]
        three[0] = arr[0]
        three[1] = arr[1]
        three[2] = arr[2]
        return three
    elseIf (n == 4)
        Actor[] four = new Actor[4]
        four[0] = arr[0]
        four[1] = arr[1]
        four[2] = arr[2]
        four[3] = arr[3]
        return four
    elseIf (n == 2)
        Actor[] two = new Actor[2]
        two[0] = arr[0]
        two[1] = arr[1]
        return two
    endIf
    return arr
endFunction

; From the regular checks (every 2 s): the player naked in public long enough, and a guard who can see it.
function LwDecencyTick(float now)
    if (_lwPlayerCovered)
        _lwNakedSince = 0.0
        return
    endIf
    if (PlayerRef.IsSwimming())
        _lwSwamAt = now   ; bathing: and for a little while after getting out
    endIf
    if (_lwNakedSince == 0.0)
        _lwNakedSince = now
        return
    endIf
    if (now - _lwNakedSince < LwDecencyGraceSeconds || now - _lwSwamAt < 45.0 || now - _lwDecencyAt < LwDecencyCooldown || now - _lwDecencyScanAt < LwDecencyScanSeconds)
        return
    endIf
    if (_lwDecencyGuard || ListenerScript.conversation.IsRunning() || PlayerRef.IsInCombat() || PlayerRef.GetSitState() != 0 || Utility.IsInMenuMode())
        return   ; sitting or lying down (a bed) is not walking about
    endIf
    if (_lwScAny && LwInScene(PlayerRef) >= 0)
        return
    endIf
    Location here = PlayerRef.GetCurrentLocation()
    if (here && _lwPlayerHouseKw && here.HasKeyword(_lwPlayerHouseKw))
        return
    endIf
    _lwDecencyScanAt = now
    Actor guard = LwDecencyFindGuard()
    if (!guard)
        return
    endIf
    _lwDecencyAt = now
    _lwDecencyGuard = guard
    LivingWorldQueue(LivingWorldHeader("react") + "|actor=" + LivingWorldActorField(guard) + "|target=" + LivingWorldActorField(PlayerRef) + "|via=decency|dur=" + (now - _lwNakedSince))
    SendModEvent("LivingWorld_Decency")   ; the conversation starts on its own stack, not the timer's
endFunction

; The nearest guard within LwDecencyGuardMeters who can see the player and is free to come over, or None.
Actor function LwDecencyFindGuard()
    Actor[] near
    if (!_lwNoPo3 && _lwActorTypeNPC)
        near = LivingWorldPO3.PeopleNear(PlayerRef, LwDecencyGuardMeters * 71.0210, _lwActorTypeNPC)
    endIf
    if (!near || near.Length == 0)
        near = LwPeopleInCell()   ; Mantella's nearby scan only had the five nearest people, rarely a guard outdoors
    endIf
    Actor best = None
    float bestM = 100000.0
    int i = 0
    while (i < near.Length)
        Actor a = near[i]
        if (a && a != PlayerRef && a.IsGuard() && LivingWorldIsPerson(a) && !a.IsInCombat() && !a.IsInDialogueWithPlayer() && a.GetSleepState() < 3 && !a.IsHostileToActor(PlayerRef))
            float m = a.GetDistance(PlayerRef) / 71.0210
            if (m <= LwDecencyGuardMeters && m < bestM && a.HasLOS(PlayerRef))
                best = a
                bestM = m
            endIf
        endIf
        i += 1
    endWhile
    return best
endFunction

; Every person in the player's cell (SKSE Cell.GetNthRef, form type 62 = Character), up to 40.
Actor[] function LwPeopleInCell()
    Actor[] people = new Actor[40]
    Cell here = PlayerRef.GetParentCell()
    if (!here)
        return people
    endIf
    int total = here.GetNumRefs(62)
    int n = 0
    int i = 0
    while (i < total && n < 40)
        Actor a = here.GetNthRef(i, 62) as Actor
        if (a && a != PlayerRef && !a.IsDisabled())
            people[n] = a
            n += 1
        endIf
        i += 1
    endWhile
    return people
endFunction

Event OnLwDecency(string eventName, string strArg, float numArg, Form sender)
    Actor guard = _lwDecencyGuard
    _lwDecencyGuard = None
    MantellaConversation conv = ListenerScript.conversation
    if (!guard || guard.IsDead() || conv.IsRunning())
        return
    endIf
    Debug.Notification(guard.GetDisplayName() + " saw you naked and is coming over.")
    if (guard.GetDistance(PlayerRef) / 71.0210 > 3.0)
        guard.PathToReference(PlayerRef, 1.0)   ; at a run (latent: this event's own stack), then talk face to face
    endIf
    if (conv.IsRunning() || guard.IsDead() || guard.IsInCombat())
        return
    endIf
    Actor[] actors = new Actor[2]
    actors[0] = PlayerRef
    actors[1] = guard
    conv.Start()
    conv.AddIngameEvent(LivingWorldFog.RealName(guard) + ", a guard, saw " + PlayerRef.GetDisplayName() + " walking about naked in public and has hurried over about it.")
    conv.StartConversation(actors)
    guard.EvaluatePackage()
EndEvent

; A guard's PayFine (MantellaExtension guard/decency.py): the fine for public nakedness goes from the player to the
; guard, as much of it as the player has.
function LwPayFine(Actor guard, int gold)
    MiscObject coin = Game.GetFormFromFile(0x0000000F, "Skyrim.esm") as MiscObject   ; Gold001
    if (!coin || gold <= 0)
        return
    endIf
    int have = PlayerRef.GetItemCount(coin)
    int take = gold
    if (have < take)
        take = have
    endIf
    if (take > 0)
        PlayerRef.RemoveItem(coin, take, true, guard)
    endIf
    Debug.Notification("Fine paid: " + take + " gold")
    if (take < gold)
        ListenerScript.AddIngameEventToConversation(PlayerRef.GetDisplayName() + " only had " + take + " of the " + gold + " gold fine on them.")
    endIf
endFunction

; Wandering eyes, one body-language step: returns true while her glance down is in progress.
; The more readily she looks (_lwbPeek, from the server: attraction, liking, her mood, her nature), the more
; often the chance comes and the likelier she takes it. Only a woman, only while the player is naked with The
; New Gentleman's bone on him, within LwPeekMeters and in her line of sight. In a conversation too: her look
; goes back to the player's face afterwards, where Mantella had it.
bool function LwBodyPeek(int i, Actor a, float d, float now, bool inTalk, bool busy)
    if (!_lwbPeekUntil || !_lwbPeek)
        return false
    endIf
    if (_lwbPeekUntil[i] > 0.0)
        if (now < _lwbPeekUntil[i] && d <= LwPeekMeters + 1.0 && !_lwPlayerCovered && !busy)
            LwPeekMarkerFollow()
            return true
        endIf
        _lwbPeekUntil[i] = 0.0
        if (inTalk || _lwbLookHeld[i])
            a.SetLookAt(PlayerRef)
        else
            a.ClearLookAt()
        endIf
        return false
    endIf
    if (!LwPeekOn || _lwPlayerCovered || busy || d > LwPeekMeters || now < _lwbNextPeekAt[i])
        return false
    endIf
    float peek = _lwbPeek[i]
    if (peek <= 0.0 || a.GetActorBase().GetSex() != 1 || (_lwScAny && LwInScene(a) >= 0))
        return false
    endIf
    if (_lwErectShown)
        peek += 0.15
    endIf
    _lwbNextPeekAt[i] = now + 6.0 + 18.0 * (1.0 - peek) + Utility.RandomFloat(0.0, 4.0)
    if (Utility.RandomFloat(0.0, 1.0) > peek || LwPlayerGenitalScale() <= 0.0 || !a.HasLOS(PlayerRef))
        return false
    endIf
    if (!LwPeekMarkerFollow())
        return false
    endIf
    a.SetLookAt(_lwPeekMarker)
    _lwbPeekUntil[i] = now + 1.2 + 1.2 * peek
    if (now - _lwbPeekRecAt[i] >= 60.0)
        _lwbPeekRecAt[i] = now
        LwBodyRecord(a, "peek", "|dist=" + d)   ; so her next line knows she looked (changes no feelings)
    endIf
    return true
endFunction

; No profile from the server yet: from how she knows the player.
float function LwPeekDefault(Actor a, int rank)
    if (a.GetActorBase().GetSex() != 1)
        return 0.0
    elseIf (rank >= 2)
        return 0.45
    elseIf (rank == 1)
        return 0.35
    elseIf (rank < 0)
        return 0.05
    endIf
    return 0.25
endFunction

; An invisible marker at the player's groin for her to look at (XMarker, Skyrim.esm 0x3B).
bool function LwPeekMarkerFollow()
    if (!_lwPeekMarker)
        Form xm = Game.GetFormFromFile(0x0000003B, "Skyrim.esm")
        if (!xm)
            return false
        endIf
        _lwPeekMarker = PlayerRef.PlaceAtMe(xm, 1, true)
        if (!_lwPeekMarker)
            return false
        endIf
    endIf
    if (NetImmerse.HasNode(PlayerRef, "NPC GenitalsBase [GenBase]", false))
        _lwPeekMarker.MoveToNode(PlayerRef, "NPC GenitalsBase [GenBase]")
    else
        _lwPeekMarker.MoveToNode(PlayerRef, "NPC Pelvis [Pelv]")
    endIf
    return true
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LIVINGWORLD PATCH: body language, step 2 (BL2): VR gestures                                        ;
; While body language watches someone, the right hand and the headset are sampled through VRIK about ;
; seven times a second (relative to the headset, so walking does not count) and a few gestures are   ;
; recognised: wave, nod, head shake, point, beckon, hands up, thumbs up and down. Each one becomes a  ;
; type=presence record to the NPC the player faces (hands up: everyone watched), with its own        ;
; cooldown; the server decides what it means to them (livingworld/bodylang/presence.py).             ;
; Positions are in game units (about 70 to the metre). If sampling costs too much, it slows down,    ;
; and turns itself off for the session if that is still too slow.                                   ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

bool property LivingWorldGesturesOn = true auto hidden      ; the server's start reply switches it (MANTELLA_LW_GESTURES)
bool property LivingWorldGestureNotices = true auto hidden  ; show each recognised gesture (MANTELLA_LW_GESTURE_NOTICES)
float property LwGestureSeconds = 0.15 auto hidden

bool _lwgVrik = false
bool _lwbWatching = false
float _lwgDueAt = 0.0
float _lwgInterval = 0.15
float[] _lwgHx              ; ring of the last 10 samples: right hand relative to the headset
float[] _lwgHy
float[] _lwgHz
float[] _lwgEx              ; the headset
float[] _lwgEy
float[] _lwgEz
int _lwgN = 0               ; samples in the ring since it was last cleared
int _lwgUpTicks = 0
int _lwgRaisedTicks = 0
int _lwgThumbTicks = 0
int _lwgPointTicks = 0
int _lwgGripBase = -1
float _lwgGripBaseAt = 0.0
float _lwgLastWave = -100.0
float _lwgLastNod = -100.0
float _lwgLastShake = -100.0
float _lwgLastPoint = -100.0
float _lwgLastBeckon = -100.0
float _lwgLastUp = -100.0
float _lwgLastThumb = -100.0
float _lwgCostSum = 0.0
int _lwgCostN = 0
bool _lwgSlowed = false

; Called with LwBodyReset on every load.
function LwGestureReset()
    _lwgVrik = VRIK.VrikGetBuildNumber() > 0
    _lwgHx = new float[10]
    _lwgHy = new float[10]
    _lwgHz = new float[10]
    _lwgEx = new float[10]
    _lwgEy = new float[10]
    _lwgEz = new float[10]
    _lwgN = 0
    _lwgUpTicks = 0
    _lwgRaisedTicks = 0
    _lwgThumbTicks = 0
    _lwgPointTicks = 0
    _lwgGripBase = -1
    _lwgDueAt = 0.0
    _lwgInterval = LwGestureSeconds
    _lwgCostSum = 0.0
    _lwgCostN = 0
    _lwgSlowed = false
    if (!_lwgVrik)
        Debug.Trace("Mantella Living World: VRIK not found; gestures are off")
    endIf
endFunction

bool function LwGesturesActive()
    return LivingWorldGesturesOn && LivingWorldBodyLanguageOn && _lwgVrik && _lwbWatching
endFunction

; The start reply's switches (mantella_lw_gestures_on, mantella_lw_gesture_notices).
function LivingWorldSetGestures(bool on, bool notices)
    LivingWorldGestureNotices = notices
    if (on != LivingWorldGesturesOn)
        LivingWorldGesturesOn = on
        _lwgN = 0
        if (on && !_lwProbeOn)
            LwScheduleNext(Utility.GetCurrentRealTime())
        endIf
    endIf
endFunction

int function LwgAt(int back)   ; ring index of the sample taken `back` samples ago
    return (_lwgN - 1 - back) % 10
endFunction

; How many times the motion turned around over the last `count` samples. kind 0: the hand side to side,
; 1: the headset up and down, 2: the headset side to side. Only moves of at least `minStep` count, so a
; turnaround that falls between two samples is still seen.
int function LwgReversals(int kind, int count, float minStep)
    if (count > _lwgN)
        count = _lwgN
    endIf
    int turns = 0
    float lastX = 0.0
    float lastY = 0.0
    bool haveLast = false
    int k = count - 1
    while (k > 0)
        int a = LwgAt(k)
        int b = LwgAt(k - 1)
        float dx = 0.0
        float dy = 0.0
        if (kind == 0)
            dx = _lwgHx[b] - _lwgHx[a]
            dy = _lwgHy[b] - _lwgHy[a]
        elseIf (kind == 1)
            dx = _lwgEz[b] - _lwgEz[a]
        else
            dx = _lwgEx[b] - _lwgEx[a]
            dy = _lwgEy[b] - _lwgEy[a]
        endIf
        float len = Math.sqrt(dx * dx + dy * dy)
        if (len > 105.0)   ; over 1.5 m in one sample: a teleport or a load, not a gesture
            return 0
        endIf
        if (len >= minStep)
            if (haveLast && dx * lastX + dy * lastY < 0.0)
                turns += 1
            endIf
            lastX = dx
            lastY = dy
            haveLast = true
        endIf
        k -= 1
    endWhile
    return turns
endFunction

; How far the headset (kind 1: up and down only) or the hand moved, end to end, over the last `count` samples.
float function LwgNet(int kind, int count)
    if (count > _lwgN)
        count = _lwgN
    endIf
    if (count < 2)
        return 0.0
    endIf
    int a = LwgAt(count - 1)
    int b = LwgAt(0)
    if (kind == 0)
        return Math.sqrt((_lwgHx[b] - _lwgHx[a]) * (_lwgHx[b] - _lwgHx[a]) + (_lwgHy[b] - _lwgHy[a]) * (_lwgHy[b] - _lwgHy[a]) + (_lwgHz[b] - _lwgHz[a]) * (_lwgHz[b] - _lwgHz[a]))
    elseIf (kind == 1)
        return Math.abs(_lwgEz[b] - _lwgEz[a])
    endIf
    return Math.sqrt((_lwgEx[b] - _lwgEx[a]) * (_lwgEx[b] - _lwgEx[a]) + (_lwgEy[b] - _lwgEy[a]) * (_lwgEy[b] - _lwgEy[a]))
endFunction

; The watched NPC the player faces most, within 40 degrees (or the only one watched).
Actor function LwgAddressee()
    Actor best = None
    float bestAngle = 40.0
    int watched = 0
    Actor only = None
    int i = 0
    while (i < 4)
        Actor a = _lwbActors[i]
        if (a)
            watched += 1
            only = a
            float ang = Math.abs(PlayerRef.GetHeadingAngle(a))
            if (ang < bestAngle)
                bestAngle = ang
                best = a
            endIf
        endIf
        i += 1
    endWhile
    if (!best && watched == 1 && Math.abs(PlayerRef.GetHeadingAngle(only)) < 70.0)
        best = only
    endIf
    return best
endFunction

function LwGesture(string what, Actor about)
    _lwgN = 0   ; start the next gesture from fresh samples
    if (what == "hands_up")
        int i = 0
        while (i < 4)
            if (_lwbActors[i])
                LwBodyRecord(_lwbActors[i], what, "")
            endIf
            i += 1
        endWhile
        if (LivingWorldGestureNotices)
            Debug.Notification("Gesture: hands up")
        endIf
        return
    endIf
    Actor to = LwgAddressee()
    if (!to)
        if (LivingWorldGestureNotices)
            Debug.Notification("Gesture: " + what + " (nobody facing you)")
        endIf
        return
    endIf
    string extra = ""
    if (about)
        extra = "|about=" + about.GetDisplayName()
    endIf
    LwBodyRecord(to, what, extra + "|dist=" + (to.GetDistance(PlayerRef) / 71.0210))
    if (LivingWorldGestureNotices)
        string text = "Gesture: " + what + " to " + to.GetDisplayName()
        if (about)
            text += " (at " + about.GetDisplayName() + ")"
        endIf
        Debug.Notification(text)
    endIf
endFunction

; Who the right hand points at: the watched NPC or conversation participant closest to the line from
; the player through the hand, within 20 degrees.
Actor function LwgPointedAt()
    float[] p = new float[3]
    if (!NetImmerse.GetNodeWorldPosition(PlayerRef, "NPC R Hand [RHnd]", p, true))
        return None
    endIf
    float px = PlayerRef.GetPositionX()
    float py = PlayerRef.GetPositionY()
    float dx = p[0] - px
    float dy = p[1] - py
    float dlen = Math.sqrt(dx * dx + dy * dy)
    if (dlen < 10.0)
        return None
    endIf
    Actor best = None
    float bestCos = Math.cos(20.0)
    int i = 0
    while (i < 4)
        Actor a = _lwbActors[i]
        if (a)
            float ax = a.GetPositionX() - px
            float ay = a.GetPositionY() - py
            float alen = Math.sqrt(ax * ax + ay * ay)
            if (alen > 1.0)
                float c = (ax * dx + ay * dy) / (alen * dlen)
                if (c > bestCos)
                    bestCos = c
                    best = a
                endIf
            endIf
        endIf
        i += 1
    endWhile
    return best
endFunction

; +1 the right thumb points up, -1 down, 0 neither (the first-person hand follows VRIK's finger tracking).
int function LwgThumbDirection()
    float[] p = new float[3]
    if (!NetImmerse.GetNodeWorldPosition(PlayerRef, "NPC R Finger00 [RF00]", p, true))
        return 0
    endIf
    float bx = p[0]
    float by = p[1]
    float bz = p[2]
    if (!NetImmerse.GetNodeWorldPosition(PlayerRef, "NPC R Finger02 [RF02]", p, true))
        return 0
    endIf
    float dz = p[2] - bz
    float len = Math.sqrt((p[0] - bx) * (p[0] - bx) + (p[1] - by) * (p[1] - by) + dz * dz)
    if (len < 0.5)
        return 0
    endIf
    if (dz > 0.7 * len)
        return 1
    elseIf (dz < -0.7 * len)
        return -1
    endIf
    return 0
endFunction

function LwGestureTick(float now)
    float t0 = Utility.GetCurrentRealTime()
    float ex = VRIK.VrikGetHmdX()
    float ey = VRIK.VrikGetHmdY()
    float ez = VRIK.VrikGetHmdZ()
    float hx = VRIK.VrikGetHandX(false) - ex
    float hy = VRIK.VrikGetHandY(false) - ey
    float hz = VRIK.VrikGetHandZ(false) - ez
    float lz = VRIK.VrikGetHandZ(true) - ez
    int i = _lwgN % 10
    _lwgHx[i] = hx
    _lwgHy[i] = hy
    _lwgHz[i] = hz
    _lwgEx[i] = ex
    _lwgEy[i] = ey
    _lwgEz[i] = ez
    _lwgN += 1
    if (_lwgN > 1000)
        _lwgN = 10 + _lwgN % 10
    endIf
    float reach = Math.sqrt(hx * hx + hy * hy)   ; how far out in front or to the side the hand is
    bool free = !PlayerRef.IsWeaponDrawn() && !HiggsVR.GetGrabbedObject(false)
    MantellaConversation conv = ListenerScript.conversation
    bool talking = conv && conv.IsRunning()

    ; hands up: both hands above the head for about a second
    if (hz > 6.0 && lz > 6.0)
        _lwgUpTicks += 1
    else
        _lwgUpTicks = 0
    endIf
    if (_lwgUpTicks >= 6 && now - _lwgLastUp >= 30.0)
        _lwgLastUp = now
        _lwgUpTicks = 0
        LwGesture("hands_up", None)
        LwGestureCost(t0)
        return
    endIf

    ; wave: the right hand at head height, out to the side or front, turning around at least twice
    if (hz > -10.0 && hz < 40.0 && reach > 12.0 && lz < 0.0)
        _lwgRaisedTicks += 1
    else
        _lwgRaisedTicks = 0
    endIf
    if (_lwgRaisedTicks >= 5 && now - _lwgLastWave >= 20.0 && LwgReversals(0, _lwgRaisedTicks, 3.5) >= 2)
        _lwgLastWave = now
        _lwgRaisedTicks = 0
        LwGesture("wave", None)
        LwGestureCost(t0)
        return
    endIf

    bool grip = free && VRIK.VrikIsGripPressed(false)
    bool triggerTouched = false
    if (grip)
        triggerTouched = VRIK.VrikIsTriggerTouched(false)
    endIf

    ; thumbs up or down: grip and trigger held, the thumb off the stick and buttons and upright
    if (grip && triggerTouched && hz < 0.0 && !VRIK.VrikIsThumbstickTouched(false) && !VRIK.VrikIsButtonATouched(false) && !VRIK.VrikIsButtonBTouched(false))
        _lwgThumbTicks += 1
    else
        _lwgThumbTicks = 0
    endIf
    if (_lwgThumbTicks >= 4 && now - _lwgLastThumb >= 15.0)
        int dir = LwgThumbDirection()
        if (dir != 0)
            _lwgLastThumb = now
            _lwgThumbTicks = 0
            if (dir > 0)
                LwGesture("thumbs_up", None)
            else
                LwGesture("thumbs_down", None)
            endIf
            LwGestureCost(t0)
            return
        endIf
    endIf

    ; point: the arm held out still with the index finger off the trigger
    if (grip && !triggerTouched && reach > 32.0 && hz > -32.0 && hz < 12.0)
        _lwgPointTicks += 1
    else
        _lwgPointTicks = 0
    endIf
    if (_lwgPointTicks >= 5 && now - _lwgLastPoint >= 10.0 && LwgNet(0, 5) < 3.0)
        _lwgLastPoint = now
        _lwgPointTicks = 0
        LwGesture("point", LwgPointedAt())
        LwGestureCost(t0)
        return
    endIf

    ; beckon: the hand out in front and the fingers curled in (grip pressed) twice within two seconds
    if (free && reach > 18.0 && hz > -35.0 && hz < 8.0)
        int presses = VRIK.VrikGripPressCount(false)
        if (_lwgGripBase < 0 || now - _lwgGripBaseAt > 2.0)
            _lwgGripBase = presses
            _lwgGripBaseAt = now
        elseIf (presses - _lwgGripBase >= 2 && now - _lwgLastBeckon >= 15.0)
            _lwgLastBeckon = now
            _lwgGripBase = -1
            LwGesture("beckon", None)
            LwGestureCost(t0)
            return
        endIf
    else
        _lwgGripBase = -1
    endIf

    ; nod and head shake: only toward someone close (or in a conversation), standing still, hands down
    if (hz < -15.0 && (talking || LwgAddressee()))
        if (now - _lwgLastNod >= 8.0 && LwgReversals(1, 8, 0.7) >= 2 && LwgNet(2, 8) < 3.0)
            _lwgLastNod = now
            LwGesture("nod", None)
        elseIf (now - _lwgLastShake >= 8.0 && LwgReversals(2, 8, 0.9) >= 2 && LwgNet(2, 8) < 3.0 && LwgRangeZ(8) < 1.5)
            _lwgLastShake = now
            LwGesture("shake", None)
        endIf
    endIf
    LwGestureCost(t0)
endFunction

float function LwgRangeZ(int count)   ; how far the headset moved up and down over the last samples
    if (count > _lwgN)
        count = _lwgN
    endIf
    float lo = 100000.0
    float hi = -100000.0
    int k = 0
    while (k < count)
        float z = _lwgEz[LwgAt(k)]
        if (z < lo)
            lo = z
        endIf
        if (z > hi)
            hi = z
        endIf
        k += 1
    endWhile
    if (hi < lo)
        return 0.0
    endIf
    return hi - lo
endFunction

; Keeps gesture sampling cheap: slower if a tick costs over 60 ms on average, off for the session if still
; over 120 ms (the game's scripts must never fall behind because of this).
function LwGestureCost(float t0)
    _lwgCostSum += Utility.GetCurrentRealTime() - t0
    _lwgCostN += 1
    if (_lwgCostN < 20)
        return
    endIf
    float avg = _lwgCostSum / _lwgCostN
    _lwgCostSum = 0.0
    _lwgCostN = 0
    if (!_lwgSlowed && avg > 0.06)
        _lwgSlowed = true
        _lwgInterval = LwGestureSeconds * 2.0
        Debug.Trace("Mantella Living World gestures: a sample takes " + avg + " s; sampling less often")
    elseIf (_lwgSlowed && avg > 0.12)
        _lwgVrik = false
        Debug.Trace("Mantella Living World gestures: a sample takes " + avg + " s; gestures off until the next load")
        if (LivingWorldGestureNotices)
            Debug.Notification("Gestures switched off: too slow on this game")
        endIf
    endIf
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LIVINGWORLD PATCH: surrender                                                                       ;
; The LWSaloniaSurrender plugin watches the Carvain party (Dark Brotherhood wedding guests) and sends ;
; LivingWorld_Surrender (survivor, husband, bodyguard or None, killed by the player) once the husband ;
; and the bodyguard are dead. Here the survivor stops fighting or fleeing, comes to the player, a     ;
; react record (via=surrender, MantellaExtension social/surrender.py) is queued and a conversation    ;
; starts: she begs to be spared and offers to come along (Mantella's Follow). After that she is a     ;
; survivor: Unfollow sends her home (LivingWorld_SurrenderHome: the plugin walks her to the player's  ;
; house, else the Bannered Mare) and Follow again calls her back (LivingWorld_SurrenderFollow).        ;
; The server's start reply switches it (mantella_lw_surrender_on, MANTELLA_LW_SURRENDER).             ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

bool property LwSurrenderOn = true auto hidden
Actor[] _lwSurvivors   ; everyone who surrendered to the player (kept in the save)
string[] _lwSurvivorFields   ; ...and their actor field from then (the persistent copy's rebind, if the old ref is gone)
Actor _lwSurrenderLast   ; the last surrender handled, and its game time: a repeated event is ignored
float _lwSurrenderLastAt = -1.0

Event OnLwSurrender(Form survivorForm, Form husbandForm, Form guardForm, bool playerKilled)
    Actor s = survivorForm as Actor
    Actor husband = husbandForm as Actor
    Actor guard = guardForm as Actor
    if (!LwSurrenderOn || !s || !husband || s.IsDead())
        return
    endIf
    ; The same surrender twice (a repeated event) is ignored; a survivor surrendering again after a reload, or
    ; long after, still gets her opening conversation (2026-11-11: a reloaded mid-fight save skipped it).
    float gameNow = Utility.GetCurrentGameTime()
    if (s == _lwSurrenderLast && gameNow >= _lwSurrenderLastAt && gameNow - _lwSurrenderLastAt < 0.01)
        return
    endIf
    _lwSurrenderLast = s
    _lwSurrenderLastAt = gameNow
    if (!LwIsSurvivor(s))
        LwAddSurvivor(s)
    endIf
    s.StopCombat()
    s.StopCombatAlarm()
    s.EvaluatePackage()
    string who = LwRealName(s)
    string lost = LwRealName(husband)
    if (guard)
        lost += " and " + LwRealName(guard)
    endIf
    Debug.Trace("Mantella Living World: " + who + " surrenders (" + lost + " dead, player killed: " + playerKilled + ")")
    Debug.Notification(s.GetDisplayName() + " drops to her knees and comes to you.")
    ; No latent PathToReference here: mid-fight it never returned, so nothing after it ran (2026-11-11). The
    ; record and the conversation go first; Mantella's approach walks her over.
    string killer = "other"
    if (playerKilled)
        killer = "player"
    endIf
    string rec = LivingWorldHeader("react") + "|actor=" + LivingWorldActorField(s) + "|target=" + LivingWorldActorField(PlayerRef) + "|via=surrender|party=" + LivingWorldActorField(husband)
    if (guard)
        rec += "|d=" + LivingWorldActorField(guard)
    endIf
    LivingWorldQueue(rec + "|killer=" + killer)
    string ev
    if (playerKilled)
        ev = PlayerRef.GetDisplayName() + " has just killed " + lost + ". " + who + ", left alone, does not fight or run: she comes to " + PlayerRef.GetDisplayName() + " and begs to be spared."
    else
        ev = lost + " lie dead. " + who + ", left alone and helpless, comes to " + PlayerRef.GetDisplayName() + " and begs for help."
    endIf
    MantellaConversation conv = ListenerScript.conversation
    if (conv.IsRunning())
        if (!conv.Participants.HasForm(s))
            Actor[] add = new Actor[1]
            add[0] = s
            conv.AddActorsToConversation(add)
        endIf
        conv.AddIngameEvent(ev)
        return
    endIf
    Actor[] actors = new Actor[2]
    actors[0] = PlayerRef
    actors[1] = s
    conv.Start()
    conv.AddIngameEvent(ev)
    conv.StartConversation(actors)
    if (s.GetDistance(PlayerRef) / 71.0210 > 3.0)
        conv.TriggerApproachMoveAction(s)
    endIf
    s.EvaluatePackage()
EndEvent

; The plugin swapped a survivor's road-encounter reference (the game deletes it later) for a persistent copy
; with another form ID. The copy takes her place here, and a type=rebind record (MantellaExtension
; store/rebind.py) makes the server carry her memories and Mantella folder over to it.
Event OnLwSurrenderReplace(Form oldForm, Form newForm)
    Actor old = oldForm as Actor
    Actor copy = newForm as Actor
    if (!old || !copy || old == copy)
        return
    endIf
    ; read the old reference first: the plugin may disable or delete it right after sending this
    ; (2026-11-11: a stack trace on this line when its base was already gone)
    string oldField = LwSafeActorField(old)
    if (oldField == "")
        oldField = LwSurvivorField(old)
    endIf
    bool wasFollowing = old.IsInFaction(giafac_following) || old.IsPlayerTeammate()
    if (_lwSurvivors)
        int i = _lwSurvivors.Find(old)
        if (i >= 0)
            _lwSurvivors[i] = copy
            if (_lwSurvivorFields && i < _lwSurvivorFields.Length)
                _lwSurvivorFields[i] = LwSafeActorField(copy)
            endIf
        elseIf (!LwIsSurvivor(copy))
            LwAddSurvivor(copy)
        endIf
    else
        LwAddSurvivor(copy)
    endIf
    if (_lwSurrenderLast == old)
        _lwSurrenderLast = copy
    endIf
    MantellaConversation conv = None
    if (ListenerScript)
        conv = ListenerScript.conversation
    endIf
    if (conv && conv.IsRunning() && conv.Participants && conv.Participants.HasForm(old))
        conv.EndConversation()   ; the next one is with the copy, who remembers it
    endIf
    if (wasFollowing && !copy.IsDead())
        ; she was a Mantella follower: the copy is one too, so Unfollow (and going home) works on her
        MantellaFollowerUtils.DismissFollower(old, gia_FollowerQst, giafac_following)
        old.SetPlayerTeammate(false)
        copy.SetFactionRank(giafac_following, 1)
        gia_FollowerQst.Reset()
        gia_FollowerQst.Stop()
        Utility.Wait(0.5)
        gia_FollowerQst.Start()
        copy.SetPlayerTeammate(true)
        copy.EvaluatePackage()
    endIf
    string copyField = LwSafeActorField(copy)
    if (oldField != "" && copyField != "")
        LivingWorldQueue(LivingWorldHeader("rebind") + "|actor=" + copyField + "|target=" + oldField)
        Debug.Trace("Mantella Living World: " + LwRealName(copy) + " carried over to her persistent copy")
    else
        Debug.Trace("Mantella Living World: could not read the old or new reference for the persistent copy; no rebind")
    endIf
EndEvent

; LivingWorldActorField, or "" when the actor (or its base) is no longer there.
string function LwSafeActorField(Actor a)
    if (!a || !a.GetActorBase() || !ListenerScript || !ListenerScript.conversation)
        return ""
    endIf
    return LivingWorldActorField(a)
endFunction

; The actor field noted when they surrendered (for a reference that is gone by now), or "".
string function LwSurvivorField(Actor a)
    if (!a || !_lwSurvivors || !_lwSurvivorFields)
        return ""
    endIf
    int i = _lwSurvivors.Find(a)
    if (i < 0 || i >= _lwSurvivorFields.Length)
        return ""
    endIf
    return _lwSurvivorFields[i]
endFunction

bool function LwIsSurvivor(Actor a)
    return a && _lwSurvivors && _lwSurvivors.Find(a) >= 0
endFunction

function LwAddSurvivor(Actor a)
    if (!_lwSurvivors)
        _lwSurvivors = new Actor[8]
    endIf
    if (!_lwSurvivorFields)
        _lwSurvivorFields = new string[8]
    endIf
    int i = _lwSurvivors.Find(None)
    if (i < 0)
        i = 0   ; full: the oldest slot goes
    endIf
    _lwSurvivors[i] = a
    _lwSurvivorFields[i] = LwSafeActorField(a)
endFunction

; From Mantella's Unfollow: a survivor goes home instead of standing where she was left.
function LwSurrenderUnfollowed(Actor a)
    if (LwSurrenderOn && LwIsSurvivor(a) && !a.IsDead())
        a.SetPlayerTeammate(false)
        LwSurrenderSend("LivingWorld_SurrenderHome", a)
    endIf
endFunction

; From Mantella's Follow: a survivor sent home comes along again.
function LwSurrenderFollowed(Actor a)
    if (LwSurrenderOn && LwIsSurvivor(a) && !a.IsDead())
        a.SetPlayerTeammate(true)   ; a teammate goes through load doors with the player (2026-11-11: left at Whiterun's gate)
        a.EvaluatePackage()
        LwSurrenderSend("LivingWorld_SurrenderFollow", a)
    endIf
endFunction

function LwSurrenderSend(string eventName, Actor a)
    int h = ModEvent.Create(eventName)
    if (h)
        ModEvent.PushForm(h, a)
        ModEvent.Send(h)
    endIf
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LIVINGWORLD PATCH: side jobs (MantellaExtension social/side_jobs.py, MANTELLA_LW_SALONIA_JOBS)     ;
; A survivor (Salonia) the player sends out in Whiterun to steal or to flirt for coin. The server    ;
; decides how it went and sends mantella_lw_side_job_do with an NPC line, one string per job:        ;
;   job|theft or flirt|ok or caught|her name|her ref|owner|owner ref|min value|max items|gold|0|bolo  ;
; (refs are "Plugin.esm:0x0001ABCD" or empty). Here the real goods move: up to max items worth min   ;
; value or more from the owner (their own pack, then their shop chest), jewellery first, and any     ;
; coin, into her pack. Never any crime gold: a caught theft is only a lookout (BOLO) the server keeps.;
; What was really taken goes back as a job record via=loot.                                         ;
; The LWSaloniaSurrender plugin's dialogue choices send LivingWorld_SideJob(Form her, string via,    ;
; string task): via ask (task theft or flirt), approve (task 1, 2 or 3) or drop; queued as job records.;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

bool property LwSideJobsOn = true auto hidden
Keyword _lwKwJewelry
Keyword _lwKwVendorJewelry
Keyword _lwKwGem

Event OnLwSideJob(Form herForm, string via, string task)
    Actor her = herForm as Actor
    if (!LwSideJobsOn || !her || her.IsDead() || !LwIsSurvivor(her))
        return
    endIf
    if (via != "ask" && via != "approve" && via != "drop")
        return
    endIf
    string rec = LivingWorldHeader("job") + "|actor=" + LivingWorldActorField(her) + "|target=" + LivingWorldActorField(PlayerRef) + "|via=" + via
    if (task != "")
        rec += "|task=" + task
    endIf
    LivingWorldQueue(rec)
EndEvent

function LwSideJobs(string[] orders)
    int i = 0
    while (orders && i < orders.Length)
        LwSideJob(orders[i])
        i += 1
    endWhile
endFunction

function LwSideJob(string order)
    string[] f = StringUtil.Split(order, "|")
    if (!f || f.Length < 11)
        Debug.Trace("Mantella Living World side jobs: bad order " + order)
        return
    endIf
    string jobId = f[0]
    string kind = f[1]
    string result = f[2]
    Actor her = LwFindActor(f[3], f[4])
    if (!her)
        Debug.Trace("Mantella Living World side jobs: job " + jobId + ": " + f[3] + " not found")
        return
    endIf
    Actor owner = None
    if (f[5] != "Whiterun Guard")
        owner = LwFindActor(f[5], f[6])
    endIf
    int minValue = f[7] as int
    int maxItems = f[8] as int
    int gold = f[9] as int
    string loot = ""
    if (result == "ok" && kind == "theft" && maxItems > 0 && owner)
        loot = LwLift(owner, her, minValue, maxItems)
    endIf
    if (result == "ok" && gold > 0)
        her.AddItem(Game.GetFormFromFile(0x0000000F, "Skyrim.esm"), gold, true)   ; Gold001
    elseIf (result != "ok")
        gold = 0
    endIf
    Debug.Trace("Mantella Living World side jobs: job " + jobId + " (" + kind + ", " + result + "): took [" + loot + "], " + gold + " gold")
    LivingWorldQueue(LivingWorldHeader("job") + "|actor=" + LivingWorldActorField(her) + "|via=loot|task=" + jobId + "|loot=" + loot + "|gold=" + gold)
endFunction

; Up to maxItems things worth minValue or more, jewellery and gems first: the owner's own pack (never
; what they wear), then the chest of any shop they run. Returns "Name:value;Name:value".
string function LwLift(Actor owner, Actor her, int minValue, int maxItems)
    string loot = ""
    int taken = 0
    int pass = 0
    ObjectReference[] sources = new ObjectReference[4]
    sources[0] = owner
    int n = 1
    Faction[] factions = owner.GetFactions(0, 127)
    int k = 0
    while (factions && k < factions.Length && n < 4)
        ObjectReference chest = None
        if (factions[k])
            chest = factions[k].GetMerchantContainer()
        endIf
        if (chest && sources.Find(chest) < 0)
            sources[n] = chest
            n += 1
        endIf
        k += 1
    endWhile
    while (pass < 2 && taken < maxItems)   ; pass 0: jewellery and gems only; pass 1: anything worth it
        int s = 0
        while (s < n && taken < maxItems)
            ObjectReference src = sources[s]
            int count = src.GetNumItems()
            int i = count - 1
            while (i >= 0 && taken < maxItems)
                Form item = src.GetNthForm(i)
                if (item && LwWorthLifting(item, src, owner, minValue, pass == 0))
                    string name = LwCleanName(item.GetName())
                    int value = item.GetGoldValue()
                    src.RemoveItem(item, 1, true, her)
                    if (loot != "")
                        loot += ";"
                    endIf
                    loot += name + ":" + value
                    taken += 1
                endIf
                i -= 1
            endWhile
            s += 1
        endWhile
        pass += 1
    endWhile
    return loot
endFunction

bool function LwWorthLifting(Form item, ObjectReference src, Actor owner, int minValue, bool jewelleryOnly)
    if (item.GetGoldValue() < minValue || item.GetName() == "" || item.GetFormID() == 0x0000000F)
        return false
    endIf
    if (item as Key || item as Book)
        return false   ; keys and notes can be quest items; leave them
    endIf
    if (src == owner && (owner.IsEquipped(item)))
        return false   ; never what they are wearing
    endIf
    if (jewelleryOnly)
        if (!_lwKwJewelry)
            _lwKwJewelry = Keyword.GetKeyword("ArmorJewelry")
            _lwKwVendorJewelry = Keyword.GetKeyword("VendorItemJewelry")
            _lwKwGem = Keyword.GetKeyword("VendorItemGem")
        endIf
        return (_lwKwJewelry && item.HasKeyword(_lwKwJewelry)) || (_lwKwVendorJewelry && item.HasKeyword(_lwKwVendorJewelry)) || (_lwKwGem && item.HasKeyword(_lwKwGem))
    endIf
    return item as Armor || item as Weapon || item as Potion || item as MiscObject || item as Ingredient || item as SoulGem
endFunction

string function LwCleanName(string s)
    ; the record uses | ; : and = as separators
    string out = ""
    int i = 0
    int len = StringUtil.GetLength(s)
    while (i < len)
        string c = StringUtil.GetNthChar(s, i)
        if (c != "|" && c != ";" && c != ":" && c != "=")
            out += c
        endIf
        i += 1
    endWhile
    return out
endFunction

; By ref ("Plugin.esm:0x0001ABCD") first, then by name among survivors, the conversation and people nearby.
Actor function LwFindActor(string name, string ref)
    if (ref != "")
        int colon = StringUtil.Find(ref, ":0x")
        if (colon > 0)
            string plugin = StringUtil.Substring(ref, 0, colon)
            int localId = LwHex(StringUtil.Substring(ref, colon + 3))
            if (localId > 0)
                Actor byRef = Game.GetFormFromFile(localId, plugin) as Actor   ; None when the plugin is not loaded
                if (byRef)
                    return byRef
                endIf
            endIf
        endIf
    endIf
    int i = 0
    while (_lwSurvivors && i < _lwSurvivors.Length)
        if (_lwSurvivors[i] && LwRealName(_lwSurvivors[i]) == name)
            return _lwSurvivors[i]
        endIf
        i += 1
    endWhile
    Actor inConv = ListenerScript.conversation.GetActorByName(name)
    if (inConv)
        return inConv
    endIf
    Actor[] near = ListenerScript.ScanNearbyActors()
    i = 0
    while (near && i < near.Length)
        if (near[i] && LwRealName(near[i]) == name)
            return near[i]
        endIf
        i += 1
    endWhile
    return None
endFunction

int function LwHex(string s)
    string digits = "0123456789ABCDEF0123456789abcdef"
    int value = 0
    int i = 0
    int len = StringUtil.GetLength(s)
    while (i < len)
        int d = StringUtil.Find(digits, StringUtil.GetNthChar(s, i))
        if (d < 0)
            return value
        endIf
        value = value * 16 + (d % 16)
        i += 1
    endWhile
    return value
endFunction
