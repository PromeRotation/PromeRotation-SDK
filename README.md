# PromeRotation.SDK.API15

`PromeRotation.SDK.API15` 为 PromeRotation 插件、ACR、脚本、其他拓展开发提供 API15 NuGet 打包配置及编译期 SDK 引用。

这个包面向中文开发者。安装后，即使本机没有安装国服卫月开发环境，也可以在项目中引用 PromeRotation、Dalamud、Lumina 等 API15 相关程序集完成编译。

## 目标环境

- .NET 10 / `net10.0-windows`
- Dalamud API 15
- 国服（XIVLauncherCN）环境
- PromeRotation API15

其中 Dalamud 相关程序集来自国服（XIVLauncherCN）Dalamud 发行版，由 Dalamud-DailyRoutines 维护（fork 自 goatcorp/Dalamud），而不是 goatcorp 上游主线版本。

## 使用方式

本包为自包含引用包，**无需** `Dalamud.CN.NET.Sdk`。直接用标准 `Microsoft.NET.Sdk` 即可：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>net10.0-windows</TargetFramework>
    <AllowUnsafeBlocks>true</AllowUnsafeBlocks>
    <CopyLocalLockFileAssemblies>false</CopyLocalLockFileAssemblies>
  </PropertyGroup>
  <ItemGroup>
    <PackageReference Include="PromeRotation.SDK.API15" Version="0.1.0-preview.5" />
  </ItemGroup>
</Project>
```

装上这一个包即可编译，不需要再手写任何 `<Reference>` / `<HintPath>`：

- Dalamud、Lumina、ImGui 绑定、FFXIVClientStructs 等引用程序集包内已带；
- ECommons 会作为 NuGet 依赖（`3.2.0.3`）自动带上，无需单独声明；
- 本机是否安装国服卫月、PromeRotation 装在哪，都不影响编译。

> 与 `Dalamud.CN.NET.Sdk` 的区别：那个 SDK 要求本机存在国服卫月安装目录，否则构建报错；本包自带引用程序集，因此在没有卫月环境的机器和 GitHub Actions 上都能直接编译。

## 包内容

本包只包含 `ref/net10.0-windows7.0` 下的编译期引用程序集，不提供 `lib` 或 runtime 资产。实际运行仍依赖游戏环境中安装的 Dalamud、PromeRotation 和相关组件。

包含的引用程序集：

- `Dalamud.dll`
- `Dalamud.Bindings.ImGui.dll`
- `Dalamud.Bindings.ImPlot.dll`
- `Dalamud.Bindings.ImGuizmo.dll`
- `FFXIVClientStructs.dll`
- `InteropGenerator.Runtime.dll`
- `Newtonsoft.Json.dll`
- `Lumina.dll`
- `Lumina.Excel.dll`
- `Serilog.dll`
- `Microsoft.Extensions.ObjectPool.dll`
- `PromeRotation.dll`
- `PromeRotation.Scripting.dll`

通过 NuGet 依赖提供（不打进包）：

- `ECommons` `3.2.0.3`

## 许可证和第三方组件

包许可说明见 `LICENSE.txt`。第三方组件来源和许可证见 `THIRD-PARTY-NOTICES.md`。
