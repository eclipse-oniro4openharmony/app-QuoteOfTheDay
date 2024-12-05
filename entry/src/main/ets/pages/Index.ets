import { Quotes } from '../entryability/Quotes';

let quoteClass = new Quotes();

@Entry()
@Component
struct Index {
  @State quote: string = '';
  @State author: string = '';
  build() {
    Column() {
      Scroll(new Scroller()) {
        Text(this.quote)
          .fontSize($r('app.integer.font_size'))
          .fontWeight(FontWeight.Bold)
          .fontStyle(FontStyle.Italic)
          .fontColor(Color.White)
      }
      .padding(10)
      .flexGrow(2)
      .flexBasis(1)

      Text(this.author)
        .flexGrow(1)
        .fontSize($r('app.integer.font_size'))
        .fontWeight(FontWeight.Medium)
      Button($r('app.string.new_quote'))
        .onClick(() => {
          this.quote = '" ' + quoteClass.getQuote() + ' "';
          this.author = "- " + quoteClass.getAuthor();
          quoteClass.getNewQuote();
        }
        ).margin(20)
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.quoteBack'))
    .backgroundImageSize(ImageSize.Contain)
    .backgroundImagePosition(Alignment.Center)
    .backgroundColor($r('app.color.background_colour'))
  }
}