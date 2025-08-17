abstract class HomeWatchlistEvent {}

class FetchHomeWatchlist extends HomeWatchlistEvent {
  final int userId;
  FetchHomeWatchlist(this.userId);
}