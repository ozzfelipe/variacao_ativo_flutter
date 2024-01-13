import 'package:result_dart/result_dart.dart';
import 'package:variacao_ativo_flutter/src/core/domain/application/exceptions/app_exception.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/application/entities/stock_indicator_list.dart';

abstract class StockIndicatorsSource {
  Future<Result<StockIndicatorList, AppException>> getLast30StockIndicatorsById(
      String stockId);
}
