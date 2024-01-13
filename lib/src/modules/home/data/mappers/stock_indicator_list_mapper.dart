import 'package:variacao_ativo_flutter/src/modules/home/domain/application/entities/stock_indicator_list.dart';

final class StockIndicatorListMapper {
  static StockIndicatorList fromMap(String stock, Map<String, dynamic> map) {
    Map<String, dynamic> chart = map['chart']['result'].first;
    var indicatorsDate = List.castFrom<dynamic, int>(chart['timestamp'])
        .map((e) => DateTime.fromMillisecondsSinceEpoch(e * 1000))
        .toList();
    var indicatorsOpenValue = List.castFrom<dynamic, double>(
            chart['indicators']['quote'].first['open'])
        .toList();

    return StockIndicatorList(
      stockId: stock,
      dateList: indicatorsDate,
      openValueList: indicatorsOpenValue,
    );
  }
}
