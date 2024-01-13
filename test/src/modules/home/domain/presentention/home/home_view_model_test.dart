import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:variacao_ativo_flutter/src/core/domain/application/exceptions/app_exception.dart';
import 'package:variacao_ativo_flutter/src/modules/home/data/mappers/stock_indicator_list_mapper.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/application/usecase/get_last30_stock_indicators.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/presentention/home/home_event.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/presentention/home/home_view_model.dart';

import '../../../data/mock/indicators_data_mock.dart';

class GetGetLast30StockIndicatorsMock extends Mock
    implements GetLast30StockIndicators {}

void main() {
  late final GetLast30StockIndicators usecase;
  late final HomeViewModel sut;

  setUpAll(() {
    usecase = GetGetLast30StockIndicatorsMock();
    sut = HomeViewModel(usecase);
  });

  final stockList =
      StockIndicatorListMapper.fromMap(stockMock, stockIndicatorsMock);
  group('home view model group tests => ', () {
    test('should init state with loading true', () {
      var state = sut.state;

      expect(state.value.loading, isTrue);
      expect(state.value.stockIndicatorList, isNull);
    });
    test('should call onEvent when user fetch a stock data', () {
      when(() => usecase(params: any(named: 'params')))
          .thenAnswer((_) async => stockList.toSuccess());

      sut.onEvent(HomeEvent.fetchStockIndicatorsById(stockMock));

      var verifyResult =
          verify(() => usecase(params: captureAny(named: 'params')));
      verifyResult.called(1);
      expect(verifyResult.captured.first, equals(stockMock));
    });
    test('should update state with stockIndicators', () async {
      when(() => usecase(params: any(named: 'params')))
          .thenAnswer((_) async => stockList.toSuccess());

      await sut.onEvent(HomeEvent.fetchStockIndicatorsById(stockMock));

      expect(sut.state.value.loading, isFalse);
      expect(sut.state.value.stockIndicatorList, equals(stockList));
    });
    test('should update loading when start event of fetch stock data', () {
      when(() => usecase(params: any(named: 'params')))
          .thenAnswer((_) async => stockList.toSuccess());

      sut.onEvent(HomeEvent.fetchStockIndicatorsById(stockMock));

      expect(sut.state.value.loading, isTrue);
    });
    test('should update state with error when pass invalid argument', () async {
      when(() => usecase(params: any(named: 'params')))
          .thenAnswer((_) async => ArgumentsException().toFailure());

      await sut.onEvent(HomeEvent.fetchStockIndicatorsById(stockMock));

      expect(sut.state.value.error, ArgumentsException().message);
    });
    test('should update state with error when not found stock', () async {
      when(() => usecase(params: any(named: 'params')))
          .thenAnswer((_) async => StockNotFoundException().toFailure());

      await sut.onEvent(HomeEvent.fetchStockIndicatorsById(stockMock));

      expect(sut.state.value.error, StockNotFoundException().message);
    });
  });
}
