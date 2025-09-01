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
        final token = prefs.get('access_token');
        final response = await client.get(
          Uri.parse("${dotenv.get('API_URL')}/user/viewme"),
          headers: {"Content-Type": "application/json", "Authorization":"Bearer ${token}"},
        );

        final responseStocks = await client.get(
          Uri.parse("${dotenv.get('API_URL')}/simulator/"),
          headers: {"Content-Type": "application/json", "Authorization":"Bearer ${token}"}
        );
        debugPrint("Aqui deu erro krlh");
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          debugPrint("Aqui deu erro krlh");
          final stockList = json.decode(responseStocks.body);

          List<StockModel> stocks = [];
          debugPrint("***************");
          debugPrint("CREATING STOCKS");
          debugPrint("***************");
          for(final stock in stockList){
            debugPrint("***************");
            debugPrint("CREATING ");
            debugPrint("***************");
            stocks.add(StockModel.fromJson(stock));
          }
          final balance = data["balance"] as num; // pode ser double ou int
          emit(SimulatorLoaded(balance.toDouble(), stocks));
        } else {
          emit(SimulatorError("Erro ao buscar balance"));
        }
      } catch (e) {
        emit(SimulatorError("Erro: ${e.toString()}"));
      }
    });
  }
}