import 'package:equatable/equatable.dart';

abstract class StockEvent extends Equatable {
  const StockEvent();

  @override
  List<Object?> get props => [];
}

class BuyStock extends StockEvent {
  final int quantity;

  const BuyStock(this.quantity);

  @override
  List<Object?> get props => [quantity];
}

class SellStock extends StockEvent {
  final int quantity;

  const SellStock(this.quantity);

  @override
  List<Object?> get props => [quantity];
}

class GetCompany extends StockEvent {
  
}