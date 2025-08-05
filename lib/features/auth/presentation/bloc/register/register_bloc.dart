import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rendify/features/auth/domain/usercases/register_user.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUser registerUser;

  RegisterBloc(this.registerUser) : super(RegisterInitial()) {
    on<SubmitRegister>((event, emit) async {
      emit(RegisterLoading());
      try {
        final user = await registerUser.execute(
          event.nome,
          event.senha,
          event.confirmarSenha,
        );
        emit(RegisterSuccess(user));
      } catch (e) {
        emit(RegisterError(e.toString()));
      }
    });
  }
}
