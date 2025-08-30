abstract class RegisterEvent {}

class RegisterNameChanged extends RegisterEvent {
  final String name;
  RegisterNameChanged(this.name);
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;
  RegisterPasswordChanged(this.password);
}

class RegisterConfirmPasswordChanged extends RegisterEvent {
  final String confirmPassword;
  RegisterConfirmPasswordChanged(this.confirmPassword);
}

class RegisterSubmitted extends RegisterEvent {
  final String name;
  final String password;
  final String confirmPassword;

  RegisterSubmitted({
    required this.name,
    required this.password,
    required this.confirmPassword,
  });
}
