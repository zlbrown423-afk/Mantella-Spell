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
    LivingWorldRegisterActions()
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LIVINGWORLD PATCH: actions (sit, stand up, go there, drink)                                        ;
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
    RegisterForModEvent("MantellaConversation_Advanced_Action_mantella_lw_npc_drink", "OnLwDrinkAdvanced")
    RegisterForModEvent("MantellaConversation_Action_mantella_lw_npc_drink", "OnLwDrinkBasic")
    RegisterForModEvent("MantellaLivingWorld_SitOne", "OnLwSitOneStarted")
    RegisterForModEvent("MantellaLivingWorld_GoOne", "OnLwGoOneStarted")
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
    if (!ref || (ref as Actor))
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

Event OnLwDrinkAdvanced(Form speaker, Form conversationQuest, int argumentsHandle)
    string wanted = SKSE_HTTP.getString(argumentsHandle, "drink", "")
    Actor[] npcs = LwSources(conversationQuest, argumentsHandle)
    int i = 0
    while (i < npcs.Length)
        LwDrink(npcs[i], wanted)
        i += 1
    endWhile
EndEvent

Event OnLwDrinkBasic(Form speaker)
    LwDrink(speaker as Actor, "")
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

; ---- drink ----
; Drinks come from the NPC's own inventory, which includes anything the player gave them (Inventory action
; or vanilla trade). Recorded as a consume perception event (via=npc_action), so witnesses remember it and
; the server counts it like the player's own drinks.

Potion function LwFindDrink(Actor npc, string wanted)
    Potion fallback = None
    int n = npc.GetNumItems()
    int i = 0
    while (i < n)
        Potion p = npc.GetNthForm(i) as Potion
        if (p && !p.IsPoison())
            string name = p.GetName()
            if (wanted != "")
                if (StringUtil.Find(name, wanted) >= 0)
                    return p
                endIf
            elseIf (p.IsFood() && LwIsDrinkName(name))
                ; offered "a drink" in a tavern: ale or mead before water or milk
                if (LwIsAlcoholName(name))
                    return p
                elseIf (!fallback)
                    fallback = p
                endIf
            endIf
        endIf
        i += 1
    endWhile
    return fallback
endFunction

; Same names as livingworld/perception/records.py ALCOHOL_NAMES (minus skooma: not offered as a social drink).
; DRINK_WORDS' "tea" is left out here: as a substring it matches "Steak" and "Steamed".
bool function LwIsAlcoholName(string name)
    return StringUtil.Find(name, "ale") >= 0 || StringUtil.Find(name, "mead") >= 0 || StringUtil.Find(name, "wine") >= 0 || StringUtil.Find(name, "sujamma") >= 0 || StringUtil.Find(name, "flin") >= 0 || StringUtil.Find(name, "brandy") >= 0 || StringUtil.Find(name, "shein") >= 0 || StringUtil.Find(name, "matze") >= 0
endFunction

bool function LwIsDrinkName(string name)
    return LwIsAlcoholName(name) || StringUtil.Find(name, "milk") >= 0 || StringUtil.Find(name, "water") >= 0 || StringUtil.Find(name, "juice") >= 0 || StringUtil.Find(name, "drink") >= 0
endFunction

function LwDrink(Actor npc, string wanted)
    if (!npc || npc == PlayerRef)
        return
    endIf
    Potion p = LwFindDrink(npc, wanted)
    if (!p)
        string what = "anything to drink"
        if (wanted != "")
            what = "any " + wanted
        endIf
        ListenerScript.AddIngameEventToConversation(npc.GetDisplayName() + " did not have " + what + ".")
        return
    endIf
    Idle drinkIdle = Game.GetFormFromFile(0x000D33B0, "Skyrim.esm") as Idle   ; IdleDrinkPotion
    if (drinkIdle && !LwIsSeated(npc))
        npc.PlayIdle(drinkIdle)
        Utility.Wait(1.5)
    endIf
    npc.EquipItem(p, false, true)   ; an actor "equipping" a potion drinks it
    Debug.Notification(npc.GetDisplayName() + " drinks some " + p.GetName() + ".")
    LivingWorldConsumed(npc, p, "npc_action")
    ListenerScript.AddIngameEventToConversation(npc.GetDisplayName() + " drank some " + p.GetName() + ".")
endFunction
