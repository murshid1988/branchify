<#
.SYNOPSIS
Installs branchify for the current Windows user.

.DESCRIPTION
Downloads windows/branchify.ps1 to %LOCALAPPDATA%\branchify, adds a
"branchify.cmd" shim so it can be run as a bare command from cmd.exe or
PowerShell, and adds the install directory to the user PATH.
#>

$ErrorActionPreference = 'Stop'

$installDir = Join-Path $env:LOCALAPPDATA 'branchify'
New-Item -ItemType Directory -Force -Path $installDir | Out-Null

$scriptUrl = 'https://raw.githubusercontent.com/murshid1988/branchify/main/windows/branchify.ps1'
Invoke-WebRequest -Uri $scriptUrl -OutFile (Join-Path $installDir 'branchify.ps1')

$shimPath = Join-Path $installDir 'branchify.cmd'
$shimContent = "@echo off`r`npowershell -NoProfile -ExecutionPolicy Bypass -File `"%~dp0branchify.ps1`" %*`r`n"
Set-Content -Path $shimPath -Value $shimContent -Encoding ASCII -NoNewline

$userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
if ($userPath -notlike "*$installDir*") {
    $newPath = if ([string]::IsNullOrEmpty($userPath)) { $installDir } else { "$userPath;$installDir" }
    [Environment]::SetEnvironmentVariable('Path', $newPath, 'User')
    Write-Host "Added $installDir to your PATH."
}

Write-Host "branchify installed. Restart your terminal, then run: branchify `"Some Title`""
