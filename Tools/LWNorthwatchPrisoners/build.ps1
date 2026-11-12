# Builds LWNorthwatchPrisoners on the play PC: Skyrim.esm -> LWNorthwatchPrisoners.esp (make_esp.py), then a
# Vortex-installable zip in Dist\. Reads the game's Data folder only.
$ErrorActionPreference = 'Stop'
$here     = $PSScriptRoot
$gameData = 'D:\SteamLibrary\steamapps\common\SkyrimVR\Data'
$python   = 'D:\ModdingTools\MantellaForks\venv\Scripts\python.exe'
$version  = '0.2.0'
if (!(Test-Path $python)) { $python = 'python' }

$stage = Join-Path $here "Dist\stage-$version"
New-Item -ItemType Directory -Force $stage | Out-Null
& $python -I (Join-Path $here 'make_esp.py') $gameData (Join-Path $stage 'LWNorthwatchPrisoners.esp')
if ($LASTEXITCODE -ne 0) { throw "make_esp.py failed ($LASTEXITCODE)" }

$zip = Join-Path $here "Dist\LWNorthwatchPrisoners-$version.zip"
if (Test-Path $zip) { Remove-Item $zip -Force }
Compress-Archive -Path "$stage\*" -DestinationPath $zip
Get-Item $zip | Select-Object FullName, Length
