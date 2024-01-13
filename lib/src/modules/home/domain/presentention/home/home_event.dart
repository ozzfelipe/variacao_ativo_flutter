sealed class HomeEvent {
  HomeEvent._();

  factory HomeEvent.fetchStockIndicatorsById(String stockId) =>
      FetchStockIndicatorsEvent(stockId);
}

final class FetchStockIndicatorsEvent extends HomeEvent {
  String stockId;
  FetchStockIndicatorsEvent(this.stockId) : super._();
}
