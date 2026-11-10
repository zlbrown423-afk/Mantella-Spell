# Builds LWCoverEyes on the play PC: YAML -> ESP (Spriggit), .psc -> .pex (Papyrus Compiler), then a
# Vortex-installable zip. Same tools and paths as D:\ModdingTools\LWAskLead\build.ps1.
$ErrorActionPreference = 'Stop'
$here     = $PSScriptRoot
$spriggit = 'D:\ModdingTools\Spriggit\Spriggit.CLI.exe'
$compiler = 'C:\Program Files (x86)\Steam\steamapps\common\Skyrim Special Edition\Papyrus Compiler\PapyrusCompiler.exe'
$vanilla  = 'D:\ModdingTools\VanillaScripts\Source\Scripts'
$version  = '0.1.0'
$imports  = @((Join-Path $here 'Source\Scripts'), $vanilla) -join ';'

$env:DOTNET_ROOT = 'D:\ModdingTools\dotnet'
$env:PATH = "D:\ModdingTools\dotnet;$env:PATH"
$env:DOTNET_CLI_TELEMETRY_OPTOUT = '1'

& (Join-Path $here 'build_yaml.ps1') | Out-Null

$build = Join-Path $here 'Build'
New-Item -ItemType Directory -Force $build | Out-Null
& $spriggit deserialize -i (Join-Path $here 'Plugin') -o (Join-Path $build 'LWCoverEyes.esp')
if ($LASTEXITCODE -ne 0) { throw "Spriggit failed ($LASTEXITCODE)" }

$src = Join-Path $here 'Source\Scripts'
$pex = Join-Path $here 'Scripts'
New-Item -ItemType Directory -Force $pex | Out-Null
Push-Location $env:TEMP
try {
    # the quest script first: the effect script's property is of its type
    foreach ($name in 'LWCoverEyes_Quest.psc', 'LWCoverEyes_Effect.psc') {
        & $compiler (Join-Path $src $name) "-f=$vanilla\TESV_Papyrus_Flags.flg" "-i=$imports" "-o=$pex"
        if ($LASTEXITCODE -ne 0) { throw "Papyrus compile failed for $name ($LASTEXITCODE)" }
    }
} finally { Pop-Location }

$stage = Join-Path $here "Dist\stage-$version"
New-Item -ItemType Directory -Force "$stage\Scripts\Source" | Out-Null
Copy-Item (Join-Path $build 'LWCoverEyes.esp') $stage -Force
Copy-Item "$pex\LWCoverEyes_*.pex" "$stage\Scripts" -Force
Copy-Item "$src\LWCoverEyes_*.psc" "$stage\Scripts\Source" -Force
$zip = Join-Path $here "Dist\LWCoverEyes-$version.zip"
if (Test-Path $zip) { Remove-Item $zip -Force }
Compress-Archive -Path "$stage\*" -DestinationPath $zip
Get-Item $zip | Select-Object FullName, Length
