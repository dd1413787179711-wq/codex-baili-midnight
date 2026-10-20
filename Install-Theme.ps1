[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)][string]$RuntimePath,
    [switch]$DryRun
)
$ErrorActionPreference = 'Stop'
$runtime = (Resolve-Path -LiteralPath $RuntimePath).Path
$source = Join-Path $PSScriptRoot 'integration.mjs'
if (-not (Test-Path -LiteralPath $source -PathType Leaf)) { throw 'Theme integration.mjs is missing.' }
foreach ($required in @('launcher.mjs','consent.mjs','platform.ps1','cdp.mjs','film.mjs','work-films.mjs','config.json','integration.mjs')) {
    if (-not (Test-Path -LiteralPath (Join-Path $runtime $required) -PathType Leaf)) { throw "Not a compatible Baili runtime: missing $required" }
}
$configPath = Join-Path $runtime 'config.json'
$config = Get-Content -LiteralPath $configPath -Raw | ConvertFrom-Json
if ($config.wallpaperFile -ne 'wallpaper.mp4') { throw 'Unsupported wallpaper configuration; no files changed.' }
$target = Join-Path $runtime 'integration.mjs'
if ([string]::Equals((Resolve-Path -LiteralPath $source).Path,$target,[StringComparison]::OrdinalIgnoreCase)) { throw 'Extract the theme separately from the runtime directory.' }
$plan = [pscustomobject]@{ Runtime = $runtime; Replace = $target; EnableDynamicBackground = $true; DryRun = [bool]$DryRun }
if ($DryRun) { $plan; return }
$backup = Join-Path (Join-Path $runtime 'theme-backups') ([DateTime]::Now.ToString('yyyyMMdd-HHmmss-fff'))
New-Item -ItemType Directory -Path $backup -ErrorAction Stop | Out-Null
Copy-Item -LiteralPath $target -Destination (Join-Path $backup 'integration.mjs')
Copy-Item -LiteralPath $configPath -Destination (Join-Path $backup 'config.json')
try {
    Copy-Item -LiteralPath $source -Destination $target -Force
    $config | Add-Member -NotePropertyName startupOnly -NotePropertyValue $false -Force
    $config | Add-Member -NotePropertyName panelOpacity -NotePropertyValue 0.8 -Force
    $config | Add-Member -NotePropertyName backgroundStrength -NotePropertyValue 1.0 -Force
    $configJson = $config | ConvertTo-Json -Depth 20
    [IO.File]::WriteAllText($configPath,$configJson,[Text.UTF8Encoding]::new($false))
} catch {
    Copy-Item -LiteralPath (Join-Path $backup 'integration.mjs') -Destination $target -Force
    Copy-Item -LiteralPath (Join-Path $backup 'config.json') -Destination $configPath -Force
    throw
}
Write-Output "Installed. Backup: $backup"
Write-Output 'Save work and fully exit Codex, then launch using the Baili shortcut. Personally confirm YES if requested.'
