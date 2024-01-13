import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';
import 'package:variacao_ativo_flutter/src/core/domain/application/exceptions/app_exception.dart';
import 'package:variacao_ativo_flutter/src/modules/home/data/keys/api_path.dart';
import 'package:variacao_ativo_flutter/src/modules/home/data/mappers/stock_indicator_list_mapper.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/application/data/stock_indecators_source.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/application/entities/stock_indicator_list.dart';

class StockIndicatorsSourceRemoteImpl extends StockIndicatorsSource {
  final Dio _dio;

  StockIndicatorsSourceRemoteImpl(Dio dio) : _dio = dio;

  @override
  Future<Result<StockIndicatorList, AppException>> getLast30StockIndicatorsById(
      String stockId) async {
    try {
      var params = {'interval': '1d', 'range': '30d'};
      var res = await _dio.get(ApiPaths.getStockIndicators(stockId),
          queryParameters: params);

      return StockIndicatorListMapper.fromMap(stockId, res.data).toSuccess();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return StockNotFoundException().toFailure();
      }
    }
    return UnexpectedException(
      message:
          'Falha ao realizar a busca, verifique sua internet ou tente novamente mais tarde',
    ).toFailure();
  }
}
