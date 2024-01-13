final class ApiPaths {
  ApiPaths._();

  static String getStockIndicators(String stockId) =>
      'https://query2.finance.yahoo.com/v8/finance/chart/$stockId.SA';
}
