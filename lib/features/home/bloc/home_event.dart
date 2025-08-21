abstract class HomeWatchlistEvent {}

class FetchHomeWatchlist extends HomeWatchlistEvent {
  final int userId;
  FetchHomeWatchlist(this.userId);
}

class RemoveFromWatchlist extends HomeWatchlistEvent {
  final int userId;
  final String symbol;
  RemoveFromWatchlist({required this.userId, required this.symbol});
}