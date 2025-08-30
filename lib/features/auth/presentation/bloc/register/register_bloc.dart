import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rendify/features/auth/data/repositories/auth_repository_imp.dart';
import 'register_event.dart';
import 'register_state.dart';
import 'package:rendify/core/models/user_model.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepositoryImpl authRepository;

  RegisterBloc({required this.authRepository}) : super(RegisterState.initial()) {
    on<RegisterNameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<RegisterPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<RegisterConfirmPasswordChanged>((event, emit) {
      emit(state.copyWith(confirmPassword: event.confirmPassword));
    });

    on<RegisterSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, isFailure: false, isSuccess: false));

      if (event.password != event.confirmPassword) {
        emit(state.copyWith(
          isSubmitting: false,
          isFailure: true,
        ));
        return;
      }

      try {
        
        //
        // Implement API Connection
        //

        emit(state.copyWith(
          isSubmitting: false,
          isSuccess: true,
          user: user,
        ));
      } catch (e) {
        emit(state.copyWith(
          isSubmitting: false,
          isFailure: true,
        ));
      }
    });
  }
}
