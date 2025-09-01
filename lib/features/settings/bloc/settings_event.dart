import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangeBalanceEvent extends SettingsEvent {
  final double newBalance;

  ChangeBalanceEvent({required this.newBalance});

  @override
  List<Object?> get props => [newBalance];
}
