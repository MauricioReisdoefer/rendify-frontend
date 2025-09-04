import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rendify/core/services/http_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'buy_event.dart';
import 'buy_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {

  final HttpService client;

  StockBloc({required double initialPrice, required int initialQuantity, required this.client, required String symbol})
      : super(StockState(price: initialPrice, quantity: initialQuantity, symbol: symbol)) {
    
    on<BuyStock>((event, emit) async {
      debugPrint("COMPRANDO ${event.quantity}");

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.get('access_token');
      final response = await client.post(
        '${dotenv.get('API_URL')}/simulator/add',
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${token}"
        },
        body: jsonEncode({
          "symbol": "${state.symbol}",
          "exchange": "NASDAQ",
          "ammount": event.quantity
        })
      );

      if(response.statusCode != 200){
        emit(StockError(msg: "Saldo insuficiente", price: state.price, quantity: state.quantity, symbol: symbol));
      }

      final decoded = jsonDecode(response.body);
      emit(state.copyWith(quantity: decoded["ammount"]));
    });

    on<SellStock>((event, emit) async {

      int sellQuantity = 0;
      if (event.quantity > state.quantity){
        sellQuantity = state.quantity;
      } else {sellQuantity = event.quantity;}
      debugPrint("TENHO ${state.quantity}");
      debugPrint("VENDENDO ${sellQuantity}");
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.get('access_token');
      final response = await client.post(
        '${dotenv.get('API_URL')}/simulator/add',
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${token}"
        },
        body: jsonEncode({
          "symbol": "${state.symbol}",
          "exchange": "NASDAQ",
          "ammount": -sellQuantity
        }));

      if(response.statusCode != 200){
        emit(StockError(msg: "Você não possue ações o suficiente", price: state.price, quantity: state.quantity, symbol: symbol));
      }
      
      final decoded = jsonDecode(response.body);
      emit(state.copyWith(quantity: decoded["ammount"]));
    });
  }
}
