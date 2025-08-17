import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rendify/core/models/stock_model.dart';
import 'package:rendify/features/search/data/repository/search_repository_impl.dart';
import 'package:rendify/features/search/domain/repository/search_repository.dart';
import 'search_event.dart';
import 'search_state.dart';
import 'package:rendify/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:rendify/core/models/user_model.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepositoryImpl searchRepository;

  SearchBloc({required this.searchRepository}) : super(SearchState.initial()){
    on<SearchChanged>((event, emit) {
      emit(state.copyWith(symbol: event.symbol));
    });

    on<SearchSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, isFailure: false, isSuccess: false));
      try {
        final List<StockModel> stocks = await searchRepository.search(
          event.symbol, 
        );

        emit(state.copyWith(isSubmitting: false, isSuccess: true, value: stocks[0].price, symbol: stocks[0].symbol ));
      } catch (e) {
        emit(state.copyWith(isSubmitting: false, isFailure: true));
      }
    });
  }
}