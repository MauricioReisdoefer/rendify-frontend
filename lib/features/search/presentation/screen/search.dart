import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:rendify/features/search/presentation/bloc/search_bloc.dart';
import 'package:rendify/features/search/presentation/bloc/search_state.dart';
import 'package:rendify/features/search/presentation/bloc/search_event.dart';
import 'package:rendify/features/search/data/repository/search_repository_impl.dart';
import 'package:rendify/core/services/http_service.dart';
import 'package:http/http.dart' as http_client;
import 'package:rendify/core/models/stock_model.dart';

final HttpService http = HttpService(http_client.Client());

class SearchPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(
        searchRepository: SearchRepositoryImpl(http),
      ),
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
                            context.read<SearchBloc>().add(SearchSubmitted(symbol:symbol));
                          }
                        },
                      ),
                    ),
                    onChanged: (value) {
                      context.read<SearchBloc>().add(SearchChanged(value));
                    },
                  ),
                ),
                if (state.isSubmitting) ...[
                  const Center(child: CircularProgressIndicator()),
                ] else if (state.isFailure) ...[
                  Center(child: Text("Erro".tr())),
                ] else if (state.isSuccess && state.symbol.isNotEmpty) ...[
                  Center(child: Text("${state.symbol}")),
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
