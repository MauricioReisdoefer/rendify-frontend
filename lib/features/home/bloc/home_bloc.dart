import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_model.dart';
import 'home_event.dart';
import 'home_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';

class HomeWatchlistBloc extends Bloc<HomeWatchlistEvent, HomeWatchlistState> {
  final http.Client client;

  HomeWatchlistBloc(this.client) : super(HomeWatchlistLoading()) {
    on<FetchHomeWatchlist>((event, emit) async {
      emit(HomeWatchlistLoading());
      try {
        final response = await client.get(
          Uri.parse('http://localhost:5000/watch/view/${event.userId}'),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final List<dynamic> result = data["Result"];
          final items = result.map((e) => WatchItem(symbol: e['symbol'], price: e['price'])).toList();
          emit(HomeWatchlistLoaded(items));
        } else {
          emit(HomeWatchlistError("Erro ao carregar a Watchlist.\nTeste sua conexão e tente novamente.".tr()));
        }
      } catch (e) {
        emit(HomeWatchlistError("Erro ao carregar a Watchlist.\nTeste sua conexão e tente novamente.".tr()));
      }
    });
  }
}
