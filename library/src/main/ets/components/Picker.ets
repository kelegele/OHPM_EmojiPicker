import { hilog } from '@kit.PerformanceAnalysisKit'
import { vibrator } from '@kit.SensorServiceKit'
import { EMOJI_251223 } from '../data/EmojiData'
import { EmojiGroup, EmojiItem } from '../models/EmojiModel'
import { EmojiPickerTheme, THEME_DEFAULT } from '../models/EmojiPickerTheme'


const TAG: string = 'Picker'
const DOMAIN: number = 0x0000

@Preview
@Component
export struct Picker {
  /** 选中的Emoji（双向绑定） */
  @Link emojiText: ResourceStr
  /** Emoji字体大小，默认32 */
  @Prop emojiFontSize: number = 32
  /** 每行显示数量，默认7 */
  @Prop lanes: number = 7
  /** 主题配置，默认鸿蒙默认主题 */
  @Prop theme: EmojiPickerTheme = THEME_DEFAULT
  /** 自定义Emoji数据源 */
  @Prop emojiData: EmojiGroup[] = EMOJI_251223

  @State groupIndex: number = 0
  emojiScroller: ListScroller = new ListScroller()
  private isScrolling: boolean = false

  @Builder
  EmojiGroupTabBuilder(group: string, index: number) {
    Column() {
      Text(group)
        .fontWeight(FontWeight.Medium)
        .fontSize(16)
        .fontColor(index === this.groupIndex ? this.theme.selectedTextColor : this.theme.unselectedTextColor)
    }
    .padding(10)
    .backgroundColor(index === this.groupIndex ? this.theme.selectedBgColor : this.theme.unselectedBgColor)
    .borderRadius(10)
    .onClick(() => {
      if (this.isScrolling) {
        return
      }
      this.handleVibrator()
      this.groupIndex = index
      this.isScrolling = true
      try {
        this.emojiScroller.scrollToItemInGroup(index, 0, true)
      } catch (error) {
        hilog.error(DOMAIN, TAG, `scrollToItemInGroup error: ${JSON.stringify(error)}`)
      }
      setTimeout(() => {
        this.isScrolling = false
      }, 500)
    })
  }

  @Builder
  EmojiGroupHeaderBuilder(title: string) {
    Text(title)
      .fontWeight(FontWeight.Medium)
      .fontSize(15)
      .fontColor(this.theme.headerColor)
      .width('100%')
      .padding({ left: 5 })
      .height(50)
      .backgroundColor($r('sys.color.comp_background_primary'))
  }

  @Builder
  EmojiItemBuilder(item: EmojiItem) {
    Text(item.emoji_font)
      .fontSize(this.emojiFontSize)
  }

  build() {
    Column() {
      Row() {
        List({ space: 10, initialIndex: 0 }) {
          Repeat<EmojiGroup>(this.emojiData)
            .each((riG: RepeatItem<EmojiGroup>) => {
              this.EmojiGroupTabBuilder(riG.item.group, riG.index)
            })
        }
        .listDirection(Axis.Horizontal)
        .scrollBar(BarState.Off)
        .friction(0.6)
        .alignListItem(ListItemAlign.Center)
        .edgeEffect(EdgeEffect.Spring)
        .height('auto')
        .width('auto')
        .padding({ left: 5, right: 5 })

      }
      .width('100%')
      .height(50)

      List({ space: 0, initialIndex: 0, scroller: this.emojiScroller }) {
        Repeat<EmojiGroup>(this.emojiData)
          .each((riG: RepeatItem<EmojiGroup>) => {
            ListItemGroup({ header: this.EmojiGroupHeaderBuilder(riG.item.group) }) {
              Repeat<EmojiItem>(riG.item.items)
                .each((riI: RepeatItem<EmojiItem>) => {
                  ListItem() {
                    this.EmojiItemBuilder(riI.item)
                  }
                  .margin({ bottom: 15 })
                  .onClick(() => {
                    this.handleVibrator()
                    this.emojiText = riI.item.emoji_font
                  })

                })
            }
            .divider(null)
            .width('100%')
          })
      }
      .listDirection(Axis.Vertical)
      .scrollBar(BarState.Auto)
      .sticky(StickyStyle.Header)
      .friction(0.6)
      .lanes(this.lanes, 10)
      .alignListItem(ListItemAlign.Center)
      .edgeEffect(EdgeEffect.Spring)
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 5, right: 5 })
    }

    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  handleVibrator() {
    if (canIUse("SystemCapability.Sensors.MiscDevice")) {
      vibrator.startVibration({
        type: 'preset',
        effectId: 'haptic.effect.soft',
      }, {
        usage: 'unknown',
      }, (error: BusinessError) => {
        if (error) {
          hilog.error(DOMAIN, TAG, `Failed to start vibration. Code: ${error.code}, message: ${error.message}`)
          return
        }
        hilog.info(DOMAIN, TAG, 'Succeed in starting vibration')
      })
    }
  }

}
