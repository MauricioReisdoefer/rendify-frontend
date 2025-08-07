class SearchState {
  final String symbol;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  SearchState({
    required this.symbol,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  factory SearchState.initial() => SearchState(
        symbol: '',
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
      );

  SearchState copyWith({
    String? symbol,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure
  }) {
    return SearchState(
      symbol: symbol ?? this.symbol,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}
