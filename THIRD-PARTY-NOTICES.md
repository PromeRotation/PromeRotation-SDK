# 第三方组件声明

本仓库打包的是编译期引用程序集。第三方组件仍适用各自的上游许可证。

| 组件 | 包含文件 | 许可证 | 归属 / 说明 | 来源 |
| --- | --- | --- | --- | --- |
| Dalamud | `Dalamud.dll` | AGPL-3.0 | 本 API12 包使用 yanmucorp 维护的 API12 版本。goatcorp 为原上游项目。 | https://github.com/yanmucorp/Dalamud |
| ECommons | `ECommons.dll` | MIT | Copyright (c) 2023 NightmareXIV | https://github.com/NightmareXIV/ECommons |
| FFXIVClientStructs | `FFXIVClientStructs.dll` | MIT | Copyright (c) 2021-2023 aers | https://github.com/aers/FFXIVClientStructs |
| InteropGenerator.Runtime | `InteropGenerator.Runtime.dll` | MIT | 当前 API12 引用集中随 FFXIVClientStructs 工具链提供；替换 DLL 时需要重新核对上游归属。 | https://github.com/aers/FFXIVClientStructs |
| ImGui.NET | `ImGui.NET.dll` | MIT | Copyright (c) 2017 Eric Mellino and ImGui.NET contributors | https://github.com/goatcorp/ImGui.NET |
| Lumina | `Lumina.dll` | WTFPL-2.0 | NotAdam / Lumina contributors | https://github.com/NotAdam/Lumina |
| Lumina.Excel | `Lumina.Excel.dll` | WTFPL-2.0 | WorkingRobot, NotAdam / Lumina.Excel contributors | https://github.com/NotAdam/Lumina.Excel |

PromeRotation 自有程序集由 LICENSE.txt 覆盖：

- `PromeRotation.dll`
- `PromeRotation.Scripting.dll`

发布新的 SDK 包版本前，请重新核对每一个被替换 DLL 的来源、许可证和归属信息。
