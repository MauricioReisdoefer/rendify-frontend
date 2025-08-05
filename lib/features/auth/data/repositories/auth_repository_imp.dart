import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rendify/core/models/user_model.dart';
import 'package:rendify/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final http.Client client;

  AuthRepositoryImpl(this.client);

  @override
  Future<UserModel> register(String nome, String senha) async {
    final response = await client.post(
      Uri.parse('https://localhost:5050/user/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': nome, 'password': senha}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw Exception('Erro ao registrar: ${response.body}');
    }
  }

  @override
  Future<UserModel> login(String nome, String senha) async {
    final response = await client.post(
      Uri.parse('https://localhost:5050/user/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': nome, 'password': senha}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw Exception('Erro ao fazer login: ${response.body}');
    }
  }
}
