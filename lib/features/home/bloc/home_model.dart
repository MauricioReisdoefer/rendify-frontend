class WatchItem {
  final String symbol;
  final double? price; // opcional

  WatchItem({required this.symbol, this.price});

  factory WatchItem.fromJson(dynamic json) {
    if (json is String) {
      return WatchItem(symbol: json);
    } else if (json is Map<String, dynamic>) {
      return WatchItem(
        symbol: json['symbol'],
        price: (json['price'] as num?)?.toDouble(),
      );
    }
    throw Exception("Formato inválido para WatchItem: $json");
  }
}
