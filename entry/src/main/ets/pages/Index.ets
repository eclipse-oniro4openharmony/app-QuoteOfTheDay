import { Quotes } from '../entryability/Quotes';

const quoteService = new Quotes();

@Entry()
@Component
struct Index {
  @State quote: string = '';
  @State author: string = '';
  @State isLoading: boolean = false;
  @State hasError: boolean = false;

  aboutToAppear(): void {
    this.loadQuote();
  }

  private async loadQuote(): Promise<void> {
    if (this.isLoading) {
      return;
    }

    this.isLoading = true;
    this.hasError = false;
    try {
      const quote = await quoteService.getNewQuote();
      if (quote) {
        this.quote = quote.quote;
        this.author = quote.author;
      } else {
        this.hasError = true;
      }
    } catch (error) {
      this.hasError = true;
    } finally {
      this.isLoading = false;
    }
  }

  build() {
    Column() {
      Column() {
        Text($r('app.string.EntryAbility_label'))
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.ink'))
          .width('100%')
          .margin({ bottom: 24 })

        Column() {
          Scroll() {
            Column() {
              Text('“')
                .fontSize(72)
                .fontWeight(FontWeight.Bold)
                .fontColor($r('app.color.accent_pink'))
                .height(72)
                .width('100%')
                .margin({ bottom: 12 })

              if (this.quote) {
                Text(this.quote)
                  .fontSize(21)
                  .fontWeight(FontWeight.Medium)
                  .lineHeight(31)
                  .fontColor($r('app.color.card_text'))
                  .width('100%')
              } else if (this.isLoading) {
                Text($r('app.string.loading_quote'))
                  .fontSize(21)
                  .fontColor($r('app.color.card_text'))
                  .width('100%')
              }

              if (this.author) {
                Row({ space: 12 }) {
                  Text('')
                    .width(28)
                    .height(2)
                    .backgroundColor($r('app.color.accent_cyan'))

                  Text(this.author)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor($r('app.color.card_muted'))
                }
                .width('100%')
                .margin({ top: 28 })
              }
            }
            .width('100%')
          }
          .width('100%')
          .align(Alignment.TopStart)
          .constraintSize({ maxHeight: '100%' })
          .padding(28)
          .borderRadius(28)
          .backgroundColor($r('app.color.ink'))
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)

        if (this.hasError) {
          Text($r('app.string.quote_load_error'))
            .fontSize(16)
            .lineHeight(24)
            .fontColor($r('app.color.ink'))
            .width('100%')
            .margin({ top: 20 })
        }

        Button(this.isLoading ? $r('app.string.loading_button') :
          (this.hasError ? $r('app.string.retry_quote') : $r('app.string.new_quote')))
          .enabled(!this.isLoading)
          .onClick(() => {
            this.loadQuote();
          })
          .width('100%')
          .height(58)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.card_text'))
          .backgroundColor($r('app.color.brand_purple'))
          .borderRadius(18)
          .margin({ top: this.hasError ? 12 : 20 })
      }
      .width('100%')
      .height('100%')
      .padding({ top: 28, right: 24, bottom: 24, left: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.background_colour'))
  }
}
