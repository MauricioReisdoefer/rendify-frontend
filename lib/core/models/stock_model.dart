class StockModel {
  final String symbol;
  final double price;

  StockModel({
    required this.symbol,
    required this.price,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      symbol: json['symbol'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'price': price,
    };
  }
}