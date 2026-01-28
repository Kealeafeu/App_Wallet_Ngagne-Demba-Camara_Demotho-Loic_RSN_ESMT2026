import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_wallet/models/transaction_model.dart';
import 'package:app_wallet/repositories/transaction_repository.dart';

class ApiTransactionRepository implements TransactionRepository {
  static const String _baseUrl = "https://api.mocki.io/v2/8d7f3ljd/transaction";

  @override
  Future<List<TransactionModel>> fetchTransactions(int accountId) async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data
          .where((json) => json['accountId'] == accountId)
          .map((json) => TransactionModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Erreur de chargement des transactions");
    }
  }

  @override
  Future<TransactionModel> fetchTransaction(int transactionId) async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      final json = data.firstWhere((item) => item['id'] == transactionId);
      return TransactionModel.fromJson(json);
    } else {
      throw Exception("Erreur de chargement de la transaction");
    }
  }
}