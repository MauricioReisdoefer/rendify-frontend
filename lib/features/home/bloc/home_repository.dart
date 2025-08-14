import 'package:rendify/core/models/stock_model.dart';
import 'dart:convert';
import 'package:rendify/core/services/http_service.dart';

class HomeRepository {
  final HttpService client;

  HomeRepository(this.client);

  Future<List<StockModel>> getWatchlist(int id) async {
    final response = await client.get(
      'http://localhost:5000/watch/view/$id',
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> successList = data['Success'] ?? [];

      List<StockModel> stockModels = [];

      for (var item in successList) {
        stockModels.add(StockModel(
          symbol: item['symbol'],
          price: (item['price'] as num).toDouble(),
        ));
      }

      return stockModels;
    } else {
      throw Exception('Failed to fetch stocks');
    }
  }
}