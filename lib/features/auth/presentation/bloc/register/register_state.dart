import 'package:equatable/equatable.dart';
import 'package:rendify/core/models/user_model.dart';

class RegisterState {
  final String name;
  final String password;
  final String confirmPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final UserModel? user;

  RegisterState({
    required this.name,
    required this.password,
    required this.confirmPassword,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    this.user,
  });

  factory RegisterState.initial() => RegisterState(
        name: '',
        password: '',
        confirmPassword: '',
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
      );

  RegisterState copyWith({
    String? name,
    String? password,
    String? confirmPassword,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    UserModel? user,
  }) {
    return RegisterState(
      name: name ?? this.name,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      user: user ?? this.user,
    );
  }
}
