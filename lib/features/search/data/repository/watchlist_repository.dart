import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WatchlistRepository {
  final http.Client client;
  WatchlistRepository(this.client);

  Future<void> addToWatchlist(String symbol) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('access_token');
    final res = await client.post(
      Uri.parse('${dotenv.get('API_URL')}/watchlist/add/$symbol'),
      headers: {'Content-Type': 'application/json', "Authorization":"Bearer ${token}"}, 
    );
    if (res.statusCode != 200 && res.statusCode != 201) {
      throw Exception('Falha ao adicionar: ${res.statusCode} → ${res.body}');
    }
  }
}