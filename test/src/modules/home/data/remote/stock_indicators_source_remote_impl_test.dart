import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:variacao_ativo_flutter/src/core/domain/application/exceptions/app_exception.dart';
import 'package:variacao_ativo_flutter/src/modules/home/data/keys/api_path.dart';
import 'package:variacao_ativo_flutter/src/modules/home/data/remote/stock_indicators_source_remote_impl.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/application/data/stock_indecators_source.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/application/entities/stock_indicator_list.dart';

import '../mock/indicators_data_mock.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final Dio dioMock = DioMock();
  late final StockIndicatorsSource sut;

  setUpAll(() {
    sut = StockIndicatorsSourceRemoteImpl(dioMock);
  });
  group('stock indicators source remote tests => ', () {
    test('should call http request with correct path', () async {
      when(() => dioMock.get(any(),
              queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
              requestOptions: RequestOptions(), data: stockIndicatorsMock));

      sut.getLast30StockIndicatorsById(stockMock);

      var verifyResult = verify(() => dioMock.get(captureAny(),
          queryParameters: captureAny(named: 'queryParameters')));
      verifyResult.called(1);

      expect(verifyResult.captured.first,
          equals(ApiPaths.getStockIndicators(stockMock)));
      expect(verifyResult.captured.last,
          equals({'interval': '1d', 'range': '30d'}));
    });
    test('should return failure in any error', () async {
      when(() => dioMock.get(any(),
              queryParameters: any(named: 'queryParameters')))
          .thenThrow(DioException(requestOptions: RequestOptions()));

      var res = await sut.getLast30StockIndicatorsById(stockMock);

      expect(res, isA<Failure>());
    });
    test('should return StockNotFoundException when not found the stock',
        () async {
      when(() => dioMock.get(any(),
          queryParameters: any(named: 'queryParameters'))).thenThrow(
        DioException.badResponse(
          statusCode: 404,
          requestOptions: RequestOptions(),
          response: Response(requestOptions: RequestOptions(), statusCode: 404),
        ),
      );

      var res = await sut.getLast30StockIndicatorsById(stockMock);

      expect(res, isA<Failure<StockIndicatorList, StockNotFoundException>>());
    });
    test(
        'should return a StockIndicatorList entity when get stock with success',
        () async {
      when(() => dioMock.get(any(),
          queryParameters: any(named: 'queryParameters'))).thenAnswer(
        (_) async => Response(
            requestOptions: RequestOptions(), data: stockIndicatorsMock),
      );

      var res = await sut.getLast30StockIndicatorsById(stockMock);

      expect(res, isA<Success<StockIndicatorList, AppException>>());
      expect(res.getOrNull()?.dateList.length == 30, isTrue);
    });
  });
}
