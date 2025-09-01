import 'dart:convert';
import 'package:http/http.dart' as http;
import 'settings_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SettingsRepository {
  final http.Client client;
  final String baseUrl = "${dotenv.get('API_URL')}/user";

  SettingsRepository(this.client);

  Future<SettingsUser> changeBalance(double newBalance) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/change_balance/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "new_balance": newBalance,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData.containsKey("Result")) {
          final data = responseData["Result"];
          return SettingsUser.fromJson(data);
        } else {
          throw Exception(
              "Campo de resposta não encontrado na resposta da API");
        }
      } else {
        throw Exception("Erro ao mudar saldo: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao alterar saldo: $e");
      rethrow;
    }
  }

  Future<SettingsUser> getUserByName(String name) async {
    final response = await http.get(
      Uri.parse("$baseUrl/get_by_name/$name"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)["Result"];
      return SettingsUser.fromJson(data);
    } else {
      throw Exception("Erro ao obter saldo");
    }
  }
}