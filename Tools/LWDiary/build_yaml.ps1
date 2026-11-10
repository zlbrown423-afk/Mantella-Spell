# Generates the Spriggit YAML source for LWDiary.esp into .\Plugin (same layout as LWSitDown\build_yaml.ps1).
# The book's model and the tables a diary can lie on come from Skyrim.esm (vanilla.json, made by find_vanilla.py).
$ErrorActionPreference = 'Stop'
$root = Join-Path $PSScriptRoot 'Plugin'
if (Test-Path $root) { Remove-Item $root -Recurse -Force }
$utf8 = New-Object Text.UTF8Encoding($false)
$M = 'LWDiary.esp'

function Put($rel, $text) {
    $path = Join-Path $root $rel
    New-Item -ItemType Directory -Force (Split-Path $path) | Out-Null
    [IO.File]::WriteAllText($path, $text.Replace("`r`n", "`n"), $utf8)
}

$vanillaJson = Join-Path $PSScriptRoot 'vanilla.json'
if (!(Test-Path $vanillaJson)) { throw "vanilla.json is missing: run build.ps1 (it makes it with find_vanilla.py)" }
$vanilla = Get-Content $vanillaJson -Raw | ConvertFrom-Json
if (!$vanilla.book_model) { throw 'vanilla.json has no book model' }
if ($vanilla.tables.Count -eq 0) { throw 'vanilla.json lists no tables' }

$Quest  = "000800:$M"
$Book   = "000801:$M"
$Tables = "000802:$M"

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
  Description: 'Diaries for the people you spend time with (Living World build of Mantella).'
  MasterReferences:
  - Master: Skyrim.esm
    FileSize: 0
  INTV: 1
"@

$model = $vanilla.book_model.Replace("'", "''")
Put "Books\LWDiary_Book - 000801_$M.yaml" @"
FormKey: $Book
EditorID: LWDiary_Book
VirtualMachineAdapter:
  Scripts:
  - Name: LWDiary_Book
ObjectBounds:
  First: -7, -10, 0
  Second: 7, 10, 3
Name:
  TargetLanguage: English
  Value: Diary
Model:
  File: '$model'
BookText:
  TargetLanguage: English
  Value: '<p align="left">Page after page of small, private handwriting.<br><br>Close the book to read the newest entries.</p>'
Type: BookOrTome
Value: 5
Weight: 1
"@

$items = ($vanilla.tables | ForEach-Object { "- $($_.form_key)" }) -join "`n"
Put "FormLists\LWDiary_Tables - 000802_$M.yaml" @"
FormKey: $Tables
EditorID: LWDiary_Tables
Items:
$items
"@

Put "Quests\LWDiary_Quest - 000800_$M.yaml" @"
FormKey: $Quest
EditorID: LWDiary_Quest
VirtualMachineAdapter:
  Scripts:
  - Name: LWDiary_Quest
    Properties:
    - MutagenObjectType: ScriptObjectProperty
      Name: DiaryBook
      Object: $Book
    - MutagenObjectType: ScriptObjectProperty
      Name: Tables
      Object: $Tables
  Versioning:
  - Break0
  ExtraBindDataVersion: 0
  FileName: ''
Flags:
- StartGameEnabled
- RunOnce
Priority: 10
"@
