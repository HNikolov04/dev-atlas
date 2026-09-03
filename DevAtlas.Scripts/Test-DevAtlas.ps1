[CmdletBinding()]
param(
    [switch]$SkipUi
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$repositoryRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot ".."))
$backendRoot = Join-Path $repositoryRoot "DevAtlas"
$uiRoot = Join-Path $repositoryRoot "DevAtlas.UI"
$solution = Join-Path $backendRoot "DevAtlas.slnx"

function Invoke-Tool {
    param(
        [Parameter(Mandatory = $true)][string]$Command,
        [Parameter(Mandatory = $true)][string[]]$Arguments,
        [Parameter(Mandatory = $true)][string]$WorkingDirectory
    )

    $executable = Get-Command $Command -CommandType Application -ErrorAction Stop |
        Select-Object -First 1

    Push-Location $WorkingDirectory
    try {
        Write-Host ">> $Command $($Arguments -join ' ')" -ForegroundColor DarkGray
        & $executable.Source @Arguments | Out-Host

        if ($LASTEXITCODE -ne 0) {
            throw "$Command failed with exit code $LASTEXITCODE."
        }
    }
    finally {
        Pop-Location
    }
}

Invoke-Tool "dotnet" @("restore", $solution) $repositoryRoot
Invoke-Tool "dotnet" @("build", $solution, "--configuration", "Release", "--no-restore") $repositoryRoot
Invoke-Tool "dotnet" @("test", $solution, "--configuration", "Release", "--no-build") $repositoryRoot

if (-not $SkipUi) {
    Invoke-Tool "npm" @("run", "format:check") $uiRoot
    Invoke-Tool "npm" @("run", "lint") $uiRoot
    Invoke-Tool "npm" @("run", "test:ci") $uiRoot
    Invoke-Tool "npm" @("run", "build") $uiRoot
}
