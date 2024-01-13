import 'package:flutter_test/flutter_test.dart';
import 'package:variacao_ativo_flutter/src/modules/home/data/mappers/stock_indicator_list_mapper.dart';

import '../mock/indicators_data_mock.dart';

void main() {
  group('stock indicator list mapper => ', () {
    test('should transform a map of data in a StockIndicatorsList', () {
      var stockIndicatorsList =
          StockIndicatorListMapper.fromMap(stockMock, stockIndicatorsMock);

      expect(stockIndicatorsList.stockId, equals(stockMock));
      expect(stockIndicatorsList.dateList.length == 30, isTrue);
      expect(stockIndicatorsList.openValueList.length == 30, isTrue);
    });
  });
}
