# Generates the Spriggit YAML source for LWToneWheel.esp into .\Plugin (same layout as LWCoverEyes\build_yaml.ps1).
# Eight lesser powers, "Tone: Friendly" ... "Tone: Neutral". Each has its own magic effect named after the tone;
# one shared script (LWToneWheel_Effect) sends that name to Mantella. Powers sit in the voice slot, so picking one
# on the Spell Wheel does not take a weapon or spell out of either hand.
$ErrorActionPreference = 'Stop'
$root = Join-Path $PSScriptRoot 'Plugin'
if (Test-Path $root) { Remove-Item $root -Recurse -Force }
$utf8 = New-Object Text.UTF8Encoding($false)
$M = 'LWToneWheel.esp'

function Put($rel, $text) {
    $path = Join-Path $root $rel
    New-Item -ItemType Directory -Force (Split-Path $path) | Out-Null
    [IO.File]::WriteAllText($path, $text.Replace("`r`n", "`n"), $utf8)
}

$Quest = "000800:$M"

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
  Description: 'Tone wheel: lesser powers to pick the tone of voice you mean. NPCs (Living World Mantella) judge it against how your voice really sounds.'
  MasterReferences:
  - Master: Skyrim.esm
    FileSize: 0
  INTV: 1
"@

# tone name, magic effect form id, spell form id, description
$tones = @(
    @('Friendly', '000801', '000802', 'Speak warmly: NPCs judge whether your voice sounds friendly.'),
    @('Polite', '000803', '000804', 'Speak courteously: NPCs judge whether your voice sounds polite.'),
    @('Flirty', '000805', '000806', 'Speak playfully: NPCs judge whether your voice sounds flirtatious.'),
    @('Stern', '000807', '000808', 'Speak firmly: NPCs judge whether your voice carries authority.'),
    @('Threatening', '000809', '00080A', 'Speak menacingly: NPCs judge whether your voice sounds like a real threat or a bluff.'),
    @('Sarcastic', '00080B', '00080C', 'Speak sarcastically: NPCs judge whether the sarcasm comes across.'),
    @('Pleading', '00080D', '00080E', 'Speak pleadingly: NPCs judge whether your voice sounds heartfelt.'),
    @('Neutral', '00080F', '000810', 'Back to your own voice: no tone picked.')
)

$props = ''
foreach ($t in $tones) {
    $name = $t[0]; $fx = "$($t[1]):$M"; $sp = "$($t[2]):$M"; $desc = $t[3]

    # Not hostile, no sound, no visuals: only the script runs.
    Put "MagicEffects\LWToneWheel_$($name)Effect - $($t[1])_$M.yaml" @"
FormKey: $fx
EditorID: LWToneWheel_$($name)Effect
VirtualMachineAdapter:
  Scripts:
  - Name: LWToneWheel_Effect
Name:
  TargetLanguage: English
  Value: $name
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
TargetType: Self
DualCastScale: 1
CastingSoundLevel: Silent
Sounds: []
Description:
  TargetLanguage: English
  Value: '$desc'
"@

    Put "Spells\LWToneWheel_$name - $($t[2])_$M.yaml" @"
FormKey: $sp
EditorID: LWToneWheel_$name
Name:
  TargetLanguage: English
  Value: 'Tone: $name'
MenuDisplayObject: 10A046:Skyrim.esm
EquipmentType: 025BEE:Skyrim.esm
Description:
  TargetLanguage: English
  Value: ''
Type: LesserPower
CastType: FireAndForget
TargetType: Self
Effects:
- BaseEffect: $fx
  Data:
    Duration: 1
"@

    $props += @"

    - MutagenObjectType: ScriptObjectProperty
      Name: Tone$name
      Object: $sp
"@
}

Put "Quests\LWToneWheel_Quest - 000800_$M.yaml" @"
FormKey: $Quest
EditorID: LWToneWheel_Quest
VirtualMachineAdapter:
  Scripts:
  - Name: LWToneWheel_Quest
    Properties:$props
  Versioning:
  - Break0
  ExtraBindDataVersion: 0
  FileName: ''
Flags:
- StartGameEnabled
- RunOnce
Priority: 10
"@

Get-ChildItem $root -Recurse -File | ForEach-Object { $_.FullName.Substring($root.Length + 1) }
