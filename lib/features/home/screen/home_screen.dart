import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rendify/shared/components/stock_list.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../bloc/home_event.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  final int userId;
  const HomeScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          HomeWatchlistBloc(http.Client())..add(FetchHomeWatchlist(userId)),
      child: Scaffold(
        body: BlocBuilder<HomeWatchlistBloc, HomeWatchlistState>(
          builder: (context, state) {
            if (state is HomeWatchlistLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeWatchlistLoaded) {
              return StockList(state.items);
            } else if (state is HomeWatchlistError) {
              return Center(child: Text(state.message, textAlign: TextAlign.center,));
            }
            return Container();
          },
        ),
      ),
    );
  }
}