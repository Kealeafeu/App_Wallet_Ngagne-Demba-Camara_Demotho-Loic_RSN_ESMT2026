import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_wallet/models/account_model.dart';
import 'package:app_wallet/repositories/account_repository.dart';

class ApiAccountRepository implements AccountRepository {
  static const String _baseUrl = "https://api.mocki.io/v2/8d7f3ljd/accounts";

  @override
  Future<List<AccountModel>> fetchAllAccounts(int userId) async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data
          .where((json) => json['userId'] == userId)
          .map((json) => AccountModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Erreur de chargement des comptes");
    }
  }

  @override
  Future<AccountModel> fetchAccount(int accountId) async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      final json = data.firstWhere((item) => item['id'] == accountId);
      return AccountModel.fromJson(json);
    } else {
      throw Exception("Erreur de chargement du compte");
    }
  }
}