param(
    [string]$Version,
    [switch]$NoBump,
    [switch]$KeepOldPackages
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$ProjectDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectPath = Join-Path $ProjectDir 'PromeRotation.SDK.API12.csproj'
$RefsDir = Join-Path $ProjectDir 'refs'
$ArtifactsDir = Join-Path $ProjectDir 'artifacts'

$requiredDlls = @(
    'Dalamud.dll',
    'ECommons.dll',
    'FFXIVClientStructs.dll',
    'ImGui.NET.dll',
    'InteropGenerator.Runtime.dll',
    'Lumina.dll',
    'Lumina.Excel.dll',
    'PromeRotation.dll',
    'PromeRotation.Scripting.dll'
)

function Get-NextPreviewVersion {
    param([string]$CurrentVersion)

    if ($CurrentVersion -match '^(?<base>\d+\.\d+\.\d+)-preview\.(?<n>\d+)$') {
        return "$($Matches.base)-preview.$([int]$Matches.n + 1)"
    }

    if ($CurrentVersion -match '^(?<base>\d+\.\d+\.\d+)$') {
        return "$($Matches.base)-preview.1"
    }

    throw "Cannot auto-bump version '$CurrentVersion'. Use -Version explicitly, for example: -Version 0.1.0-preview.2"
}

Push-Location $ProjectDir
try {
    if (-not (Test-Path -LiteralPath $ProjectPath)) {
        throw "Project file not found: $ProjectPath"
    }

    foreach ($dll in $requiredDlls) {
        $path = Join-Path $RefsDir $dll
        if (-not (Test-Path -LiteralPath $path)) {
            throw "Required DLL missing from refs: $dll"
        }
    }

    [xml]$project = Get-Content -LiteralPath $ProjectPath -Encoding UTF8
    $versionNode = $project.Project.PropertyGroup.Version | Select-Object -First 1
    if ([string]::IsNullOrWhiteSpace($versionNode)) {
        throw 'No <Version> found in csproj.'
    }

    $oldVersion = [string]$versionNode
    if ([string]::IsNullOrWhiteSpace($Version)) {
        if ($NoBump) {
            $Version = $oldVersion
        }
        else {
            $Version = Get-NextPreviewVersion -CurrentVersion $oldVersion
        }
    }

    if ($Version -notmatch '^\d+\.\d+\.\d+([-.][0-9A-Za-z][0-9A-Za-z.-]*)?$') {
        throw "Version '$Version' does not look like a valid NuGet SemVer."
    }

    if ($Version -ne $oldVersion) {
        $project.Project.PropertyGroup.Version = $Version
        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        $settings = New-Object System.Xml.XmlWriterSettings
        $settings.Encoding = $utf8NoBom
        $settings.Indent = $true
        $settings.NewLineChars = "`r`n"
        $writer = [System.Xml.XmlWriter]::Create($ProjectPath, $settings)
        try {
            $project.Save($writer)
        }
        finally {
            $writer.Dispose()
        }
    }

    New-Item -ItemType Directory -Force -Path $ArtifactsDir | Out-Null
    if (-not $KeepOldPackages) {
        Get-ChildItem -LiteralPath $ArtifactsDir -Filter '*.nupkg' -File -ErrorAction SilentlyContinue |
            Remove-Item -Force
    }

    Write-Host "PromeRotation.SDK.API12 $oldVersion -> $Version"
    Write-Host 'Restoring...'
    dotnet restore --ignore-failed-sources
    if ($LASTEXITCODE -ne 0) {
        throw "dotnet restore failed with exit code $LASTEXITCODE"
    }

    Write-Host 'Packing...'
    dotnet pack -c Release --no-build
    if ($LASTEXITCODE -ne 0) {
        throw "dotnet pack failed with exit code $LASTEXITCODE"
    }

    $packagePath = Join-Path $ArtifactsDir "PromeRotation.SDK.API12.$Version.nupkg"
    if (-not (Test-Path -LiteralPath $packagePath)) {
        throw "打包结束，但没有找到预期包文件：$packagePath"
    }

    Write-Host ''
    Write-Host 'Done. Upload this file to NuGet.org:'
    Write-Host $packagePath
}
finally {
    Pop-Location
}
