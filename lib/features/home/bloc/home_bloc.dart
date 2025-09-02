import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_model.dart';
import 'home_event.dart';
import 'home_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeWatchlistBloc extends Bloc<HomeWatchlistEvent, HomeWatchlistState> {
  final http.Client client;

  HomeWatchlistBloc(this.client) : super(HomeWatchlistLoading()) {
    on<FetchHomeWatchlist>((event, emit) async {
      emit(HomeWatchlistLoading());

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.get('access_token');

      try {
        final response = await client.get(
          Uri.parse('${dotenv.get('API_URL')}/watchlist/'),
          headers: {'Content-Type': 'application/json', "Authorization":"Bearer ${token}"},
        );

        print(json.decode(response.body));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final List<dynamic> result = [];
          for (Map item in data){
            result.add(item);
          }
          final items = result
              .map((e) => WatchItem(symbol: e['symbol'], price: e['price']))
              .toList();
          emit(HomeWatchlistLoaded(items));
        } else {
          emit(HomeWatchlistError("Erro ao carregar a Watchlist.\nTeste sua conexão e tente novamente.".tr()));
        }
      } catch (e) {
        emit(HomeWatchlistError(e.toString()));
      }
    });

    on<RemoveFromWatchlist>((event, emit) async {
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.get('access_token');
        final response = await client.delete(
          Uri.parse('${dotenv.get('API_URL')}/watchlist/${event.symbol}'),
          headers: {'Content-Type': 'application/json', "Authorization":"Bearer ${token}"},
        );

        if (response.statusCode == 200) {
          // Se a watchlist já estava carregada, atualiza a lista removendo o item
          if (state is HomeWatchlistLoaded) {
            final currentState = state as HomeWatchlistLoaded;
            final updatedList = currentState.items
                .where((item) => item.symbol != event.symbol)
                .toList();

            emit(HomeWatchlistLoaded(updatedList));
          }
        } else {
          emit(HomeWatchlistError("Erro ao remover ${event.symbol}".tr()));
        }
      } catch (e) {
        emit(HomeWatchlistError("Erro de conexão ao remover ${event.symbol}".tr()));
      }
    });
  }
}
