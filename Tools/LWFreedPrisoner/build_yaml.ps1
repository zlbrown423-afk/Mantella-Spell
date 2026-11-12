# Generates the Spriggit YAML source for LWFreedPrisoner.esp into .\Plugin.
# Record formats copied from LWSaloniaSurrender 0.4.1 (built and run on the play PC): the stay-home sandbox
# package (vanilla Sandbox template 01C254), the house cells and the door markers in Whiterun and the other holds.
$ErrorActionPreference = 'Stop'
$root = Join-Path $PSScriptRoot 'Plugin'
if (Test-Path $root) { Remove-Item $root -Recurse -Force }
$utf8 = New-Object Text.UTF8Encoding($false)
$M = 'LWFreedPrisoner.esp'

function Put($rel, $text) {
    $path = Join-Path $root $rel
    New-Item -ItemType Directory -Force (Split-Path $path) | Out-Null
    [IO.File]::WriteAllText($path, $text.Replace("`r`n", "`n"), $utf8)
}

$Quest = "000800:$M"
$GOn = "000801:$M"
$GStayHome = "000802:$M"
$PStay = "000810:$M"

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
  Description: The freed Northwatch prisoner follows you with Mantella and waits in Whiterun (inn by day, your house by night) when you let her go.
  MasterReferences:
  - Master: Skyrim.esm
    FileSize: 0
  - Master: Mantella.esp
    FileSize: 0
  INTV: 1
"@

Put "Globals\LWFP_On - 000801_$M.yaml" @"
MutagenObjectType: GlobalShort
FormKey: $GOn
EditorID: LWFP_On
Data: 1
"@

Put "Globals\LWFP_StayHome - 000802_$M.yaml" @"
MutagenObjectType: GlobalShort
FormKey: $GStayHome
EditorID: LWFP_StayHome
Data: 0
"@

$sandboxBools = @(@(14, $false), @(1, $true), @(3, $true), @(4, $true), @(5, $true), @(6, $true), @(31, $true), @(7, $true), @(25, $false), @(27, $false))
$boolYaml = ($sandboxBools | ForEach-Object {
    $line = "- Key: $($_[0])`n  Value:`n    MutagenObjectType: PackageDataBool"
    if ($_[1]) { $line += "`n    Data: True" }
    $line
}) -join "`n"

Put "Packages\LWFP_StayPkg - 000810_$M.yaml" @"
FormKey: $PStay
EditorID: LWFP_StayPkg
Flags:
- PreferredSpeed
Type: Package
PreferredSpeed: Walk
InterruptFlags:
- ObserveCombatBehavior
- GreetCorpseBehavior
- ReactionToPlayerActions
- FriendlyFireComments
- AggroRadiusBehavior
- WorldInteractions
- 0x400
- 0x800
- 0x1000
- 0x2000
- 0x4000
- 0x8000
ScheduleMonth: -1
ScheduleDayOfWeek: Any
ScheduleHour: -1
ScheduleMinute: -1
Unknown3: 0x000000
Conditions:
- MutagenObjectType: ConditionFloat
  Data:
    MutagenObjectType: GetGlobalValueConditionData
    Global: $GStayHome
  ComparisonValue: 1
OwnerQuest: $Quest
PackageTemplate: 01C254:Skyrim.esm
DataInputVersion: 32
Data:
- Key: 0
  Value:
    MutagenObjectType: PackageDataLocation
    Location:
      Target:
        MutagenObjectType: LocationFallback
        Type: AliasForReference
        Data: 1
      Radius: 1500
$boolYaml
- Key: 29
  Value:
    MutagenObjectType: PackageDataFloat
    Data: 50
XnamMarker: 0x20
OnBegin:
  Topics:
  - MutagenObjectType: TopicReference
OnEnd:
  Topics:
  - MutagenObjectType: TopicReference
OnChange:
  Topics:
  - MutagenObjectType: TopicReference
"@

$props = @(
    @('PrisonerAlias', $Quest, '0'),
    @('HomeAlias', $Quest, '1'),
    @('LWFP_On', $GOn),
    @('LWFP_StayHome', $GStayHome),
    @('FollowingFaction', '003806:Mantella.esp'),
    @('PlayerFaction', '000DB1:Skyrim.esm'),
    @('HouseWhiterun', '0165A8:Skyrim.esm'),
    @('HouseSolitude', '016A06:Skyrim.esm'),
    @('HouseRiften', '016BDD:Skyrim.esm'),
    @('HouseMarkarth', '016DFA:Skyrim.esm'),
    @('HouseWindhelm', '016778:Skyrim.esm'),
    @('MarkerWhiterun', '01F88E:Skyrim.esm'),
    @('MarkerSolitude', '020097:Skyrim.esm'),
    @('MarkerRiften', '102BE4:Skyrim.esm'),
    @('MarkerMarkarth', '01F323:Skyrim.esm'),
    @('MarkerWindhelm', '0209D6:Skyrim.esm'),
    @('MarkerBanneredMare', '01F88C:Skyrim.esm')
) | ForEach-Object {
    $s = "    - MutagenObjectType: ScriptObjectProperty`n      Name: $($_[0])`n      Object: $($_[1])"
    if ($_.Count -gt 2) { $s += "`n      Alias: $($_[2])" }
    $s
}

Put "Quests\LWFP_Quest - 000800_$M.yaml" @"
FormKey: $Quest
EditorID: LWFP_Quest
VirtualMachineAdapter:
  Scripts:
  - Name: LWFP_Quest
    Properties:
$([string]::Join("`n", $props))
  FileName: ''
Flags:
- StartGameEnabled
Priority: 60
NextAliasID: 2
Aliases:
- Name: Prisoner
  Flags:
  - AllowReserved
  ForcedReference: 0C1AA4:Skyrim.esm
  PackageData:
  - $PStay
  VoiceTypes: Null
- ID: 1
  Name: Home
  Flags:
  - Optional
  - AllowReserved
  VoiceTypes: Null
"@

Get-ChildItem $root -Recurse -File | ForEach-Object { $_.FullName.Substring($root.Length + 1) }
