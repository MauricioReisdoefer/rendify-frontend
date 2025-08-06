abstract class LoginEvent {}

class LoginNameChanged extends LoginEvent {
  final String name;
  LoginNameChanged(this.name);
}

class LoginPasswordChanged extends LoginEvent {
  final String password;
  LoginPasswordChanged(this.password);
}

class LoginSubmitted extends LoginEvent {}
