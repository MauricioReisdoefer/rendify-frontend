import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'package:rendify/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:rendify/core/models/user_model.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepositoryImpl authRepository;

  LoginBloc({required this.authRepository}) : super(LoginState.initial()) {
    on<LoginNameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, isFailure: false, isSuccess: false));
      try {
        final UserModel user = await authRepository.login(
          state.name,
          state.password,
        );

        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } catch (e) {
        emit(state.copyWith(isSubmitting: false, isFailure: true));
      }
    });
  }
}