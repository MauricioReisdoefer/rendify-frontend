import 'package:flutter_bloc/flutter_bloc.dart';
import 'buy_event.dart';
import 'buy_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  StockBloc({required double initialPrice, required int initialQuantity})
      : super(StockState(price: initialPrice, quantity: initialQuantity)) {
    
    on<BuyStock>((event, emit) {
      int newQuantity = state.quantity + event.quantity;
      emit(state.copyWith(quantity: newQuantity));
    });

    on<SellStock>((event, emit) {
      int newQuantity = state.quantity - event.quantity;
      if (newQuantity < 0) newQuantity = 0;
      emit(state.copyWith(quantity: newQuantity));
    });
  }
}
