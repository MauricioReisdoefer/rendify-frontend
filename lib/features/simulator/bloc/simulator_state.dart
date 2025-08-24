import 'package:equatable/equatable.dart';

abstract class SimulatorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SimulatorInitial extends SimulatorState {}

class SimulatorLoading extends SimulatorState {}

class SimulatorLoaded extends SimulatorState {
  final double balance;

  SimulatorLoaded(this.balance);

  @override
  List<Object?> get props => [balance];
}

class SimulatorError extends SimulatorState {
  final String message;

  SimulatorError(this.message);

  @override
  List<Object?> get props => [message];
}