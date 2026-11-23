# Generates the Spriggit YAML source for PlainsWardensKit.esp into .\Plugin (same layout as LWCoverEyes\build_yaml.ps1).
$ErrorActionPreference = 'Stop'
$root = Join-Path $PSScriptRoot 'Plugin'
if (Test-Path $root) { Remove-Item $root -Recurse -Force }
$utf8 = New-Object Text.UTF8Encoding($false)
$M = 'PlainsWardensKit.esp'

function Put($rel, $text) {
    $path = Join-Path $root $rel
    New-Item -ItemType Directory -Force (Split-Path $path) | Out-Null
    [IO.File]::WriteAllText($path, $text.Replace("`r`n", "`n"), $utf8)
}

$Quest  = "000800:$M"
$Effect = "000801:$M"
$Spell  = "000802:$M"

Put 'spriggit-meta.json' @"
{
  "PackageName": "Spriggit.Yaml.Skyrim",
  "Version": "0.41.0",
  "Release": "SkyrimVR",
  "ModKey": "$M"
}
"@

Put 'RecordData.yaml' @"
SpriggitSource:
  PackageName: Spriggit.Yaml.Skyrim
  Version: 0.41
ModKey: $M
GameRelease: SkyrimVR
ModHeader:
  Stats:
    Version: 1.7
  Author: Plains Wardens
  Description: 'Warden Kit spell: the NPC you cast it at puts on the Plains Warden Armor, boots and gauntlets. Needs PlainsWardensArmory.esp.'
  MasterReferences:
  - Master: Skyrim.esm
    FileSize: 0
  INTV: 1
"@

# Not hostile and not detrimental: the target is not angered.
Put "MagicEffects\PlainsWardensKit_Effect - 000801_$M.yaml" @"
FormKey: $Effect
EditorID: PWKit_Effect
VirtualMachineAdapter:
  Scripts:
  - Name: PWKit_Effect
Name:
  TargetLanguage: English
  Value: Warden Kit
Flags:
- NoDuration
- NoMagnitude
- NoArea
- Painless
- NoHitEvent
MagicSkill: Alteration
Archetype:
  MutagenObjectType: MagicEffectArchetype
  Type: Script
CastType: FireAndForget
TargetType: TargetActor
DualCastScale: 1
CastingSoundLevel: Silent
Sounds: []
Description:
  TargetLanguage: English
  Value: 'The person you cast this at puts on the Plains Warden Armor, Warden''s Boots and Warden''s Gauntlets.'
"@

Put "Spells\PlainsWardensKit_Spell - 000802_$M.yaml" @"
FormKey: $Spell
EditorID: PWKit_Spell
Name:
  TargetLanguage: English
  Value: Warden Kit
EquipmentType: 013F44:Skyrim.esm
Description:
  TargetLanguage: English
  Value: ''
BaseCost: 0
Flags:
- ManualCostCalc
Type: Spell
CastType: FireAndForget
TargetType: TargetActor
Range: 3000
Effects:
- BaseEffect: $Effect
  Data:
    Duration: 0
"@

Put "Quests\PlainsWardensKit_Quest - 000800_$M.yaml" @"
FormKey: $Quest
EditorID: PWKit_Quest
VirtualMachineAdapter:
  Scripts:
  - Name: PWKit_Quest
    Properties:
    - MutagenObjectType: ScriptObjectProperty
      Name: WardenKit
      Object: $Spell
  Versioning:
  - Break0
  ExtraBindDataVersion: 0
  FileName: ''
Flags:
- StartGameEnabled
- RunOnce
Priority: 10
"@
