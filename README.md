# PromeRotation SDK

这里存放 PromeRotation 的公开 SDK 编译引用包，用于在没有安装繁中服卫月开发环境的情况下编译 PromeRotation ACR 或扩展。

## 包列表

| 包名 | 状态 | 目标环境 |
| --- | --- | --- |
| `PromeRotation.SDK.API12` | 预览版 | .NET 9、Dalamud API 12、繁中服环境、PromeRotation API12 |
| `PromeRotation.SDK.API15` | 预留 | API15 包尚未制作 |

这些包只提供编译期引用程序集，不提供游戏运行时资产，也不能替代实际安装在游戏环境中的 Dalamud 或 PromeRotation。

## 仓库结构

- `PromeRotation.SDK.API12/`：API12 NuGet 包项目。
- `PromeRotation.SDK.API15/`：API15 包预留目录，目前只有占位说明。
- `licenses/`：第三方许可证文本。
- `THIRD-PARTY-NOTICES.md`：第三方组件来源和许可证说明。

生成的 `bin/`、`obj/`、`artifacts/` 目录不会提交到仓库。

## 分支规划

仓库可以维护长期分支，例如：

- `api12`：当前 API12 SDK 包。
- `api15`：未来 API15 SDK 包。

API15 尚未制作时，分支里应至少保留 README 或占位提交，明确说明该版本尚未发布。完全空目录无法被 Git 记录，也容易让使用者误以为内容遗漏。
