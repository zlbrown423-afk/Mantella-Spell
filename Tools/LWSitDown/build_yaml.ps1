# Generates the Spriggit YAML source for LWSitDown.esp into .\Plugin (same layout as LWCoverEyes\build_yaml.ps1).
$ErrorActionPreference = 'Stop'
$root = Join-Path $PSScriptRoot 'Plugin'
if (Test-Path $root) { Remove-Item $root -Recurse -Force }
$utf8 = New-Object Text.UTF8Encoding($false)
$M = 'LWSitDown.esp'

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
  Author: Living World
  Description: 'A spell that makes the NPC you cast it at sit down in a chair nearby. Cast at someone sitting to make them stand.'
  MasterReferences:
  - Master: Skyrim.esm
    FileSize: 0
  INTV: 1
"@

# Not hostile and not detrimental: the target is not angered and nobody calls it an attack.
Put "MagicEffects\LWSitDown_Effect - 000801_$M.yaml" @"
FormKey: $Effect
EditorID: LWSitDown_Effect
VirtualMachineAdapter:
  Scripts:
  - Name: LWSitDown_Effect
Name:
  TargetLanguage: English
  Value: Sit Down
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
  Value: 'The person you cast this at sits down in the chair, bench or stool you pointed at, or the nearest free one. Cast it at someone sitting to make them stand up.'
"@

Put "Spells\LWSitDown_Spell - 000802_$M.yaml" @"
FormKey: $Spell
EditorID: LWSitDown_Spell
Name:
  TargetLanguage: English
  Value: Sit Down
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

Put "Quests\LWSitDown_Quest - 000800_$M.yaml" @"
FormKey: $Quest
EditorID: LWSitDown_Quest
VirtualMachineAdapter:
  Scripts:
  - Name: LWSitDown_Quest
    Properties:
    - MutagenObjectType: ScriptObjectProperty
      Name: SitDown
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
