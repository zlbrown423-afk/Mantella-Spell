Scriptname LivingWorldFog Hidden
; LIVINGWORLD PATCH: fog. A named NPC the player has not met shows as a description ("Nord woman") until the
; player learns their name in a conversation. The server decides who the player knows (livingworld/fog) and
; sends the list with each conversation start and each name learned; MantellaRepository keeps it in the save.
;
; Everything sent to the server uses the real name (RealName), so Mantella still knows who it is talking to:
; only what the player sees changes. SetDisplayName is kept in the save, so loading an older save brings
; back the names as they were then, matching the server's own rollback.

; What the game shows for this person while the player does not know them, or "" for people it never hides:
; the player, children, generic NPCs (Guard, Bandit) and anything that is not a person.
string function StrangerLabel(Actor a) global
    if (!a || a == Game.GetPlayer() || a.IsChild())
        return ""
    endIf
    ActorBase base = a.GetActorBase()
    if (!base || !base.IsUnique() || !a.HasKeywordString("ActorTypeNPC"))
        return ""
    endIf
    return Describe(a)
endFunction

; 'Nord woman', 'High Elf man': race and sex, for anyone (the player included)
string function Describe(Actor a) global
    string noun = "man"
    if (a.GetLeveledActorBase().GetSex() == 1)
        noun = "woman"
    endIf
    Race r = a.GetRace()
    string raceName = ""
    if (r)
        raceName = r.GetName()
    endIf
    if (raceName == "")
        return "stranger"
    endIf
    return raceName + " " + noun
endFunction

; The person's real name, even while the game shows them as a stranger
string function RealName(Actor a) global
    if (!a)
        return ""
    endIf
    string shown = a.GetDisplayName()
    string label = StrangerLabel(a)
    if (label != "" && shown == label)
        return a.GetActorBase().GetName()
    endIf
    if (label == "") ; LIVINGWORLD PATCH: guard names, a generic guard shown by their own name is still "Whiterun Guard"
        string shared = GuardSharedName(a)
        if (shared != "")
            return shared
        endIf
    endIf
    return shown
endFunction

; The name a generic guard shares with the rest ("Whiterun Guard"), or "" for anyone else
string function GuardSharedName(Actor a) global
    if (!a || a == Game.GetPlayer() || !a.IsGuard())
        return ""
    endIf
    ActorBase base = a.GetActorBase()
    if (!base || base.IsUnique())
        return ""
    endIf
    string shared = base.GetName()
    if (shared == "")
        ActorBase leveled = a.GetLeveledActorBase()
        if (leveled)
            shared = leveled.GetName()
        endIf
    endIf
    return shared
endFunction

; Show this person by name or as a stranger. known: the real names the player knows; fogOn false shows everyone.
function Apply(Actor a, string[] known, bool fogOn) global
    string label = StrangerLabel(a)
    if (label == "")
        return
    endIf
    string real = a.GetActorBase().GetName()
    if (real == "" || real == label)
        return
    endIf
    string shown = a.GetDisplayName()
    bool knows = !fogOn || (known && known.Find(real) >= 0)
    if (knows)
        if (shown == label)
            a.SetDisplayName(real)
        endIf
    elseIf (shown == real)
        a.SetDisplayName(label)
    endIf
endFunction
