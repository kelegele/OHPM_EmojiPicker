export interface EmojiItem {
  sub_group: string,
  emoji_font: string,
  emoji_name: string,
  unicode: string,
}

export interface EmojiGroup {
  group_id: string,
  group: string,
  items: EmojiItem[],
}