import 'package:variacao_ativo_flutter/src/core/di/core_di.dart';
import 'package:variacao_ativo_flutter/src/modules/home/data/remote/stock_indicators_source_remote_impl.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/application/data/stock_indecators_source.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/application/usecase/get_last30_stock_indicators.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/presentention/home/home_view_model.dart';

void setUpHomeDi() {
  getIt.registerFactory<StockIndicatorsSource>(
      () => StockIndicatorsSourceRemoteImpl(getIt.get()));
  getIt.registerFactory(() => GetLast30StockIndicators(getIt.get()));
  getIt.registerSingleton(HomeViewModel(getIt.get()));
}
