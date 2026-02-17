/**
 * Emoji选择器主题配置
 */
export interface EmojiPickerTheme {
  /** 主题名称 */
  name: string
  /** 选中Tab文字颜色 */
  selectedTextColor: ResourceStr
  /** 选中Tab背景颜色 */
  selectedBgColor: ResourceStr
  /** 未选中Tab文字颜色 */
  unselectedTextColor: ResourceStr
  /** 未选中Tab背景颜色 */
  unselectedBgColor: ResourceStr
  /** 分组标题颜色 */
  headerColor: ResourceStr
  /** 分组标题背景颜色 */
  headerBgColor: ResourceStr
}

/**
 * 内置主题：鸿蒙默认（蓝色系）
 */
export const THEME_DEFAULT: EmojiPickerTheme = {
  name: 'default',
  selectedTextColor: $r('sys.color.font_emphasize'),
  selectedBgColor: $r('sys.color.comp_emphasize_secondary'),
  unselectedTextColor: $r('sys.color.font_secondary'),
  unselectedBgColor: $r('sys.color.comp_background_tertiary'),
  headerColor: $r('sys.color.font_emphasize'),
  headerBgColor: $r('sys.color.comp_background_primary')
}

/**
 * 内置主题：绿色（品牌色）
 */
export const THEME_GREEN: EmojiPickerTheme = {
  name: 'green',
  selectedTextColor: $r('app.color.color_green_primary'),
  selectedBgColor: $r('app.color.color_green_primary_light'),
  unselectedTextColor: $r('sys.color.font_secondary'),
  unselectedBgColor: $r('sys.color.comp_background_tertiary'),
  headerColor: $r('app.color.color_green_primary'),
  headerBgColor: $r('sys.color.comp_background_primary')
}

/**
 * 内置主题：灰色（通用无彩色）
 */
export const THEME_GRAY: EmojiPickerTheme = {
  name: 'gray',
  selectedTextColor: $r('sys.color.font_primary'),
  selectedBgColor: $r('sys.color.comp_background_secondary'),
  unselectedTextColor: $r('sys.color.font_secondary'),
  unselectedBgColor: $r('sys.color.comp_background_tertiary'),
  headerColor: $r('sys.color.font_primary'),
  headerBgColor: $r('sys.color.comp_background_primary')
}

/**
 * 内置主题列表
 */
export const BUILT_IN_THEMES: EmojiPickerTheme[] = [
  THEME_DEFAULT,
  THEME_GREEN,
  THEME_GRAY
]
