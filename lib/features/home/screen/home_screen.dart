import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rendify/core/services/http_service.dart';
import 'package:rendify/features/home/bloc/home_bloc.dart';
import 'package:rendify/features/home/bloc/home_event.dart';
import 'package:rendify/features/home/bloc/home_repository.dart';
import 'package:rendify/features/home/bloc/home_state.dart';
import 'package:rendify/core/models/stock_model.dart';
import 'package:http/http.dart' as http_client;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(homeRepository: HomeRepository(HttpService(http_client.Client())))..add(HomeStart([])),
      child: Scaffold(
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.stocks.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: state.stocks.length,
              itemBuilder: (context, index) {
                StockModel stock = state.stocks[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(stock.symbol),
                    subtitle: Text("${stock.price}"),
                    trailing: const Icon(Icons.star),
                    tileColor: const Color(0xFFEEEEEE),
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
