import 'package:equatable/equatable.dart';

abstract class CompanyEvent extends Equatable {
  const CompanyEvent();

  @override
  List<Object?> get props => [];
}

class FetchCompanyName extends CompanyEvent {
  final String symbol;

  const FetchCompanyName({required this.symbol});

  @override
  List<Object?> get props => [symbol];
}
