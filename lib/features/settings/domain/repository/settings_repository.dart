import 'package:rendify/core/models/stock_model.dart';

abstract class SearchRepository {
  Future<List<StockModel>> search(String symbol);
}
