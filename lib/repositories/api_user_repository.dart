import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_wallet/models/user_model.dart';
import 'package:app_wallet/repositories/user_repository.dart';

class ApiUserRepository implements UserRepository {
  static const String _baseUrl = "https://api.mocki.io/v2/8d7f3ljd/users";

  @override
  Future<List<UserModel>> fetchAllUsers() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception("Erreur de chargement des utilisateurs");
    }
  }
}