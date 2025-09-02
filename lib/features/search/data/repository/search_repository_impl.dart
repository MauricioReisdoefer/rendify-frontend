import 'dart:convert';
import 'package:rendify/core/services/http_service.dart';
import 'package:rendify/core/models/stock_model.dart';
import 'package:rendify/features/search/domain/repository/search_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchRepositoryImpl implements SearchRepository {
  final HttpService client;

  SearchRepositoryImpl(this.client);

  Future<List<StockModel>> search(String symbol) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('access_token');
    final response = await client.get(
      '${dotenv.get('API_URL')}/stock/search/$symbol',
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${token}"
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      List<StockModel> stockModels = [];

      print(data['price'] );
      print(data['symbol'] );

      stockModels.add(StockModel(
        symbol: data['symbol'],
        price: (data['price'] as num).toDouble(),
      ));

      return stockModels;
    } else {
      throw Exception('Failed to fetch stocks');
    }
  }
}
