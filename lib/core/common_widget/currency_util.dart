import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'exchange_rate_service.dart';

String formatCurrency(num vndPrice) {
  final locale = Get.locale ?? const Locale('vi', 'VN');

  String currencyCode;
  String symbol;

  switch (locale.languageCode) {
    case 'zh':
      currencyCode = 'CNY';
      symbol = '¥ ';
      break;
    case 'en':
      currencyCode = 'USD';
      symbol = '\$ ';
      break;
    case 'vi':
    default:
      currencyCode = 'VND';
      symbol = '₫ ';
  }

  // Chuyển đổi tiền theo tỷ giá
  final convertedPrice = ExchangeRateService.convertPrice(
    vndPrice,
    currencyCode,
  );

  return NumberFormat.currency(
    symbol: symbol,
    locale: locale.toString(),

    decimalDigits: 0,
  ).format(convertedPrice);
}
