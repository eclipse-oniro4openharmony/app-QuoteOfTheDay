import { Quotes } from '../entryability/Quotes';

let quoteClass = new Quotes();

@Entry()
@Component
struct Index {
  @State quote: string = '';
  @State author: string = '';
  build() {
    Column() {
      Child({myQuote : $quote})
      Scroll(new Scroller()) {
        Text(this.quote)
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
          .fontStyle(FontStyle.Italic)
          .fontColor(Color.White)
      }
      .padding(10)
      .flexGrow(2)
      .flexBasis(1)

      Text(this.author)
        .flexGrow(1)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
      Button($r('app.string.new_quote'))
        .onClick(() => {
          this.quote = quoteClass.getQuote();
          this.author = quoteClass.getAuthor();
          quoteClass.getNewQuote();
        }
        ).margin(20)
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.quoteBack'))
    .backgroundImageSize(ImageSize.Contain)
    .backgroundImagePosition(Alignment.Center)
    .backgroundColor('#819FD4')
  }
}

@Component
struct Child {
  @Link myQuote: string;
  build() {
  }
}