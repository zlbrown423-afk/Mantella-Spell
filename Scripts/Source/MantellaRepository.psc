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
    LivingWorldRegisterAttireAndDrink()
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
    string rec = LivingWorldHeader("attire") + "|actor=" + LivingWorldActorField(a) + "|body=" + bodyName + "|cover=" + cover
    if (cover == "none")
        rec += LivingWorldWitnesses(a, None)   ; who could see them: only worked out when it matters
    endIf
    return rec
endFunction

bool function LivingWorldIsPerson(Actor a)
    return a && !a.IsDead() && (!_lwActorTypeNPC || a.HasKeyword(_lwActorTypeNPC))
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
    RegisterForSingleUpdate(1.0)
endFunction

Event OnUpdate()
    bool covered = PlayerRef.GetWornForm(LivingWorldBodySlotMask) != None
    if (covered != _lwPlayerCovered)
        _lwPlayerCovered = covered
        LivingWorldQueue(LivingWorldAttireRecord(PlayerRef))
    endIf
EndEvent

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
    if (!drinker || drinker == PlayerRef)
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
    if (!npc || npc == PlayerRef)
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
