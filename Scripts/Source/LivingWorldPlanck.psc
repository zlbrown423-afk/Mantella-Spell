Scriptname LivingWorldPlanck Hidden
; LIVINGWORLD PATCH: the only Living World script that calls PLANCK (activeragdoll, 0.8.2). Touch consent puts
; someone who agreed to be hugged or touched on PLANCK's aggression ignore list, so PLANCK does not make them
; protest, shove the player off or turn hostile while the player holds them, and takes them off it again.
; Compiling it needs PLANCK's planck.psc on the import path (PLANCK's own Source\Scripts folder). Callers check
; SKSE.GetPluginVersion("PLANCK") first. PLANCK keeps the list in memory only: it is empty after a restart.

function Ignore(Actor a) global
    if (a)
        PLANCK.AddAggressionIgnoredActor(a)
    endIf
endFunction

function Unignore(Actor a) global
    if (a)
        PLANCK.RemoveAggressionIgnoredActor(a)
    endIf
endFunction
