mixin DiffPercentCalcMixin {
  String calulateDayDiff(double actualDayValue, double? previousDayValue) {
    if (previousDayValue == null) {
      return '-';
    }

    var result = 100 - (((previousDayValue * 100) / actualDayValue));
    return '${result.toStringAsFixed(2)}%';
  }
}
