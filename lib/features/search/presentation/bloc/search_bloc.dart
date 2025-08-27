import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rendify/core/models/stock_model.dart';
import 'package:rendify/features/search/data/repository/search_repository_impl.dart';
import 'search_event.dart';
import 'search_state.dart';
import 'package:rendify/features/search/data/repository/watchlist_repository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepositoryImpl searchRepository;
  final WatchlistRepository watchlistRepository;

  SearchBloc({
    required this.searchRepository,
    required this.watchlistRepository,
  }) : super(SearchState.initial()) {
    on<SearchChanged>((event, emit) {
      emit(state.copyWith(symbol: event.symbol));
    });

    on<SearchSubmitted>((event, emit) async {
      emit(state.copyWith(
          isSubmitting: true, isFailure: false, isSuccess: false));
      try {
        final List<StockModel> stocks = await searchRepository.search(
          event.symbol,
        );

        emit(state.copyWith(
          isSubmitting: false,
          isSuccess: true,
          value: stocks[0].price,
          symbol: stocks[0].symbol,
        ));
      } catch (e) {
        emit(state.copyWith(isSubmitting: false, isFailure: true));
      }
    });

    on<AddToWatchlistEvent>((event, emit) async {
      try {
        await watchlistRepository.addToWatchlist(event.userId, event.symbol);
        emit(WatchlistSuccess(
          message: "Ação adicionada à Watchlist",
          isFailure: false,
          isSubmitting: false,
          isSuccess: true,
          symbol: event.symbol,
          has_showed: true,
          value: 0,
        ));
      } catch (e) {
        emit(WatchlistError(
          message: "Falha ao adicionar à Watchlist",
          isFailure: true,
          isSubmitting: false,
          isSuccess: false,
          symbol: 'event.symbol',
          has_showed: false,
          value: 0,
        ));
      }
    });
  }
}
