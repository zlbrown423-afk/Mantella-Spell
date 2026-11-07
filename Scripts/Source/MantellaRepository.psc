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
Form _lwLastMouthForm
float _lwLastMouthTime

; Called on every game load (HIGGS registrations are not kept in the save).
function LivingWorldRegisterPerception()
    _lwLeftHeld = None
    _lwRightHeld = None
    if (SKSE.GetPluginVersion("HIGGS") > 0)
        HiggsVR.RegisterForGrabEvent(self)
        HiggsVR.RegisterForDropEvent(self)
        HiggsVR.RegisterForConsumeEvent(self)
        Debug.Trace("Mantella Living World: listening for HIGGS grab, drop and consume events")
    else
        Debug.Trace("Mantella Living World: HIGGS not found; grab perception is off")
    endIf
endFunction

Event OnObjectGrabbed(ObjectReference akRef, bool abIsLeft)
    Actor target = akRef as Actor
    if (!LivingWorldPerceptionOn || !target || target == PlayerRef || target.IsDead())
        return
    endIf
    string node = HiggsVR.GetGrabbedNodeName(abIsLeft)
    float now = Utility.GetCurrentRealTime()
    ; a hand that grabs again without a drop event: close the previous grab first
    if (abIsLeft)
        if (_lwLeftHeld)
            LivingWorldRecordGrab(_lwLeftHeld, _lwLeftNode, "L", now - _lwLeftSince)
        endIf
        _lwLeftHeld = target
        _lwLeftSince = now
        _lwLeftNode = node
    else
        if (_lwRightHeld)
            LivingWorldRecordGrab(_lwRightHeld, _lwRightNode, "R", now - _lwRightSince)
        endIf
        _lwRightHeld = target
        _lwRightSince = now
        _lwRightNode = node
    endIf
EndEvent

Event OnObjectDropped(ObjectReference akRef, bool abIsLeft)
    Actor target = akRef as Actor
    if (!target)
        return
    endIf
    float now = Utility.GetCurrentRealTime()
    if (abIsLeft && _lwLeftHeld == target)
        _lwLeftHeld = None
        LivingWorldRecordGrab(target, _lwLeftNode, "L", now - _lwLeftSince)
    elseIf (!abIsLeft && _lwRightHeld == target)
        _lwRightHeld = None
        LivingWorldRecordGrab(target, _lwRightNode, "R", now - _lwRightSince)
    endIf
EndEvent

Event OnObjectConsumed(Form akForm, bool abIsLeft)
    _lwLastMouthForm = akForm
    _lwLastMouthTime = Utility.GetCurrentRealTime()
    LivingWorldConsumed(PlayerRef, akForm, "higgs_mouth")
EndEvent

; Also called by MantellaListenerScript.OnObjectEquipped for food, drink and potions used from the inventory.
function LivingWorldConsumed(Actor consumer, Form item, string via)
    Potion p = item as Potion
    if (!LivingWorldPerceptionOn || !p || p.IsPoison())
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

function LivingWorldRecordGrab(Actor target, string node, string hand, float seconds)
    string rec = LivingWorldHeader("grab") + "|actor=" + LivingWorldActorField(PlayerRef) + "|target=" + LivingWorldActorField(target) + "|node=" + node + "|hand=" + hand + "|dur=" + seconds + "|trank=" + target.GetRelationshipRank(PlayerRef)
    rec += LivingWorldWitnesses(PlayerRef, target)
    LivingWorldQueue(rec)
    ; let a running conversation react straight away, as Mantella's own events do
    string part = node
    if (part == "")
        part = "body"
    endIf
    ListenerScript.AddIngameEventToConversation(PlayerRef.GetDisplayName() + " grabbed " + target.GetDisplayName() + " (" + part + ") for " + (seconds as int) + " seconds.")
endFunction

string function LivingWorldHeader(string kind)
    LivingWorldEventCounter += 1
    string loc = (PlayerRef.GetCurrentLocation() as Form).GetName()
    if (loc == "")
        loc = "Skyrim"
    endIf
    return "v=1|key=" + LivingWorldLoadNonce + "-" + LivingWorldEventCounter + "|type=" + kind + "|gt=" + (Utility.GetCurrentGameTime() + 1.0) + "|loc=" + loc
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
        if (w && w != doer && w != target && w != PlayerRef && !w.IsDead() && seenAlready.Find(w) < 0)
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
