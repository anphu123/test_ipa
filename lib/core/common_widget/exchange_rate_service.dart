class ExchangeRateService {
  // Tỷ giá giả định (bạn có thể fetch từ API nếu muốn)
  static const double vndToCny = 0.00029; // Ví dụ: 1 VND = 0.00029 CNY
  static const double vndToUsd = 0.000039; // Ví dụ: 1 VND = 0.000039 USD

  static num convertPrice(num vndPrice, String currencyCode) {
    switch (currencyCode) {
      case 'CNY':
        return vndPrice * vndToCny;
      case 'USD':
        return vndPrice * vndToUsd;
      case 'VND':
      default:
        return vndPrice;
    }
  }
}
