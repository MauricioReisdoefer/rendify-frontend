import 'package:equatable/equatable.dart';

class StockState extends Equatable {
  final String symbol;
  final double price;
  final int quantity;

  StockState({required this.price, required this.quantity, required this.symbol});

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


class StockError extends StockState {
  final String symbol;
  final double price;
  final int quantity;
  final String msg;

  StockError({required this.msg, required this.price, required this.quantity, required this.symbol}) : super(price: price, quantity: quantity, symbol: symbol);

  StockError copyWith({double? price, int? quantity, String? symbol, String? msg}) {
    return StockError(
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      symbol: symbol ?? this.symbol,
      msg: msg ?? this.msg
    );}

  @override
  List<Object?> get props => [price, quantity, symbol, msg];
}