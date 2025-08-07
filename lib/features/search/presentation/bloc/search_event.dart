abstract class SearchEvent {}

class SearchChanged extends SearchEvent {
  final String name;
  SearchChanged(this.name);
}

class SearchSubmitted extends SearchEvent {
  final String name;
  final String password;

  SearchSubmitted({required this.name, required this.password});
}
