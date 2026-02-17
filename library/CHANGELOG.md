# Changelog

All notable changes to this project will be documented in this file.

## [1.0.1] - 2026-02-18

### Added
- 新增 `headerBgColor` 主题配置字段，支持自定义分组标题背景颜色
- 新增权限说明字符串资源

### Changed
- 完善权限配置，添加 `reason` 和 `usedScene` 字段
- 优化 `isScrolling` 为 `@State` 响应式状态

### Fixed
- 添加 `BusinessError` 类型导入，完善类型定义
- 修正 `repository` URL 格式以兼容 OHPM 发布要求

## [1.0.0] - 2026-02-18

### Added
- 初始版本发布
- 支持中文标签的 Emoji 数据（3000+ Emoji）
- 分组展示（笑脸情感、人物身体、动物自然等）
- 快速定位分组Tab
- 浅色/深色模式适配
- 三种内置主题（默认/绿色/灰色）
- 支持自定义主题配置
- 支持自定义Emoji字体大小
- 支持自定义每行显示数量
- 选择触感反馈
- 粘性分组标题

### Fixed
- 修复分组标题被遮住问题
- 修复频繁定位时 Emoji 顺序混乱问题

### Note
- 注释了 Unicode 15.1 新增的"无叶树"Emoji，因部分设备不支持显示