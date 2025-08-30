class LoginState {
  final String name;
  final String password;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String id;
  final String token;

  LoginState({
    required this.name,
    required this.password,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    required this.id,
    required this.token
  });

  factory LoginState.initial() => LoginState(
        name: '',
        password: '',
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        id: '',
        token: ''
      );

  LoginState copyWith({
    String? name,
    String? password,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    String? id,
    String? token,
  }) {
    return LoginState(
      name: name ?? this.name,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      id: id ?? this.id,
      token: token ?? this.token
    );
  }
}
