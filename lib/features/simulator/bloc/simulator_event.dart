import 'package:equatable/equatable.dart';
import 'package:rendify/core/models/stock_model.dart';

abstract class SimulatorEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchBalance extends SimulatorEvent {
  final String username;

  FetchBalance(this.username);

  @override
  List<Object?> get props => [username];
}

class FetchStock extends SimulatorEvent {
  final List<StockModel> stocks;

  FetchStock(this.stocks);

  @override
  List<Object?> get props => [stocks];
}