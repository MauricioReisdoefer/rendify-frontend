import 'package:equatable/equatable.dart';
import 'package:rendify/core/models/stock_model.dart';

abstract class SimulatorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SimulatorInitial extends SimulatorState {}

class SimulatorLoading extends SimulatorState {}

class SimulatorLoaded extends SimulatorState {
  final double balance;
  final List<StockModel> stocks;
  SimulatorLoaded(this.balance, this.stocks);

  @override
  List<Object?> get props => [balance, stocks];
}

class SimulatorError extends SimulatorState {
  final String message;

  SimulatorError(this.message);

  @override
  List<Object?> get props => [message];
}