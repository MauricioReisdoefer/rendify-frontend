import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'register_event.dart';
import 'register_state.dart';
import 'package:rendify/core/models/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState.initial()) {
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

      // Valida se senhas coincidem
      if (event.password != event.confirmPassword) {
        emit(state.copyWith(
          isSubmitting: false,
          isFailure: true,
        ));
        return;
      }

      try {
        final response = await http.post(
          Uri.parse('${dotenv.get('API_URL')}/user/register'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'name': event.name,
            'password': event.password,
          }),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final data = jsonDecode(response.body);
          final user = UserModel.fromJson(data['Result']);

          emit(state.copyWith(
            isSubmitting: false,
            isSuccess: true,
            user: user,
          ));
        } else {
          emit(state.copyWith(
            isSubmitting: false,
            isFailure: true,
          ));
        }
      } catch (_) {
        emit(state.copyWith(
          isSubmitting: false,
          isFailure: true,
        ));
      }
    });
  }
}
