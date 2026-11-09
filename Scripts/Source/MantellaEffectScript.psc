Scriptname MantellaEffectScript extends activemagiceffect

MantellaConversation property conversation auto

event OnEffectStart(Actor target, Actor caster)
    ;Utility.Wait(0.5)
    Actor[] actors = new Actor[2]
    actors[0] = caster
    actors[1] = target
    MantellaRepository repo = conversation.repository ; LIVINGWORLD PATCH
    if(conversation.IsRunning() && repo && repo.LivingWorldFarFromConversation(conversation, target))
        ; the player has moved on from the old conversation: end it and start a new one with this NPC
        Debug.Notification("Ending the previous conversation...")
        conversation.EndConversation()
        int waited = 0
        while (conversation.IsRunning() && waited < 30)
            Utility.Wait(0.5)
            waited += 1
        endWhile
    endIf
    if(!conversation.IsRunning())
        Debug.Notification("Starting conversation...")
        conversation.Start()
        conversation.StartConversation(actors)
    Else
        if conversation.IsPlayerInConversation()
            Debug.Notification("Adding "+actors[1].GetDisplayName()+" to conversation...")
        Else
            ; If player is joining what was previously a radiant conversation
            Debug.Notification("Adding player to conversation...")
        endIf
        conversation.AddActorsToConversation(actors)
    endIf
endEvent
