abstract class HomeWatchlistEvent {}

class FetchHomeWatchlist extends HomeWatchlistEvent {
  FetchHomeWatchlist();
}

class RemoveFromWatchlist extends HomeWatchlistEvent {
  final String symbol;
  RemoveFromWatchlist({required this.symbol});
}