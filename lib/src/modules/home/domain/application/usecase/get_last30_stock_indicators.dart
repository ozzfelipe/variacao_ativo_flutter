import 'package:result_dart/result_dart.dart';
import 'package:variacao_ativo_flutter/src/core/domain/application/exceptions/app_exception.dart';
import 'package:variacao_ativo_flutter/src/core/domain/application/usecase/usecase.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/application/data/stock_indecators_source.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/application/entities/stock_indicator_list.dart';

class GetLast30StockIndicators extends Usecase<String, StockIndicatorList> {
  final StockIndicatorsSource stockIndicatorsSource;

  GetLast30StockIndicators(this.stockIndicatorsSource);
  @override
  Future<Result<StockIndicatorList, AppException>> call({
    required String params,
  }) async {
    if (params.isEmpty) {
      return ArgumentsException().toFailure();
    }
    return stockIndicatorsSource.getLast30StockIndicatorsById(params);
  }
}
