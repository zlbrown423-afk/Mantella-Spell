# Builds LWGuardDuty on the play PC: YAML -> ESP (Spriggit), .psc -> .pex (Papyrus Compiler), then a
# Vortex-installable zip. Same tools and paths as LWDiary\build.ps1. The plugin's YAML is kept as it is in
# .\Plugin (no vanilla lookups needed, so there is no build_yaml.ps1).
$ErrorActionPreference = 'Stop'
$here     = $PSScriptRoot
$spriggit = 'D:\ModdingTools\Spriggit\Spriggit.CLI.exe'
$compiler = 'C:\Program Files (x86)\Steam\steamapps\common\Skyrim Special Edition\Papyrus Compiler\PapyrusCompiler.exe'
$vanilla  = 'D:\ModdingTools\VanillaScripts\Source\Scripts'
$gameData = 'D:\SteamLibrary\steamapps\common\SkyrimVR\Data'
$version  = '0.1.0'
# ModEvent and ObjectReference.SetDisplayName (SKSE) are needed: SKSE's sources come from the game's Data folder
# when the vanilla set lacks them.
$skse     = "$gameData\Scripts\Source"
$importList = @((Join-Path $here 'Source\Scripts'))
if (!(Test-Path "$vanilla\ModEvent.psc") -and (Test-Path "$skse\ModEvent.psc")) { $importList += $skse }
$importList += $vanilla
$imports  = $importList -join ';'

$env:DOTNET_ROOT = 'D:\ModdingTools\dotnet'
$env:PATH = "D:\ModdingTools\dotnet;$env:PATH"
$env:DOTNET_CLI_TELEMETRY_OPTOUT = '1'

$build = Join-Path $here 'Build'
New-Item -ItemType Directory -Force $build | Out-Null
& $spriggit deserialize -i (Join-Path $here 'Plugin') -o (Join-Path $build 'LWGuardDuty.esp')
if ($LASTEXITCODE -ne 0) { throw "Spriggit failed ($LASTEXITCODE)" }

$src = Join-Path $here 'Source\Scripts'
$pex = Join-Path $here 'Scripts'
New-Item -ItemType Directory -Force $pex | Out-Null
Push-Location $env:TEMP
try {
    & $compiler (Join-Path $src 'LWGuardDuty_Quest.psc') "-f=$vanilla\TESV_Papyrus_Flags.flg" "-i=$imports" "-o=$pex"
    if ($LASTEXITCODE -ne 0) { throw "Papyrus compile failed for LWGuardDuty_Quest.psc ($LASTEXITCODE)" }
} finally { Pop-Location }

$stage = Join-Path $here "Dist\stage-$version"
New-Item -ItemType Directory -Force "$stage\Scripts\Source" | Out-Null
Copy-Item (Join-Path $build 'LWGuardDuty.esp') $stage -Force
Copy-Item "$pex\LWGuardDuty_*.pex" "$stage\Scripts" -Force
Copy-Item "$src\LWGuardDuty_*.psc" "$stage\Scripts\Source" -Force
$zip = Join-Path $here "Dist\LWGuardDuty-$version.zip"
if (Test-Path $zip) { Remove-Item $zip -Force }
Compress-Archive -Path "$stage\*" -DestinationPath $zip
Get-Item $zip | Select-Object FullName, Length
