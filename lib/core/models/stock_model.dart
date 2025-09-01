class StockModel {
  final String symbol;
  final double price;
  final int ammount;

  StockModel({
    required this.symbol,
    required this.price,
    required this.ammount
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      symbol: json['symbol'],
      price: json['price'],
      ammount: json['ammount']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'price': price,
      'ammount': ammount
    };
  }
}