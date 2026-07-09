<#
.SYNOPSIS
Uninstalls branchify for the current Windows user.
#>

$ErrorActionPreference = 'Stop'

$installDir = Join-Path $env:LOCALAPPDATA 'branchify'
Remove-Item -Recurse -Force $installDir -ErrorAction SilentlyContinue

$userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
if ($userPath) {
    $newPath = ($userPath -split ';' | Where-Object { $_ -and $_ -ne $installDir }) -join ';'
    [Environment]::SetEnvironmentVariable('Path', $newPath, 'User')
}

Write-Host "branchify uninstalled."
