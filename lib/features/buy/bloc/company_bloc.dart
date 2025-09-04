import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'company_event.dart';
import 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final http.Client client;

  CompanyBloc({required this.client}) : super(const CompanyState(company_name: "")) {
    on<FetchCompanyName>(_onFetchCompanyName);
  }

  Future<void> _onFetchCompanyName(
      FetchCompanyName event, Emitter<CompanyState> emit) async {
    try {
      final response = await client.get(
        Uri.parse('${dotenv.get("API_URL")}/stock/company/${event.symbol}'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final name = data['comapny_name'] ?? event.symbol;
        emit(state.copyWith(company_name: name));
      } else {
        emit(state.copyWith(company_name: event.symbol));
      }
    } catch (_) {
      emit(state.copyWith(company_name: event.symbol));
    }
  }
}
