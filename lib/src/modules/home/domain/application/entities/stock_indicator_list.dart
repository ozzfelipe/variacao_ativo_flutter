class StockIndicatorList {
  final String stockId;
  final List<DateTime> dateList;
  final List<double> openValueList;
  StockIndicatorList({
    required this.stockId,
    required this.dateList,
    required this.openValueList,
  });
  factory StockIndicatorList.empty() => StockIndicatorList(
        stockId: '',
        dateList: [],
        openValueList: [],
      );
}
