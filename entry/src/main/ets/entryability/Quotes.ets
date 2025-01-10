import http from '@ohos.net.http';

interface Data {
  author: string
  quote: string
}

interface quoteType {
  data: Data
}

const API_URL: string = 'https://stoic.tekloon.net/stoic-quote';

export class Quotes {
  private author: string = '';
  private quote: string = '';
  private httpRequest = http.createHttp();

  constructor() {
    this.getNewQuote();
  }

  getNewQuote() {
    console.log("AAA getNewQuote")

    this.httpRequest.request(API_URL, (error, values) => {
      if (!error) {
        let parsed: quoteType = JSON.parse(values.result as string);
        this.author = parsed.data.author;
        this.quote = parsed.data.quote;
        console.log("AAA " + parsed.data.quote)
        console.log("AAA " + parsed.data.author)
      } else {
        console.log('AAA Error: ' + JSON.stringify(error));
      }
    })
  }

  getAuthor(): string {
    return this.author;
  }

  getQuote(): string {
    return this.quote;
  }
}