import 'package:intl/intl.dart';

class CurrencyUtil {
  static String toCurrency(double number, {int decimalDigits = 2}) {
    return NumberFormat.simpleCurrency(
      locale: 'pt_BR',
      decimalDigits: decimalDigits,
    ).format(number);
  }

  static String toCurrencyOnlyNumbers(double number, {int decimalDigits = 2}) =>
      NumberFormat.simpleCurrency(
              locale: 'pt_BR', decimalDigits: decimalDigits, name: '')
          .format(number);

  static String toCurrencyClear(double number, {int decimalDigits = 2}) =>
      number.toStringAsFixed(decimalDigits).replaceAll('.', ',');
}
