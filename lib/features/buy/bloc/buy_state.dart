import 'package:equatable/equatable.dart';

class StockState extends Equatable {
  final double price;
  final int quantity;

  const StockState({required this.price, required this.quantity});

  StockState copyWith({double? price, int? quantity}) {
    return StockState(
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [price, quantity];
}
