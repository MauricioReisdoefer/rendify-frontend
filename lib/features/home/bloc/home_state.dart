import "home_model.dart";

abstract class HomeWatchlistState {}

class HomeWatchlistLoading extends HomeWatchlistState {}

class HomeWatchlistLoaded extends HomeWatchlistState {
  final List<WatchItem> items;
  HomeWatchlistLoaded(this.items);
}

class HomeWatchlistError extends HomeWatchlistState {
  final String message;
  HomeWatchlistError(this.message);
}