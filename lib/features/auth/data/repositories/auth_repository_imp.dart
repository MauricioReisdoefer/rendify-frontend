import 'dart:convert';
import 'package:rendify/core/services/http_service.dart';
import 'package:rendify/core/models/user_model.dart';
import 'package:rendify/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final HttpService client;

  AuthRepositoryImpl(this.client);

  @override
  Future<UserModel> register(String nome, String senha) async {
    final response = await client.post(
      'http://localhost:5000/user/register',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': nome, 'password': senha}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data["Result"]);
    } else {
      throw Exception('Erro ao registrar: ${response.body}');
    }
  }

  @override
  Future<UserModel> login(String nome, String senha) async {
    final response = await client.post(
      'http://localhost:5000/user/login',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': nome, 'password': senha}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data["Result"]);
    } else {
      throw Exception('Erro ao fazer login: ${response.body}');
    }
  }
}
