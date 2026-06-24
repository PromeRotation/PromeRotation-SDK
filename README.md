# PromeRotation.SDK.API12

`PromeRotation.SDK.API12` 为 PromeRotation 插件、ACR、脚本、其他拓展开发提供 API12 NuGet 打包配置及编译期 SDK 引用。

这个包面向中文开发者。安装后，即使本机没有安装繁中服卫月开发环境，也可以在项目中引用 PromeRotation、Dalamud、Lumina 等 API12 相关程序集完成编译。

## 目标环境

- .NET 9 / `net9.0-windows`
- Dalamud API 12
- 繁中服环境
- PromeRotation API12

其中 `Dalamud.dll` 来自 yanmucorp 维护的 API12 版本 Dalamud，而不是 goatcorp 上游主线版本。

## 使用方式

```xml
<ItemGroup>
  <PackageReference Include="PromeRotation.SDK.API12" Version="0.1.0-preview.1" />
</ItemGroup>
```

## 包内容

本包只包含 `ref/net9.0-windows7.0` 下的编译期引用程序集，不提供 `lib` 或 runtime 资产。实际运行仍依赖游戏环境中安装的 Dalamud、PromeRotation 和相关组件。

包含的引用程序集：

- `Dalamud.dll`
- `ECommons.dll`
- `FFXIVClientStructs.dll`
- `ImGui.NET.dll`
- `InteropGenerator.Runtime.dll`
- `Lumina.dll`
- `Lumina.Excel.dll`
- `PromeRotation.dll`
- `PromeRotation.Scripting.dll`

## 许可证和第三方组件

包许可说明见 `LICENSE.txt`。第三方组件来源和许可证见 `THIRD-PARTY-NOTICES.md`。

## 本地打包

生成后的 NuGet 包会输出到 `artifacts/` 目录。上传 NuGet.org 时请选择其中的 `.nupkg` 文件。

双击运行：

```bat
pack-api12.bat
```

默认会把 `0.1.0-preview.1` 这类 preview 版本号自动递增到下一个版本，并重新生成 `.nupkg`。

也可以手动指定版本：

```powershell
.\pack-api12.ps1 -Version 0.1.0-preview.2
```

如果只想使用当前版本重新打包：

```powershell
.\pack-api12.ps1 -NoBump
```

## 更新引用 DLL

更新 PromeRotation 或其他 API12 引用程序集时，替换 `refs/` 中同名 DLL，然后运行 `pack-api12.bat` 重新打包即可。

如果替换了第三方 DLL，请同时检查并更新 `THIRD-PARTY-NOTICES.md` 和 `licenses/` 中的许可证信息。
