import 'package:equatable/equatable.dart';

class StockState extends Equatable {
  final String symbol;
  final double price;
  final int quantity;

  const StockState({required this.price, required this.quantity, required this.symbol});

  StockState copyWith({double? price, int? quantity, String? symbol}) {
    return StockState(
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      symbol: symbol ?? this.symbol
    );
  }

  @override
  List<Object?> get props => [price, quantity, symbol];
}
