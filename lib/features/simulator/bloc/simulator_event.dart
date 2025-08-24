import 'package:equatable/equatable.dart';

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