# PromeRotation SDK

为 PromeRotation 插件、ACR、脚本、其他拓展开发提供 NuGet 打包配置及编译期 SDK 引用。

## 包列表

| 包名 | 状态 | 目标环境 |
| --- | --- | --- |
| `PromeRotation.SDK.API15` | 预留 | API15 包尚未制作 |
| `PromeRotation.SDK.API12` | 预览版 | .NET 9、Dalamud API 12、繁中服环境、PromeRotation API12 |

这些包只提供编译期引用程序集，不提供游戏运行时资产，也不能替代实际安装在游戏环境中的 Dalamud 或 PromeRotation。

## 仓库结构

- `PromeRotation.SDK.API12/`：API12 NuGet 包项目。
- `PromeRotation.SDK.API15/`：API15 包预留目录，目前只有占位说明。
- `licenses/`：第三方许可证文本。
- `THIRD-PARTY-NOTICES.md`：第三方组件来源和许可证说明。
