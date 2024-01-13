import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:variacao_ativo_flutter/src/core/domain/application/exceptions/app_exception.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/application/data/stock_indecators_source.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/application/entities/stock_indicator_list.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/application/usecase/get_last30_stock_indicators.dart';

import '../../../data/mock/indicators_data_mock.dart';

class StockIndicatorsSourceMock extends Mock implements StockIndicatorsSource {}

void main() {
  late final StockIndicatorsSource source;
  late final GetLast30StockIndicators sut;

  setUpAll(() {
    source = StockIndicatorsSourceMock();
    sut = GetLast30StockIndicators(source);
    const getLast30StockIndicatorsParams = 'PETR4';
    registerFallbackValue(getLast30StockIndicatorsParams);
  });

  final StockIndicatorList stockIndicatorListMock =
      StockIndicatorList(stockId: stockMock, dateList: [], openValueList: []);

  group('get stock indicators tests group =>', () {
    test('should receive the correct params', () {
      when(() => source.getLast30StockIndicatorsById(any()))
          .thenAnswer((_) async => stockIndicatorListMock.toSuccess());

      sut(params: stockMock);

      var verifyResult =
          verify(() => source.getLast30StockIndicatorsById(captureAny()));
      verifyResult.called(1);
      expect(verifyResult.captured.first, equals(stockMock));
    });
    test('should return failure when receive incorrect params', () {
      sut(params: '');

      verifyNever(() => source.getLast30StockIndicatorsById(any()));
    });
    test('should pass to source the correct params', () {
      when(() => source.getLast30StockIndicatorsById(any()))
          .thenAnswer((_) async => stockIndicatorListMock.toSuccess());

      sut(params: stockMock);

      var verifyResult =
          verify(() => source.getLast30StockIndicatorsById(captureAny()));
      verifyResult.called(1);

      expect(
        verifyResult.captured.first,
        equals(stockMock),
      );
    });
    test('should return failure when source has error', () async {
      when(() => source.getLast30StockIndicatorsById(any()))
          .thenAnswer((_) async => UnexpectedException().toFailure());

      var result = await sut(params: stockMock);

      expect(result, isA<Failure<StockIndicatorList, AppException>>());
    });
  });
}
