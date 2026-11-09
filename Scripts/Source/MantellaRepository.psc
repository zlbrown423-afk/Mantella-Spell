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
endFunction

Event OnObjectGrabbed(ObjectReference akRef, bool abIsLeft)
    Actor target = akRef as Actor
    ; children are left out of Living World entirely
    if (!LivingWorldPerceptionOn || !target || target == PlayerRef || target.IsDead() || target.IsChild())
        return
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
        ListenerScript.AddIngameEventToConversation(PlayerRef.GetDisplayName() + " grabbed " + target.GetDisplayName() + " by the " + part + " for " + (seconds as int) + " seconds.")
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
    if (LivingWorldWalkAwayOn)
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
        if (conv.IsPlayerInConversation() && LivingWorldPlayerLeft(conv))
            away += 1.0
            if (away >= LivingWorldWalkAwaySeconds && token == _lwWalkWatch && conv.IsRunning())
                _lwWalkWatch += 1 ; this watch is done
                Debug.Notification("You walked away. Conversation ending...")
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
    string who = target.GetDisplayName()
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
        ev += " " + guard.GetDisplayName() + ", a guard, saw it and comes over to step in."
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
    return refId + "^" + baseId + "^" + conv.LivingWorldPluginName(refId) + "^" + conv.LivingWorldPluginName(baseId) + "^" + isPlayer + "^" + a.GetDisplayName()
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
;; respawns; the first time the player stands by their own bunk (within about 2.5 m) one is placed at their
;; feet and made theirs. It is a placed, persistent reference, so it and what is put in it stay in the save.
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
    ObjectReference chest = PlayerRef.PlaceAtMe(base, 1, true, false)
    if (chest)
        chest.SetActorOwner(PlayerRef.GetActorBase())
        LivingWorldChestRef = chest
        LivingWorldChestBase = 0
        Debug.Notification("A footlocker by your bunk is yours to use.")
    endIf
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
    _lwInFight = false
    _lwSwimming = PlayerRef.IsSwimming()
    _lwProbeOn = false
    _lwTickDue = 0.0
    _lwRegularDueAt = Utility.GetCurrentRealTime() + LivingWorldHygienePollSeconds
    LwBodyReset() ; LIVINGWORLD PATCH: body language (BL1)
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
    int total = 1 + participants.GetSize() + nearby.Length
    Actor[] done = new Actor[30]
    int doneCount = 0
    string[] result = Utility.CreateStringArray(0)
    int i = 0
    while (i < total && doneCount < 30)
        Actor a
        if (i == 0)
            a = PlayerRef
        elseIf (i <= participants.GetSize())
            a = participants.GetAt(i - 1) as Actor
        else
            a = nearby[i - 1 - participants.GetSize()]
        endIf
        if (LivingWorldIsPerson(a) && done.Find(a) < 0 && a.GetDistance(PlayerRef) / 71.0210 <= LivingWorldWitnessScanMeters)
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
        if (LwBodyTick(now))
            _lwbDueAt = now + LwBodyTickSeconds
        else
            _lwbDueAt = now + LwBodyScanSeconds
        endIf
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
        ListenerScript.AddIngameEventToConversation(drinker.GetDisplayName() + " reached for a drink but had none.")
        return
    endIf
    drinker.EquipItem(drink, false, true)   ; an NPC equipping a potion drinks it
    LivingWorldConsumed(drinker, drink, "action")
    ListenerScript.AddIngameEventToConversation(drinker.GetDisplayName() + " drank a " + drink.GetName() + ".")
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
    LwRegisterUndress()
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
    if (!_lwbProfActors || _lwbProfActors.Length != 16)
        _lwbProfActors = new Actor[16]
        _lwbProfComfort = new float[16]
        _lwbProfGaze = new float[16]
        _lwbProfGuard = new float[16]
        _lwbProfStep = new bool[16]
        _lwbProfNext = 0
    endIf
    _lwbArmsIdle = Game.GetFormFromFile(0x000FF7F4, "Skyrim.esm") as Idle   ; IdleOffsetArmsCrossedStart
    _lwbWeaponWas = PlayerRef.IsWeaponDrawn()
    _lwbDueAt = 0.0
    _lwbScanDueAt = 0.0
endFunction

; Undo whatever this slot's NPC is doing for us: look-at, head turned away, step back, folded arms.
function LwBodyRelease(int i)
    Actor a = _lwbActors[i]
    if (a)
        if (_lwbLookHeld[i] || _lwbGlanceUntil[i] > 0.0)
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

; The server's profiles (mantella_lw_body on an NPC line): "Name|comfort|gaze|guard|step".
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
    if (at >= 0)
        _lwbComfort[i] = _lwbProfComfort[at]
        _lwbGaze[i] = _lwbProfGaze[at]
        _lwbGuard[i] = _lwbProfGuard[at]
        _lwbStep[i] = _lwbProfStep[at]
        return
    endIf
    int rank = a.GetRelationshipRank(PlayerRef)   ; no profile yet: a default from how they know the player
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
    LwBodyAdd(Game.FindClosestActorFromRef(PlayerRef, LwBodyWatchMeters * 71.0210), now)
endFunction

function LwBodyAdd(Actor a, float now)
    if (!a || a == PlayerRef || _lwbActors.Find(a) >= 0 || !a.Is3DLoaded() || !LivingWorldIsPerson(a))
        return
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

; One body language step. Returns true while anyone is watched (the next step comes sooner).
bool function LwBodyTick(float now)
    if (!LivingWorldBodyLanguageOn || !_lwbActors || Utility.IsInMenuMode())
        return false
    endIf
    if (now >= _lwbScanDueAt)
        LwBodyScan()
        _lwbScanDueAt = now + LwBodyScanSeconds
    endIf
    bool weaponOut = PlayerRef.IsWeaponDrawn()
    bool weaponDrawnNow = weaponOut && !_lwbWeaponWas
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
