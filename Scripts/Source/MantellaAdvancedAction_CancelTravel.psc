Scriptname MantellaAdvancedAction_CancelTravel extends Quest Hidden

MantellaInterface Property EventInterface Auto
MantellaConstants Property mConsts Auto
Faction Property MantellaFunctionSourceFaction Auto

int maxTravelers ; Limited by number of source aliases created in CK

event OnInit()
    RegisterForModEvent(EventInterface.EVENT_ACTIONS_PREFIX + mConsts.ACTION_NPC_CANCELTRAVEL, "OnNpcCancelTravelAdvancedActionReceived")
EndEvent

event OnNpcCancelTravelAdvancedActionReceived(Form speaker)
    ; Clear all source aliases to reset travel state
    int i = 0
    maxTravelers = 12
    While i < maxTravelers
        ReferenceAlias sourceAlias = self.GetNthAlias(i) as ReferenceAlias
        if sourceAlias
            Actor sourceActor = sourceAlias.GetActorReference()
            if sourceActor
                sourceActor.RemoveFromFaction(MantellaFunctionSourceFaction)
                sourceActor.EvaluatePackage()
            endIf
            sourceAlias.Clear()
        endIf
        i += 1
    EndWhile

    ; LIVINGWORLD PATCH: LeadTo lives on its own quest, so cancelling travel never stopped a leader
    MantellaAdvancedAction_LeadTo leadQuest = Game.GetFormFromFile(0x339B8E, "Mantella.esp") as MantellaAdvancedAction_LeadTo
    if leadQuest
        leadQuest.StopLeading("travel cancelled")
    endIf

    Debug.Notification("Travel plans cancelled.")
endEvent