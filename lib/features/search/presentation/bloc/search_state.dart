class SearchState {
  final String name;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  SearchState({
    required this.name,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  factory SearchState.initial() => SearchState(
        name: '',
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
      );

  SearchState copyWith({
    String? name,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return SearchState(
      name: name ?? this.name,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}
