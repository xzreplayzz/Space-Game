param(
    [Parameter(Mandatory = $true)][string]$Godot,
    [string]$TemplatePath = ""
)
$ErrorActionPreference = 'Stop'
$projectPath = Join-Path $PSScriptRoot 'source'
$presetPath = Join-Path $projectPath 'export_presets.cfg'
$outputPath = Join-Path $PSScriptRoot 'build-0.7\Voidwake-0.7.exe'
New-Item -ItemType Directory -Path (Split-Path -Parent $outputPath) -Force | Out-Null
$original = [IO.File]::ReadAllText($presetPath)
try {
    if ($TemplatePath) {
        $template = (Resolve-Path -LiteralPath $TemplatePath).Path.Replace('\', '/')
        $updated = $original.Replace('custom_template/release=""', ('custom_template/release="' + $template + '"'))
        [IO.File]::WriteAllText($presetPath, $updated)
    }
    & $Godot --headless --path $projectPath --editor --import --quit
    if ($LASTEXITCODE -ne 0) { throw 'Godot import failed.' }
    & $Godot --headless --path $projectPath --export-release 'Windows Desktop' $outputPath
    if ($LASTEXITCODE -ne 0) { throw 'Godot export failed.' }
    Get-Item -LiteralPath $outputPath | Select-Object FullName, Length
} finally {
    [IO.File]::WriteAllText($presetPath, $original)
}
