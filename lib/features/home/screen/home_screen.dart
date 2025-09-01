import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rendify/shared/components/stock_list.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../bloc/home_event.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          HomeWatchlistBloc(http.Client())..add(FetchHomeWatchlist()),
      child: Scaffold(
        body: BlocBuilder<HomeWatchlistBloc, HomeWatchlistState>(
          builder: (context, state) {
            if (state is HomeWatchlistLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeWatchlistLoaded) {
              return state.items.length < 1
                  ? Center(
                      child: Text(
                          textAlign: TextAlign.center,
                          "Você ainda não possui nenhuma ação em sua WacthList."
                              .tr()))
                  : StockList(
                      lista: state.items,
                      icon: Icons.star,
                      function: (symbol) {
                        context.read<HomeWatchlistBloc>().add(
                              RemoveFromWatchlist(
                                symbol: symbol),
                            );
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "$symbol foi removido da sua WatchList".tr())));
                      },
                    );
            } else if (state is HomeWatchlistError) {
              return Center(
                  child: Text(
                state.message,
                textAlign: TextAlign.center,
              ));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
