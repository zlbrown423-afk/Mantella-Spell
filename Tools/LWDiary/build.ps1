# Builds LWDiary on the play PC: Skyrim.esm -> vanilla.json (book model, tables), YAML -> ESP (Spriggit),
# .psc -> .pex (Papyrus Compiler), then a Vortex-installable zip. Same tools and paths as LWSitDown\build.ps1.
$ErrorActionPreference = 'Stop'
$here     = $PSScriptRoot
$spriggit = 'D:\ModdingTools\Spriggit\Spriggit.CLI.exe'
$compiler = 'C:\Program Files (x86)\Steam\steamapps\common\Skyrim Special Edition\Papyrus Compiler\PapyrusCompiler.exe'
$vanilla  = 'D:\ModdingTools\VanillaScripts\Source\Scripts'
$gameData = 'D:\SteamLibrary\steamapps\common\SkyrimVR\Data'
$python   = 'D:\ModdingTools\MantellaForks\venv\Scripts\python.exe'
$version  = '0.1.0'
# ModEvent, StringUtil, Cell.GetNthRef (SKSE) and SKSE_HTTP (Mantella) are needed. SKSE's sources come from the
# game's Data folder when the vanilla set lacks them; SKSE_HTTP.psc comes from this repository.
$skse     = "$gameData\Scripts\Source"
$mantella = Join-Path $here '..\..\Scripts\Source'
$importList = @((Join-Path $here 'Source\Scripts'))
if (!(Test-Path "$vanilla\ModEvent.psc") -and (Test-Path "$skse\ModEvent.psc")) { $importList += $skse }
$importList += $vanilla
$imports  = ($importList -join ';') + ';' + (Resolve-Path $mantella).Path

$env:DOTNET_ROOT = 'D:\ModdingTools\dotnet'
$env:PATH = "D:\ModdingTools\dotnet;$env:PATH"
$env:DOTNET_CLI_TELEMETRY_OPTOUT = '1'

$vanillaJson = Join-Path $here 'vanilla.json'
if (!(Test-Path $vanillaJson)) {
    if (!(Test-Path $python)) { $python = 'python' }
    & $python -I (Join-Path $here 'find_vanilla.py') $gameData $vanillaJson
    if ($LASTEXITCODE -ne 0) { throw "find_vanilla.py failed ($LASTEXITCODE)" }
}

& (Join-Path $here 'build_yaml.ps1') | Out-Null

$build = Join-Path $here 'Build'
New-Item -ItemType Directory -Force $build | Out-Null
& $spriggit deserialize -i (Join-Path $here 'Plugin') -o (Join-Path $build 'LWDiary.esp')
if ($LASTEXITCODE -ne 0) { throw "Spriggit failed ($LASTEXITCODE)" }

$src = Join-Path $here 'Source\Scripts'
$pex = Join-Path $here 'Scripts'
New-Item -ItemType Directory -Force $pex | Out-Null
Push-Location $env:TEMP
try {
    foreach ($name in 'LWDiary_Book.psc', 'LWDiary_Quest.psc') {
        & $compiler (Join-Path $src $name) "-f=$vanilla\TESV_Papyrus_Flags.flg" "-i=$imports" "-o=$pex"
        if ($LASTEXITCODE -ne 0) { throw "Papyrus compile failed for $name ($LASTEXITCODE)" }
    }
} finally { Pop-Location }

$stage = Join-Path $here "Dist\stage-$version"
New-Item -ItemType Directory -Force "$stage\Scripts\Source" | Out-Null
Copy-Item (Join-Path $build 'LWDiary.esp') $stage -Force
Copy-Item "$pex\LWDiary_*.pex" "$stage\Scripts" -Force
Copy-Item "$src\LWDiary_*.psc" "$stage\Scripts\Source" -Force
$zip = Join-Path $here "Dist\LWDiary-$version.zip"
if (Test-Path $zip) { Remove-Item $zip -Force }
Compress-Archive -Path "$stage\*" -DestinationPath $zip
Get-Item $zip | Select-Object FullName, Length
