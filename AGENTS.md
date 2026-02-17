# EmojiPicker - HarmonyOS Emoji 选择器组件

## 项目概述

这是一个 HarmonyOS 平台的 Emoji 选择器组件库 (`@kelegele/emoji-picker`)，支持中文标签和主题配色。项目采用 ArkTS/ArkUI 原生开发，已发布到 OHPM 中心仓。

### 主要特性

- 🎨 **多主题支持** - 内置默认/绿色/灰色三种主题，支持自定义主题配置
- 🇨🇳 **中文标签** - 所有 3000+ Emoji 均有中文描述
- 📱 **分组展示** - 按类别分组（笑脸情感、人物身体、动物自然等），支持快速定位
- ✨ **触感反馈** - 选择时提供震动反馈
- 🔧 **高度可配置** - Emoji 大小、每行数量等均可自定义
- 🌓 **深浅色模式** - 自动适配浅色/深色模式

### 技术栈

- **平台**: HarmonyOS SDK 6.0.2 (API 20)
- **语言**: ArkTS (TypeScript 超集)
- **UI 框架**: ArkUI 声明式 UI
- **构建工具**: Hvigor
- **包管理**: OHPM (OpenHarmony Package Manager)

## 项目结构

```
EmojiPicker/
├── AppScope/                    # 应用全局配置
│   ├── app.json5               # 应用配置（bundleName、版本等）
│   └── resources/              # 全局资源
├── entry/                       # 示例应用入口模块
│   └── src/main/
│       ├── ets/pages/          # 示例页面
│       └── resources/          # 入口模块资源
├── library/                     # 核心组件库（HAR）
│   ├── Index.ets               # 库导出入口
│   ├── src/main/
│   │   ├── ets/
│   │   │   ├── components/
│   │   │   │   └── Picker.ets  # 核心选择器组件
│   │   │   ├── models/
│   │   │   │   ├── EmojiModel.ets      # Emoji 数据模型
│   │   │   │   └── EmojiPickerTheme.ets # 主题配置
│   │   │   └── data/
│   │   │       └── EmojiData.ets       # Emoji 数据源
│   │   └── resources/
│   │       ├── base/element/   # 基础资源（颜色、字符串）
│   │       ├── dark/element/   # 深色模式资源
│   │       └── rawfile/
│   │           └── emoji_251223.json    # Emoji JSON 数据
│   ├── README.md               # 库使用文档
│   └── CHANGELOG.md            # 变更日志
├── build-profile.json5          # 构建配置
├── oh-package.json5            # 项目依赖配置
└── hvigor/                     # Hvigor 构建配置
```

## 构建命令

### 同步项目
```bash
/Applications/DevEco-Studio.app/Contents/tools/node/bin/node /Applications/DevEco-Studio.app/Contents/tools/hvigor/bin/hvigorw.js --sync -p product=default --analyze=normal --parallel --incremental --daemon
```

### 构建 HAR 库
```bash
/Applications/DevEco-Studio.app/Contents/tools/node/bin/node /Applications/DevEco-Studio.app/Contents/tools/hvigor/bin/hvigorw.js assembleHar -p module=library@default -p product=default
```

### 清理构建
```bash
/Applications/DevEco-Studio.app/Contents/tools/node/bin/node /Applications/DevEco-Studio.app/Contents/tools/hvigor/bin/hvigorw.js clean
```

## OHPM 发布

### 发布命令
```bash
/Applications/DevEco-Studio.app/Contents/tools/ohpm/bin/ohpm publish \
  /Users/fh/Projects/ohos/EmojiPicker/library/build/default/outputs/default/library.har \
  --publish_id <发布码> \
  --key_path ~/.ssh_ohpm/ohpm_key
```

### 发布配置
- 密钥路径: `~/.ssh_ohpm/ohpm_key`
- 公钥路径: `~/.ssh_ohpm/ohpm_key.pub`
- OHPM 中心仓: https://ohpm.openharmony.cn

### 发布注意事项
1. 密钥必须设置密码（passphrase）
2. `repository` 字段必须是 URL 字符串格式，不能是对象
3. HAR 包路径: `library/build/default/outputs/default/library.har`

