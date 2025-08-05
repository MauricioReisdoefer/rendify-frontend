import 'package:rendify/core/models/user_model.dart';
import 'package:rendify/features/auth/domain/repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

 LoginUser(this.repository);

  Future<UserModel> execute(String nome, String senha) {
    return repository.register(nome, senha);
  }
}