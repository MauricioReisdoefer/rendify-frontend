import 'package:http/http.dart' as http;

class WatchlistRepository {
  final http.Client client;
  WatchlistRepository(this.client);

  Future<void> addToWatchlist(int userId, String symbol) async {
    final res = await client.post(
      Uri.parse('http://localhost:5000/watch/add/$userId/$symbol'),
      headers: {'Content-Type': 'application/json'},
    );
    if (res.statusCode != 200 && res.statusCode != 201) {
      throw Exception('Falha ao adicionar: ${res.statusCode} → ${res.body}');
    }
  }
}