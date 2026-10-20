# Codex Baili Midnight · 白璃深蓝玻璃主题

为 Windows Codex 的白璃动态背景搭配冷白文字、深蓝对话气泡和玻璃面板。

这是 [chenyi380/baili-codex](https://github.com/chenyi380/baili-codex) 的主题扩展，不是 OpenAI 官方主题。需要先安装白璃动画运行包；本仓库不包含影片、人物图像、音乐或 Codex 客户端。

## 效果

- 冷白正文、蓝灰辅助文字，配合深色背景。
- 深蓝用户消息气泡及渐变玻璃输入框。
- 冷蓝细描边、柔和聚焦光晕、半透明侧栏和工作面板。
- 设置卡片、权限提示、首页项目栏、下拉菜单与控件采用统一深蓝面板，适配新版背景颜色变量。
- 保留原版白璃片头、无文字动态背景、Esc 跳过及恢复原外观能力。
- 通过组件的语义属性匹配输入框，适配不再使用 form 的新版编辑器。

## 安装

1. 按 [白璃原项目](https://github.com/chenyi380/baili-codex) 的说明安装独立运行包和 **Codex · 白璃动画** 快捷方式。
2. 下载本仓库并解压。保存工作，完全退出 Codex，包括后台窗口。
3. 在 PowerShell 中运行，路径改成自己的白璃运行包目录：

```powershell
# 先检查安装计划，不写入文件
.\Install-Theme.ps1 -RuntimePath 'E:\Codex\Baili-Startup' -DryRun

# 安装主题并备份原 integration.mjs 和 config.json
.\Install-Theme.ps1 -RuntimePath 'E:\Codex\Baili-Startup'
```

脚本不安装依赖、不修改执行策略，不修改官方客户端文件，也不启动或结束 Codex。

从 **Codex · 白璃动画** 快捷方式启动。原官方入口保持原样。主题代码改变后，原启动器可能重新要求你阅读提示、亲自输入 `YES`；这是预期行为。不要复制其他人的授权文件。

背景强度可用 **Ctrl+Alt+B** 调整。深蓝主题固定使用冷白文字，不随系统浅色模式恢复成黑字。“菜单/输入框底色”滑块统一调节菜单、输入框、侧栏、工作面板和用户气泡的深蓝底色透明度；文字颜色保持不变。调节作用于当前会话，重新启动时读取 config.json 的 panelOpacity。

## 调试端口与恢复

原版白璃启动器会在已登录的 Codex 中开启仅监听 `127.0.0.1` 的调试端口。同机其他程序可能连接并控制客户端。恢复外观不会关闭端口；完全退出 Codex，再从官方图标启动才能关闭。首次交互授权和官方程序签名/监听器身份检查保持不变。

临时恢复：使用 **白璃 · 设置 → 恢复原外观**。

恢复原主题代码：完全退出 Codex，将运行目录 `theme-backups/<时间戳>/` 中的 `integration.mjs` 和 `config.json` 复制回运行目录，再通过原启动器启动。授权绑定可能再次改变。

## 验证与兼容性

在 Windows Codex `26.1013.4894.0`、白璃公开版 v11 上检查过当前页面的文字、侧栏、用户气泡、输入框与动态背景，并通过上游 7 项 safety 检查。尚未覆盖所有菜单、代码语言、终端、分屏和未来客户端版本。发布包未代替用户完成官方客户端冷启动授权。

## 来源与许可证

- 动画框架、运行时集成代码及原版媒体来自 [chenyi380/baili-codex](https://github.com/chenyi380/baili-codex)。本仓库保留原 MIT 许可证。
- 本仓库仅发布修改后的 `integration.mjs`、安装脚本与说明；不重新分发或重新许可原版媒体。
- 原版素材及音乐的说明见 [上游 ASSET-NOTICE.md](https://github.com/chenyi380/baili-codex/blob/main/ASSET-NOTICE.md)。
- OpenAI / Codex 是各自权利人的名称，本项目不代表其背书。
