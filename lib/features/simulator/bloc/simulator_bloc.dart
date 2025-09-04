import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rendify/core/models/stock_model.dart';
import 'simulator_event.dart';
import 'simulator_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SimulatorBloc extends Bloc<SimulatorEvent, SimulatorState> {
  final http.Client client;

  SimulatorBloc(this.client) : super(SimulatorInitial()) {
    on<FetchBalance>((event, emit) async {
      emit(SimulatorLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('access_token'); 
        if (token == null) {
          emit(SimulatorError("Token não encontrado, faça login novamente"));
          return;
        }

        final response = await client.get(
          Uri.parse("${dotenv.get('API_URL')}/user/viewme"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
        );

        final responseStocks = await client.get(
          Uri.parse("${dotenv.get('API_URL')}/simulator/"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final stockList = json.decode(responseStocks.body);
          final List<StockModel> stocks = [];

          if (stockList is List) {
            for (final stock in stockList) {
              stocks.add(StockModel.fromJson(stock));
            }
          } else {
            debugPrint("Resposta inesperada em /simulator/: $stockList");
          }

          final balance = (data["balance"] as num).toDouble();
          emit(SimulatorLoaded(balance, stocks));
        } else {
          emit(SimulatorError(
              "Erro ao buscar balance: ${response.statusCode}"));
        }
      } catch (e, st) {
        debugPrint("Erro no FetchBalance: $e\n$st");
        emit(SimulatorError("Erro: ${e.toString()}"));
      }
    });
  }
}
