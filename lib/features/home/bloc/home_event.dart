import 'package:rendify/core/models/stock_model.dart';

abstract class HomeEvent {}

class HomeChanged extends HomeEvent {
  final List<StockModel> stocks;
  HomeChanged(this.stocks);
}

class HomeStart extends HomeEvent {
  final List<StockModel> stocks;
  HomeStart(this.stocks);
}