## 使用方法

### 安装
```bash
ohpm install @kelegele/emoji-picker
```

### 基础用法
```typescript
import { Picker } from '@kelegele/emoji-picker'

@Component
struct MyComponent {
  @State emojiText: string = ''

  build() {
    Column() {
      Picker({ emojiText: $emojiText })
    }
  }
}
```

### 自定义配置
```typescript
import { Picker, THEME_GRAY, EmojiPickerTheme } from '@kelegele/emoji-picker'

// 使用内置主题
Picker({ 
  emojiText: $emojiText,
  theme: THEME_GRAY,
  emojiFontSize: 28,  // 默认 32
  lanes: 8            // 默认 7
})

// 自定义主题
const myTheme: EmojiPickerTheme = {
  name: 'custom',
  selectedTextColor: '#FF6B6B',
  selectedBgColor: '#FFE5E5',
  unselectedTextColor: '#666666',
  unselectedBgColor: '#F5F5F5',
  headerColor: '#FF6B6B',
  headerBgColor: '#FFFFFF'
}

Picker({ emojiText: $emojiText, theme: myTheme })
```

## API 参考

### Picker 组件 Props

| 参数 | 类型 | 必填 | 默认值 | 说明 |
|------|------|------|--------|------|
| emojiText | `ResourceStr` | 是 | - | 双向绑定的选中 Emoji |
| emojiFontSize | `number` | 否 | 32 | Emoji 字体大小 |
| lanes | `number` | 否 | 7 | 每行显示数量 |
| theme | `EmojiPickerTheme` | 否 | `THEME_DEFAULT` | 主题配置 |
| emojiData | `EmojiGroup[]` | 否 | 内置数据 | 自定义 Emoji 数据源 |

### EmojiPickerTheme 接口

| 字段 | 类型 | 说明 |
|------|------|------|
| name | `string` | 主题名称 |
| selectedTextColor | `ResourceStr` | 选中Tab文字颜色 |
| selectedBgColor | `ResourceStr` | 选中Tab背景颜色 |
| unselectedTextColor | `ResourceStr` | 未选中Tab文字颜色 |
| unselectedBgColor | `ResourceStr` | 未选中Tab背景颜色 |
| headerColor | `ResourceStr` | 分组标题颜色 |
| headerBgColor | `ResourceStr` | 分组标题背景颜色 |

### 导出内容

- `Picker` - Emoji 选择器组件
- `EMOJI_251223` - 内置 Emoji 数据
- `EmojiGroup`, `EmojiItem` - 数据类型
- `EmojiPickerTheme` - 主题类型
- `THEME_DEFAULT`, `THEME_GREEN`, `THEME_GRAY` - 内置主题
- `BUILT_IN_THEMES` - 内置主题列表

## 开发规范

### 代码风格

1. **ArkTS 规范**
   - 使用 `@Component` 装饰器定义组件
   - 使用 `@State`、`@Prop`、`@Link` 等状态管理装饰器
   - 使用 `@Builder` 定义 UI 构建函数

2. **资源使用**
   - 颜色使用系统资源 `$r('sys.color.*')` 或应用资源 `$r('app.color.*')`
   - 禁止使用硬编码颜色值
   - 使用资源前确认资源存在

3. **主题适配**
   - 所有颜色使用必须考虑浅色/深色模式适配
   - 使用 `sys.color` 系统颜色自动适配主题

### 目录规范

- `components/` - UI 组件
- `models/` - 数据模型和类型定义
- `data/` - 数据源文件
- `resources/base/` - 基础资源
- `resources/dark/` - 深色模式资源

## 版本历史

- **v1.0.1** - 添加 headerBgColor 字段，完善权限配置
- **v1.0.0** - 初始版本发布

## 版本兼容性

- **最低 SDK**: HarmonyOS SDK 6.0.2 (API 20)
- **目标 SDK**: HarmonyOS SDK 6.0.2 (API 22)
- **运行系统**: HarmonyOS

> 注意: 部分 Unicode 15.1 新增的 Emoji 可能需要新版系统支持显示

## 许可证

Apache-2.0