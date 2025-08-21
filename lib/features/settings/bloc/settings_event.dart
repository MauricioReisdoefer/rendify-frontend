import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangeBalanceEvent extends SettingsEvent {
  final int userId;
  final double newBalance;

  ChangeBalanceEvent({required this.userId, required this.newBalance});

  @override
  List<Object?> get props => [userId, newBalance];
}
