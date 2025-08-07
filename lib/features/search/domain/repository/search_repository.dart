import 'package:rendify/core/models/stock_model.dart';

abstract class SearchRepository {
  Future<StockModel> register(String nome, String senha);
  Future<StockModel> login(String nome, String senha);
}
