import 'package:rendify/core/models/user_model.dart';
import 'package:rendify/features/auth/domain/repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<UserModel> execute(String nome, String senha, String confirmarSenha) {
    if (senha != confirmarSenha) {
      throw Exception("Senhas não coincidem");
    }
    return repository.register(nome, senha);
  }
}