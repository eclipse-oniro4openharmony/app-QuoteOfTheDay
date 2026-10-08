import { http } from '@kit.NetworkKit';

export interface QuoteData {
  author: string;
  quote: string;
}

interface QuoteResponse {
  data: QuoteData;
}

const API_URL: string = 'https://stoic.tekloon.net/stoic-quote';

export class Quotes {
  async getNewQuote(): Promise<QuoteData | null> {
    const request = http.createHttp();

    try {
      const response = await request.request(API_URL);
      if (response.responseCode !== http.ResponseCode.OK || typeof response.result !== 'string') {
        throw new Error('Invalid quote response');
      }

      const parsed: QuoteResponse = JSON.parse(response.result as string);
      if (!parsed || !parsed.data || typeof parsed.data.quote !== 'string' ||
        typeof parsed.data.author !== 'string' || !parsed.data.quote.trim()) {
        throw new Error('Invalid quote data');
      }

      return parsed.data;
    } catch (error) {
      return null;
    } finally {
      request.destroy();
    }
  }
}
