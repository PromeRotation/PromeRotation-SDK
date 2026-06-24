# API12 包维护说明

这个文件面向包维护者，不会打进 NuGet 包。

## 本地打包

生成后的 NuGet 包会输出到 `artifacts/` 目录。上传 NuGet.org 时请选择其中的 `.nupkg` 文件。

双击运行：

```bat
pack-api12.bat
```

默认会把 `0.1.0-preview.2` 这类 preview 版本号自动递增到下一个版本，并重新生成 `.nupkg`。

也可以手动指定版本：

```powershell
.\pack-api12.ps1 -Version 0.1.0-preview.3
```

如果只想使用当前版本重新打包：

```powershell
.\pack-api12.ps1 -NoBump
```

## 更新引用 DLL

更新 PromeRotation 或其他 API12 引用程序集时，替换 `refs/` 中同名 DLL，然后运行 `pack-api12.bat` 重新打包即可。

如果替换了第三方 DLL，请同时检查并更新 `THIRD-PARTY-NOTICES.md` 和 `licenses/` 中的许可证信息。
