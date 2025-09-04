import 'package:equatable/equatable.dart';

class CompanyState extends Equatable {
  final String company_name;

  const CompanyState({required this.company_name});

  CompanyState copyWith({String? company_name}) {
    return CompanyState(
      company_name: company_name ?? this.company_name
    );
  }

  @override
  List<Object?> get props => [company_name];
}
