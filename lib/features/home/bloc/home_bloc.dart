import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rendify/core/models/stock_model.dart';
import 'package:rendify/features/home/bloc/home_state.dart';
import 'package:rendify/features/home/bloc/home_event.dart';
import 'package:rendify/features/home/bloc/home_repository.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState > {
  final HomeRepository homeRepository;

  HomeBloc({required this.homeRepository}) : super(HomeState.initial()){
    on<HomeChanged>((event, emit) async {
      List<StockModel> stock_list = await homeRepository.getWatchlist(0);
      emit(state.copyWith(stocks: stock_list));
    });

    on<HomeStart>((event, emit) async {
      List<StockModel> stock_list = await homeRepository.getWatchlist(0);
      emit(state.copyWith(stocks: stock_list));
    });
}}