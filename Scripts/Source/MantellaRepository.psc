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

; Called on every game load (HIGGS registrations are not kept in the save).
function LivingWorldRegisterPerception()
    _lwLeftHeld = None
    _lwRightHeld = None
    _lwAreaBusy = false
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
    else
        _lwRightHeld = target
        _lwRightSince = now
        _lwRightNode = ""
        _lwRightArea = ""
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
    rec += LivingWorldWitnesses(PlayerRef, target)
    LivingWorldQueue(rec)
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

function LivingWorldGuardIssue(int[] ids, string[] plugins)
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
        if (item)
            PlayerRef.AddItem(item, 1, false)
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
    if (LivingWorldHygieneOn)
        LwScheduleTick(LivingWorldHygienePollSeconds)
    endIf
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
    if (_lwProbeOn)
        LwScheduleTick(LivingWorldProbeSeconds)
    elseIf (LivingWorldHygieneOn)
        LwScheduleTick(_lwRegularDueAt - now)
    endIf
EndEvent

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
        if (LivingWorldHygieneOn)
            LwScheduleTick(_lwRegularDueAt - now)
        endIf
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
