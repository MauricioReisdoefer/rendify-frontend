import 'package:rendify/core/models/stock_model.dart';

class HomeState {
  final List<StockModel> stocks;
  final bool isSuccess;
  final bool isFailure;
  final bool has_showed;

  HomeState({
    required List<StockModel> this.stocks,
    required this.isSuccess,
    required this.isFailure,
    required this.has_showed,
  });

  factory HomeState.initial() => HomeState(
        stocks: [],
        isSuccess: false,
        has_showed: false,
        isFailure: false,
      );

  HomeState copyWith({
    List<StockModel>? stocks,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return HomeState(
      stocks: stocks ?? this.stocks,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      has_showed: has_showed ?? this.has_showed,
    );
  }
}
