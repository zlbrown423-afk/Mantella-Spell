Scriptname LivingWorldPO3 Hidden
; LIVINGWORLD PATCH: the only Living World script that calls powerofthree's Papyrus Extender (VR 6.5.2).
; Compiling it needs PO3_SKSEFunctions.psc on the import path. Without the Extender at run time the native
; call is not bound and returns None; callers then fall back to Mantella's own nearby-actor scan.

; Every actor within radius (game units) of center that has the keyword (ActorTypeNPC: people).
Actor[] function PeopleNear(ObjectReference center, float radius, Keyword kw) global
    if (!center || !kw)
        return None
    endIf
    ObjectReference[] refs = PO3_SKSEFunctions.FindAllReferencesWithKeyword(center, kw, radius, false)
    if (!refs || refs.Length == 0)
        return None
    endIf
    int n = refs.Length
    if (n > 40)
        n = 40
    endIf
    Actor[] people = new Actor[40]   ; unused entries stay None
    int i = 0
    while (i < n)
        people[i] = refs[i] as Actor
        i += 1
    endWhile
    return people
endFunction
