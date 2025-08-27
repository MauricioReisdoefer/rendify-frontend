abstract class SearchEvent {}

class SearchChanged extends SearchEvent {
  final String symbol;
  SearchChanged(this.symbol);
}

class SearchSubmitted extends SearchEvent {
  final String symbol;

  SearchSubmitted({required this.symbol});
}

class AddToWatchlistEvent extends SearchEvent {
  final int userId;
  final String symbol;
  AddToWatchlistEvent(this.userId, this.symbol);
}