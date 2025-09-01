import 'dart:convert';
import 'package:rendify/core/services/http_service.dart';
import 'package:rendify/core/models/stock_model.dart';
import 'package:rendify/features/search/domain/repository/search_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchRepositoryImpl implements SearchRepository {
  final HttpService client;

  SearchRepositoryImpl(this.client);

  Future<List<StockModel>> search(String symbol) async {
    final response = await client.get(
      '${dotenv.get('API_URL')}/stock/search/$symbol',
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
          ammount: int.parse(item['ammount' as num])
        ));
      }

      return stockModels;
    } else {
      throw Exception('Failed to fetch stocks');
    }
  }
}