class SearchState {
  final String symbol;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool has_showed;
  final double value;

  SearchState(
      {required this.symbol,
      required this.isSubmitting,
      required this.isSuccess,
      required this.isFailure,
      required this.has_showed,
      required this.value});

  factory SearchState.initial() => SearchState(
      symbol: '',
      isSubmitting: false,
      isSuccess: false,
      has_showed: false,
      isFailure: false,
      value: 0.00);

  SearchState copyWith(
      {String? symbol,
      bool? isSubmitting,
      bool? isSuccess,
      bool? isFailure,
      double? value}) {
    return SearchState(
        symbol: symbol ?? this.symbol,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure,
        has_showed: has_showed ?? this.has_showed,
        value: value ?? this.value);
  }
}

class WatchlistSuccess extends SearchState {
  final String message;
  WatchlistSuccess(
      {required super.symbol,
      required super.isSubmitting,
      required super.isSuccess,
      required super.isFailure,
      required super.has_showed,
      required super.value,
      required this.message});
}

class WatchlistError extends SearchState {
  final String message;
  WatchlistError(
      {required super.symbol,
      required super.isSubmitting,
      required super.isSuccess,
      required super.isFailure,
      required super.has_showed,
      required super.value,
      required this.message});
}
