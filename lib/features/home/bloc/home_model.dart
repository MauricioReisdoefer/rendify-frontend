class WatchItem {
  final String symbol;
  final double? price;

  WatchItem({required this.symbol, this.price});

  factory WatchItem.fromJson(dynamic e) {
    if (e is String) {
      return WatchItem(symbol: e, price: null);
    } else {
      return WatchItem(
        symbol: e["symbol"],
        price: e["price"]?.toDouble(),
      );
    }
  }
}