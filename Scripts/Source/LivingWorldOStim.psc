Scriptname LivingWorldOStim Hidden
; LIVINGWORLD PATCH: intimate scenes. The only Living World script that calls OStim (OStim Standalone
; 7.5.1b and its VR port, API 7.3.4 or later). Compiling it needs OStim's Scripts\Source on the import path.
; MantellaRepository calls these only from handlers of OStim's own mod events, so without OStim installed
; nothing here ever runs.

; The people in a thread (empty once it has ended).
Actor[] function Actors(int threadId) global
    return OThread.GetActors(threadId)
endFunction

; The scene a thread is playing now ("" while it starts up).
string function Scene(int threadId) global
    return OThread.GetScene(threadId)
endFunction

; The OStim action types of a scene: "kissing", "vaginalsex", "spanking" ... (SKSE/Plugins/OStim/actions).
string[] function ActionTypes(string sceneId) global
    if (sceneId == "")
        return Utility.CreateStringArray(0)
    endIf
    return OMetadata.GetActionTypes(sceneId)
endFunction

; A scene an animation pack tags as aggressive. Stock OStim has none; some packs do.
bool function Aggressive(string sceneId) global
    return sceneId != "" && OMetadata.HasSceneTag(sceneId, "aggressive")
endFunction

; OStim's own spank events (spank, spankleft, spankright).
bool function IsSpank(string eventType) global
    return eventType == "spank" || OEvent.IsChildOf("spank", eventType)
endFunction
