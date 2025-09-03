import 'dart:convert';
import 'package:http/http.dart' as http;
import 'settings_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  final http.Client client;
  final String baseUrl = "${dotenv.get('API_URL')}/user";

  SettingsRepository(this.client);

  Future<SettingsUser> changeBalance(double newBalance) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.get('access_token');
      final response = await http.put(
        Uri.parse("$baseUrl/updateme"),
        headers: {"Content-Type": "application/json", "Authorization":"Bearer ${token}"},
        body: jsonEncode({
          "balance": newBalance,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (!responseData.containsKey("msg")) {
          return SettingsUser.fromJson(responseData);
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
    
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('access_token');
    final response = await http.get(
      Uri.parse("$baseUrl/viewme"),
      headers: {"Content-Type": "application/json", "Authorization":"Bearer ${token}"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)["balance"];
      return SettingsUser.fromJson(data);
    } else {
      throw Exception("Erro ao obter saldo");
    }
  }
}