# @kelegele/emoji-picker

一个支持中文标签和主题配色的 HarmonyOS Emoji 选择器组件。

## 特性

- 🎨 **多主题支持** - 内置默认/绿色/灰色三种主题，支持自定义
- 🇨🇳 **中文标签** - 所有 Emoji 均有中文描述
- 📱 **分组展示** - 按类别分组，支持快速定位
- ✨ **触感反馈** - 选择时提供震动反馈
- 🔧 **高度可配置** - Emoji大小、每行数量等均可自定义

## 安装

```bash
ohpm install @kelegele/emoji-picker
```

## 使用

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

### 自定义主题

```typescript
import { Picker, THEME_DEFAULT, THEME_GRAY, THEME_GREEN } from '@kelegele/emoji-picker'

// 使用内置主题
Picker({ 
  emojiText: $emojiText,
  theme: THEME_GRAY  // 灰色主题
})

// 自定义Emoji大小
Picker({ 
  emojiText: $emojiText,
  emojiFontSize: 28  // 默认32
})

// 自定义每行数量
Picker({ 
  emojiText: $emojiText,
  lanes: 8  // 默认7
}
```

### 内置主题

| 主题 | 说明 |
|------|------|
| `THEME_DEFAULT` | 鸿蒙默认（蓝色系） |
| `THEME_GREEN` | 绿色（品牌色） |
| `THEME_GRAY` | 灰色（通用无彩色） |

### 自定义主题

```typescript
import { Picker, EmojiPickerTheme } from '@kelegele/emoji-picker'

const myTheme: EmojiPickerTheme = {
  name: 'custom',
  selectedTextColor: '#FF6B6B',      // 选中Tab文字颜色
  selectedBgColor: '#FFE5E5',        // 选中Tab背景颜色
  unselectedTextColor: '#666666',    // 未选中Tab文字颜色
  unselectedBgColor: '#F5F5F5',      // 未选中Tab背景颜色
  headerColor: '#FF6B6B'             // 分组标题颜色
}

Picker({ 
  emojiText: $emojiText,
  theme: myTheme
})
```

## API

### Props

| 参数 | 类型 | 必填 | 默认值 | 说明 |
|------|------|------|--------|------|
| emojiText | `ResourceStr` | 是 | - | 双向绑定的选中 Emoji |
| emojiFontSize | `number` | 否 | 32 | Emoji 字体大小 |
| lanes | `number` | 否 | 7 | 每行显示数量 |
| theme | `EmojiPickerTheme` | 否 | `THEME_DEFAULT` | 主题配置 |
| emojiData | `EmojiGroup[]` | 否 | 内置数据 | 自定义 Emoji 数据源 |

## 数据结构

```typescript
interface EmojiItem {
  sub_group: string    // 子分组名称
  emoji_font: string   // Emoji 字符
  emoji_name: string   // 中文名称
  unicode: string      // Unicode 编码
}

interface EmojiGroup {
  group_id: string     // 分组ID
  group: string        // 分组名称
  items: EmojiItem[]   // Emoji 列表
}

interface EmojiPickerTheme {
  name: string                  // 主题名称
  selectedTextColor: ResourceStr   // 选中Tab文字颜色
  selectedBgColor: ResourceStr     // 选中Tab背景颜色
  unselectedTextColor: ResourceStr // 未选中Tab文字颜色
  unselectedBgColor: ResourceStr   // 未选中Tab背景颜色
  headerColor: ResourceStr         // 分组标题颜色
}
```

## 兼容性

- HarmonyOS SDK 6.0.0 (API 20) 及以上
- 部分较新的 Unicode 15.1 Emoji 可能需要新版系统支持

## 许可证

Apache-2.0