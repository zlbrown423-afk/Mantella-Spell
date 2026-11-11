Scriptname MantellaAdvancedAction_Barter extends Quest Hidden 

MantellaConstants property mConsts auto
MantellaInterface property EventInterface Auto

event OnInit()
    RegisterForModEvent(EventInterface.EVENT_ACTIONS_PREFIX + mConsts.ACTION_NPC_BARTER, "OnNpcBarterActionReceived")
    RegisterForModEvent(EventInterface.EVENT_ADVANCED_ACTIONS_PREFIX + mConsts.ACTION_NPC_BARTER, "OnNpcBarterAdvancedActionReceived")
EndEvent

event OnNpcBarterActionReceived(Form speaker)
    Actor sourceActor = speaker as Actor
    NpcBarter(sourceActor)
endEvent


event OnNpcBarterAdvancedActionReceived(Form speaker, Form conversationQuest, int argumentsHandle)
    MantellaConversation conversation = conversationQuest as MantellaConversation
    
    ; Extract NPC name from parameter
    string sourceName = SKSE_HTTP.getString(argumentsHandle, mConsts.ACTION_ARG_SOURCE)
    ; Only one NPC can open their barter menu per response
    Actor sourceActor = conversation.GetActorByName(sourceName)

    NpcBarter(sourceActor)
endEvent


Function NpcBarter(Actor source)
    if (source)
        source.ShowBarterMenu()
        ; LIVINGWORLD PATCH: only merchants have a barter menu. Skyrim ignores ShowBarterMenu on anyone
        ; else (a guard, a farmer), so the player saw nothing while the NPC was told it opened. Open their
        ; pack instead, and say so, so a deal can still be done by hand (or with the Trade action).
        Utility.WaitMenuMode(0.5)
        if (UI.IsMenuOpen("BarterMenu"))
            EventInterface.AddMantellaEvent(LivingWorldFog.RealName(source) + "'s barter menu opened.")
        else
            source.OpenInventory(true)
            EventInterface.AddMantellaEvent(LivingWorldFog.RealName(source) + " is not a merchant and has no barter menu, so they opened their pack instead for the two of them to swap goods by hand.")
        endIf
    endif
EndFunction
