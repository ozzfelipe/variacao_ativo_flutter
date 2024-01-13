import 'package:variacao_ativo_flutter/src/modules/home/domain/application/entities/stock_indicator_list.dart';

final class StockIndicatorListMapper {
  static StockIndicatorList fromMap(String stock, Map<String, dynamic> map) {
    var chart = map['chart']['result'].first;
    var indicatorsDate = (chart['timestamp'] as List<int>)
        .map((e) => DateTime.fromMillisecondsSinceEpoch(e * 1000))
        .toList();
    var indicatorsOpenValue =
        (chart['indicators']['quote'].first['open'] as List<double>).toList();

    return StockIndicatorList(
      stockId: stock,
      dateList: indicatorsDate,
      openValueList: indicatorsOpenValue,
    );
  }
}
