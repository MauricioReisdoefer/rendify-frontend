import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rendify/features/home/bloc/home_model.dart';
import 'package:rendify/features/search/data/repository/watchlist_repository.dart';

import 'package:rendify/features/search/presentation/bloc/search_bloc.dart';
import 'package:rendify/features/search/presentation/bloc/search_state.dart';
import 'package:rendify/features/search/presentation/bloc/search_event.dart';
import 'package:rendify/features/search/data/repository/search_repository_impl.dart';
import 'package:rendify/core/services/http_service.dart';
import 'package:http/http.dart' as http_client;
import 'package:rendify/shared/components/stock_list.dart';

final HttpService http = HttpService(http_client.Client());

class SearchPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final int userId;

  SearchPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(
          searchRepository: SearchRepositoryImpl(http),
          watchlistRepository: WatchlistRepository(http.client)),
      child: Scaffold(
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFEEEEEE),
                      hintText: "Buscar".tr(),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 0)),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          final symbol = _controller.text.trim();
                          if (symbol.isNotEmpty) {
                            context
                                .read<SearchBloc>()
                                .add(SearchSubmitted(symbol: symbol));
                          }
                        },
                      ),
                    ),
                  ),
                ),
                if (state.isSubmitting) ...[
                  const Center(child: CircularProgressIndicator()),
                ] else if (state.isFailure) ...[
                  Center(
                      child: Text(
                        textAlign: TextAlign.center,
                          "Erro ao carregar as ações disponíveis.\nTeste sua conexão ou verifique o nome da ação."
                              .tr())),
                ] else if (state.isSuccess &&
                    state.symbol.isNotEmpty &&
                    state.has_showed == false) ...[
                  Container(
                    height: 400,
                    child: StockList(
                      lista: [WatchItem(symbol: state.symbol, price: state.value)],
                      icon: Icons.star_border,
                      function: (symbol) {
                        context
                            .read<SearchBloc>()
                            .add(AddToWatchlistEvent(userId, state.symbol));
                      },
                    ),
                  ),
                ] else ...[
                  Center(child: Text("Nenhuma pesquisa feita".tr())),
                ]
              ],
            );
          },
        ),
      ),
    );
  }
}
