param(
    [string]$Version,
    [switch]$NoBump,
    [switch]$KeepOldPackages,
    [switch]$NoCopy,
    [string]$DalamudDev = "$env:APPDATA\XIVLauncherCN\addon\Hooks\dev",
    [string]$PrBin = 'D:\.Dev\.PromeRotation\obfuscateOutput'
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$ProjectDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectPath = Join-Path $ProjectDir 'PromeRotation.SDK.API15.csproj'
$RefsDir = Join-Path $ProjectDir 'refs'
$ArtifactsDir = Join-Path $ProjectDir 'artifacts'

# 从国服卫月 Hooks/dev 目录取的 Dalamud 生态编译期引用程序集。
# 这份清单对齐 Dalamud.CN.NET.Sdk 15.0.0 硬编码的 <Reference> 集合。
$dalamudDlls = @(
    'Dalamud.dll',
    'Dalamud.Bindings.ImGui.dll',
    'Dalamud.Bindings.ImPlot.dll',
    'Dalamud.Bindings.ImGuizmo.dll',
    'FFXIVClientStructs.dll',
    'InteropGenerator.Runtime.dll',
    'Newtonsoft.Json.dll',
    'Lumina.dll',
    'Lumina.Excel.dll',
    'Serilog.dll',
    'Microsoft.Extensions.ObjectPool.dll'
)

# 从 PromeRotation 混淆产物取的自有程序集。切记：用 obfuscateOutput，不是 bin。
$prDlls = @(
    'PromeRotation.dll',
    'PromeRotation.Scripting.dll'
)

# 打进包的全部引用程序集（ECommons 走 NuGet 依赖，不在此列）。
$requiredDlls = $dalamudDlls + $prDlls

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

function Copy-Ref {
    param([string]$SourceDir, [string[]]$Names, [string]$Label)

    if (-not (Test-Path -LiteralPath $SourceDir)) {
        throw "$Label 源目录不存在：$SourceDir"
    }

    foreach ($name in $Names) {
        $src = Join-Path $SourceDir $name
        if (-not (Test-Path -LiteralPath $src)) {
            throw "$Label 源目录缺少 DLL：$name（在 $SourceDir）"
        }
        Copy-Item -LiteralPath $src -Destination (Join-Path $RefsDir $name) -Force
        Write-Host "  + $name  <-  $Label"
    }
}

Push-Location $ProjectDir
try {
    if (-not (Test-Path -LiteralPath $ProjectPath)) {
        throw "Project file not found: $ProjectPath"
    }

    New-Item -ItemType Directory -Force -Path $RefsDir | Out-Null

    if ($NoCopy) {
        Write-Host 'NoCopy: 跳过自动收集，直接使用 refs/ 现有 DLL。'
    }
    else {
        Write-Host "收集引用程序集到 refs/ ..."
        Write-Host "  Dalamud dev: $DalamudDev"
        Write-Host "  PR 混淆产物: $PrBin"
        Copy-Ref -SourceDir $DalamudDev -Names $dalamudDlls -Label 'Dalamud'
        Copy-Ref -SourceDir $PrBin -Names $prDlls -Label 'PR(混淆)'
        Write-Host ''
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

    Write-Host "PromeRotation.SDK.API15 $oldVersion -> $Version"
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

    $packagePath = Join-Path $ArtifactsDir "PromeRotation.SDK.API15.$Version.nupkg"
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
