import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:variacao_ativo_flutter/src/modules/home/domain/application/entities/stock_indicator_list.dart';

class HomeState extends ChangeNotifier {
  final StockIndicatorList? stockIndicatorList;
  final bool loading;
  final String error;

  HomeState(
    this.stockIndicatorList,
    this.loading,
    this.error,
  );
  HomeState.initalState()
      : error = '',
        loading = false,
        stockIndicatorList = null;

  HomeState copyWith({
    StockIndicatorList? stockIndicatorList,
    bool loading = false,
    String error = '',
  }) {
    return HomeState(
      stockIndicatorList ?? this.stockIndicatorList,
      loading,
      error,
    );
  }
}
