import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<LoginNameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, isFailure: false, isSuccess: false));

      try {
        final loginResponse = await http.post(
          Uri.parse('http://localhost:5000/user/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'name': event.name, 'password': event.password}),
        );

        if (loginResponse.statusCode == 200) {
          final data = jsonDecode(loginResponse.body);
          final token = data['access_token'];

          // Salva o token no SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', token);

          emit(state.copyWith(
            isSubmitting: false,
            isSuccess: true,
            id: token,
          ));
        } else {
          emit(state.copyWith(
            isSubmitting: false,
            isFailure: true,
          ));
        }
      } catch (_) {
        emit(state.copyWith(isSubmitting: false, isFailure: true));
      }
    });
  }
}
