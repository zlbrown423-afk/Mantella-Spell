# Generates the Spriggit YAML source for LWCoverEyes.esp into .\Plugin (same layout as LWAskLead\build_yaml.ps1).
$ErrorActionPreference = 'Stop'
$root = Join-Path $PSScriptRoot 'Plugin'
if (Test-Path $root) { Remove-Item $root -Recurse -Force }
$utf8 = New-Object Text.UTF8Encoding($false)
$M = 'LWCoverEyes.esp'

function Put($rel, $text) {
    $path = Join-Path $root $rel
    New-Item -ItemType Directory -Force (Split-Path $path) | Out-Null
    [IO.File]::WriteAllText($path, $text.Replace("`r`n", "`n"), $utf8)
}

$Quest  = "000800:$M"
$Effect = "000801:$M"
$Spell  = "000802:$M"
$AEffect = "000803:$M"
$ASpell  = "000804:$M"

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
  Description: 'Lesser powers: Cover Your Eyes (screen goes dark, sound keeps playing) and Arousal (Living World + The New Gentleman).'
  MasterReferences:
  - Master: Skyrim.esm
    FileSize: 0
  INTV: 1
"@

Put "MagicEffects\LWCoverEyes_Effect - 000801_$M.yaml" @"
FormKey: $Effect
EditorID: LWCoverEyes_Effect
VirtualMachineAdapter:
  Scripts:
  - Name: LWCoverEyes_Effect
    Properties:
    - MutagenObjectType: ScriptObjectProperty
      Name: Owner
      Object: $Quest
Name:
  TargetLanguage: English
  Value: Cover Your Eyes
MagicSkill: Alteration
Archetype:
  MutagenObjectType: MagicEffectArchetype
  Type: Script
CastType: FireAndForget
TargetType: Self
DualCastScale: 1
CastingSoundLevel: Silent
Sounds: []
Description:
  TargetLanguage: English
  Value: 'Cover your eyes: you see nothing but still hear everything. Cast again to look. Uncovers by itself after 30 seconds or when a fight starts.'
"@

Put "Spells\LWCoverEyes_Spell - 000802_$M.yaml" @"
FormKey: $Spell
EditorID: LWCoverEyes_Spell
Name:
  TargetLanguage: English
  Value: Cover Your Eyes
MenuDisplayObject: 10A046:Skyrim.esm
EquipmentType: 025BEE:Skyrim.esm
Description:
  TargetLanguage: English
  Value: ''
Type: LesserPower
CastType: FireAndForget
TargetType: Self
Effects:
- BaseEffect: $Effect
  Data:
    Duration: 1
"@

Put "MagicEffects\LWCoverEyes_ArousalEffect - 000803_$M.yaml" @"
FormKey: $AEffect
EditorID: LWCoverEyes_ArousalEffect
VirtualMachineAdapter:
  Scripts:
  - Name: LWCoverEyes_Arousal
    Properties:
    - MutagenObjectType: ScriptObjectProperty
      Name: Owner
      Object: $Quest
Name:
  TargetLanguage: English
  Value: Arousal
MagicSkill: Alteration
Archetype:
  MutagenObjectType: MagicEffectArchetype
  Type: Script
CastType: FireAndForget
TargetType: Self
DualCastScale: 1
CastingSoundLevel: Silent
Sounds: []
Description:
  TargetLanguage: English
  Value: 'Each cast: more aroused (visible, more, fully). Cast when fully aroused to calm down. Fades by itself after two minutes.'
"@

Put "Spells\LWCoverEyes_ArousalSpell - 000804_$M.yaml" @"
FormKey: $ASpell
EditorID: LWCoverEyes_ArousalSpell
Name:
  TargetLanguage: English
  Value: Arousal
MenuDisplayObject: 10A046:Skyrim.esm
EquipmentType: 025BEE:Skyrim.esm
Description:
  TargetLanguage: English
  Value: ''
Type: LesserPower
CastType: FireAndForget
TargetType: Self
Effects:
- BaseEffect: $AEffect
  Data:
    Duration: 1
"@

# Stays running: it holds whether the eyes are covered.
Put "Quests\LWCoverEyes_Quest - 000800_$M.yaml" @"
FormKey: $Quest
EditorID: LWCoverEyes_Quest
VirtualMachineAdapter:
  Scripts:
  - Name: LWCoverEyes_Quest
    Properties:
    - MutagenObjectType: ScriptObjectProperty
      Name: CoverEyes
      Object: $Spell
    - MutagenObjectType: ScriptObjectProperty
      Name: ArousalPower
      Object: $ASpell
  Versioning:
  - Break0
  ExtraBindDataVersion: 0
  FileName: ''
Flags:
- StartGameEnabled
- RunOnce
Priority: 10
"@
