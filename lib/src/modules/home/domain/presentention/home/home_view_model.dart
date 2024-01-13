import 'package:flutter/foundation.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/application/usecase/get_last30_stock_indicators.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/presentention/home/home_event.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/presentention/home/home_state.dart';

class HomeViewModel {
  final GetLast30StockIndicators _getLast30StockIndicatorsUsecase;

  HomeViewModel(this._getLast30StockIndicatorsUsecase);

  final ValueNotifier<HomeState> _state =
      ValueNotifier(HomeState.initalState());
  ValueListenable<HomeState> get state => _state;

  Future<void> onEvent(HomeEvent event) async => switch (event) {
        FetchStockIndicatorsEvent e => _fetchStockIndicatorsHandler(e.stockId),
      };

  Future<void> _fetchStockIndicatorsHandler(String stockId) async {
    _state.value = _state.value.copyWith(loading: true);

    var res = await _getLast30StockIndicatorsUsecase(params: stockId);

    res.fold(
      (success) =>
          _state.value = _state.value.copyWith(stockIndicatorList: success),
      (failure) => _state.value = _state.value.copyWith(error: failure.message),
    );
  }
}
