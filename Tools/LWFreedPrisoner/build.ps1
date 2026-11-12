# Builds LWFreedPrisoner on the play PC: YAML -> ESP (Spriggit), .psc -> .pex (Papyrus Compiler), then a
# Vortex-installable zip in Dist\. Same tools and paths as LWSaloniaSurrender\build.ps1.
$ErrorActionPreference = 'Stop'
$here     = $PSScriptRoot
$name     = 'LWFreedPrisoner'
$spriggit = 'D:\ModdingTools\Spriggit\Spriggit.CLI.exe'
$compiler = 'C:\Program Files (x86)\Steam\steamapps\common\Skyrim Special Edition\Papyrus Compiler\PapyrusCompiler.exe'
$vanilla  = 'D:\ModdingTools\VanillaScripts\Source\Scripts'
$skseVR   = 'D:\SteamLibrary\steamapps\common\SkyrimVR\Data\Scripts\Source'
$version  = '0.1.0'

$env:DOTNET_ROOT = 'D:\ModdingTools\dotnet'
$env:PATH = "D:\ModdingTools\dotnet;$env:PATH"
$env:DOTNET_CLI_TELEMETRY_OPTOUT = '1'

& (Join-Path $here 'build_yaml.ps1') | Out-Null

$build = Join-Path $here 'Build'
New-Item -ItemType Directory -Force $build | Out-Null
& $spriggit deserialize -i (Join-Path $here 'Plugin') -o (Join-Path $build "$name.esp")
if ($LASTEXITCODE -ne 0) { throw "Spriggit failed ($LASTEXITCODE)" }

$src = Join-Path $here 'Source\Scripts'
$pex = Join-Path $here 'Scripts'
New-Item -ItemType Directory -Force $pex | Out-Null
Push-Location $env:TEMP
try {
    & $compiler (Join-Path $src 'LWFP_Quest.psc') "-f=$vanilla\TESV_Papyrus_Flags.flg" "-i=$src;$skseVR;$vanilla" "-o=$pex"
    if ($LASTEXITCODE -ne 0) { throw "Papyrus compile failed ($LASTEXITCODE)" }
} finally { Pop-Location }

$stage = Join-Path $here "Dist\stage-$version"
if (Test-Path $stage) { Remove-Item $stage -Recurse -Force }
New-Item -ItemType Directory -Force "$stage\Scripts\Source" | Out-Null
Copy-Item (Join-Path $build "$name.esp") $stage -Force
Copy-Item "$pex\LWFP_*.pex" "$stage\Scripts" -Force
Copy-Item "$src\LWFP_*.psc" "$stage\Scripts\Source" -Force
$zip = Join-Path $here "Dist\$name-$version.zip"
if (Test-Path $zip) { Remove-Item $zip -Force }
Compress-Archive -Path "$stage\*" -DestinationPath $zip
Get-Item $zip | Select-Object FullName, Length
