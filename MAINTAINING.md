# API15 包维护说明

这个文件面向包维护者，不会打进 NuGet 包。

## 本地打包

生成后的 NuGet 包会输出到 `artifacts/` 目录。上传 NuGet.org 时请选择其中的 `.nupkg` 文件。

双击运行：

```bat
pack-api15.bat
```

默认行为：

1. **自动收集引用 DLL** 到 `refs/`：
   - 从国服卫月 `%APPDATA%\XIVLauncherCN\addon\Hooks\dev` 复制 11 个 Dalamud 生态程序集；
   - 从 `D:\.Dev\.PromeRotation\obfuscateOutput` 复制 **混淆后的** `PromeRotation.dll` 和 `PromeRotation.Scripting.dll`。
2. 把 `0.1.0-preview.1` 这类 preview 版本号自动递增到下一个版本。
3. 重新生成 `.nupkg`。

> 切记：PromeRotation 自有程序集取自 `obfuscateOutput`（混淆产物），**不是** `bin` 下的未混淆产物。

## 更新一次 API15 SDK 的完整流程

1. 在 PromeRotation 本体项目重新构建，并生成混淆产物到 `obfuscateOutput`。
2. 如需更新 Dalamud 生态程序集，确保国服卫月已更新到目标 API15 版本（`Hooks\dev` 会随卫月更新）。
3. 双击 `pack-api15.bat`。脚本会自动拉取最新 DLL、递增版本、打包。
4. 把 `artifacts/` 里新生成的 `.nupkg` 上传到 NuGet.org。
5. 提交版本号变更（csproj）和更新后的 `refs/*.dll`。

## 常用参数

手动指定版本：

```powershell
.\pack-api15.ps1 -Version 0.1.0-preview.2
```

只用当前版本重新打包（不递增）：

```powershell
.\pack-api15.ps1 -NoBump
```

跳过自动收集，直接用 `refs/` 里现有的 DLL：

```powershell
.\pack-api15.ps1 -NoCopy
```

自定义 DLL 来源路径（换机器或换目录时）：

```powershell
.\pack-api15.ps1 -DalamudDev "D:\path\to\Hooks\dev" -PrBin "D:\path\to\obfuscateOutput"
```

## 引用 DLL 清单

打进 `ref/net10.0-windows7.0/` 的程序集清单硬编码在 `pack-api15.ps1` 的 `$dalamudDlls` 和 `$prDlls` 数组里。这份 Dalamud 清单对齐 `Dalamud.CN.NET.Sdk` 15.0.0 硬编码的 `<Reference>` 集合。

如果 API15 升级后 Dalamud 生态的程序集集合发生变化（新增/移除/改名），需要同步更新这两个数组，并检查 `THIRD-PARTY-NOTICES.md` 和 `licenses/`。

## 与 API12 的差异

- TFM：`net10.0-windows7.0`（API12 是 `net9.0-windows7.0`）。
- 去掉了 `ImGui.NET.dll`，改为 `Dalamud.Bindings.ImGui/ImPlot/ImGuizmo.dll`。
- 新增 `Newtonsoft.Json.dll`、`Serilog.dll`、`Microsoft.Extensions.ObjectPool.dll`。
- ECommons 从打包改为 NuGet 依赖声明。
- pack 脚本新增自动收集 DLL 的逻辑（API12 需手动替换 `refs/`）。
