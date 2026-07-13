# 第三方组件声明

本仓库打包的是编译期引用程序集。第三方组件仍适用各自的上游许可证。

| 组件 | 包含文件 | 许可证 | 归属 / 说明 | 来源 |
| --- | --- | --- | --- | --- |
| Dalamud | `Dalamud.dll` | AGPL-3.0 | 本 API15 包使用国服（XIVLauncherCN）Dalamud 发行版，由 Dalamud-DailyRoutines 维护，fork 自 goatcorp/Dalamud 上游。 | https://github.com/Dalamud-DailyRoutines/Dalamud |
| Dalamud.Bindings.ImGui | `Dalamud.Bindings.ImGui.dll` | AGPL-3.0 | 随 Dalamud API15 发行版提供的 ImGui 绑定。 | https://github.com/Dalamud-DailyRoutines/Dalamud |
| Dalamud.Bindings.ImPlot | `Dalamud.Bindings.ImPlot.dll` | AGPL-3.0 | 随 Dalamud API15 发行版提供的 ImPlot 绑定。 | https://github.com/Dalamud-DailyRoutines/Dalamud |
| Dalamud.Bindings.ImGuizmo | `Dalamud.Bindings.ImGuizmo.dll` | AGPL-3.0 | 随 Dalamud API15 发行版提供的 ImGuizmo 绑定。 | https://github.com/Dalamud-DailyRoutines/Dalamud |
| FFXIVClientStructs | `FFXIVClientStructs.dll` | MIT | Copyright (c) 2021-2023 aers | https://github.com/aers/FFXIVClientStructs |
| InteropGenerator.Runtime | `InteropGenerator.Runtime.dll` | MIT | 随 FFXIVClientStructs 工具链提供；替换 DLL 时需要重新核对上游归属。 | https://github.com/aers/FFXIVClientStructs |
| Newtonsoft.Json | `Newtonsoft.Json.dll` | MIT | Copyright (c) 2007 James Newton-King | https://github.com/JamesNK/Newtonsoft.Json |
| Lumina | `Lumina.dll` | WTFPL-2.0 | NotAdam / Lumina contributors | https://github.com/NotAdam/Lumina |
| Lumina.Excel | `Lumina.Excel.dll` | WTFPL-2.0 | WorkingRobot, NotAdam / Lumina.Excel contributors | https://github.com/NotAdam/Lumina.Excel |
| Serilog | `Serilog.dll` | Apache-2.0 | Copyright Serilog Contributors | https://github.com/serilog/serilog |
| Microsoft.Extensions.ObjectPool | `Microsoft.Extensions.ObjectPool.dll` | MIT | Copyright (c) .NET Foundation and Contributors | https://github.com/dotnet/aspnetcore |

ECommons 通过 NuGet 依赖（`ECommons` 3.2.0.3）提供，不打进本包，其许可证（MIT，Copyright (c) 2023 NightmareXIV，https://github.com/NightmareXIV/ECommons）由 NuGet 包自身携带。

PromeRotation 自有程序集由 LICENSE.txt 覆盖：

- `PromeRotation.dll`
- `PromeRotation.Scripting.dll`

许可证全文见 `licenses/` 目录：Apache-2.0（Serilog）、MIT（FFXIVClientStructs、InteropGenerator.Runtime、Newtonsoft.Json、Microsoft.Extensions.ObjectPool、ECommons）、WTFPL-2.0（Lumina、Lumina.Excel）、AGPL-3.0（Dalamud 系列）。

发布新的 SDK 包版本前，请重新核对每一个被替换 DLL 的来源、许可证和归属信息。
