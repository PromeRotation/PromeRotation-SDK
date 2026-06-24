# PromeRotation SDK API15

为 PromeRotation 插件、ACR、脚本、其他拓展开发提供 API15 NuGet 打包配置及编译期 SDK 引用。

目前 API15 SDK 包尚未制作，因此本分支只保留基础仓库配置和占位说明，不包含任何 API15 引用程序集，也不会生成 API15 NuGet 包。

API12 SDK 内容请查看 `api12` 分支。

## 当前内容

- `PromeRotation.SDK.API15/README.md`：API15 占位说明。
- `.gitignore` / `.gitattributes`：仓库基础配置。
- `LICENSE.txt`：PromeRotation SDK 二进制引用包许可说明。

当 API15 引用程序集准备好后，再在本分支添加 `PromeRotation.SDK.API15` 包项目、`refs/` DLL、第三方组件声明和对应许可证文件。
