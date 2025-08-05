import 'package:rendify/core/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> register(String nome, String senha);
  Future<UserModel> login(String nome, String senha);
}
