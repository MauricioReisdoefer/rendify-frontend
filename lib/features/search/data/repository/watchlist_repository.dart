import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WatchlistRepository {
  final http.Client client;
  WatchlistRepository(this.client);

  Future<void> addToWatchlist(int userId, String symbol) async {
    final res = await client.post(
      Uri.parse('${dotenv.get('API_URL')}/watch/add/$userId/$symbol'),
      headers: {'Content-Type': 'application/json'},
    );
    if (res.statusCode != 200 && res.statusCode != 201) {
      throw Exception('Falha ao adicionar: ${res.statusCode} → ${res.body}');
    }
  }
}