import 'package:app_wallet/models/user_model.dart';

abstract class UserRepository {
  Future<List<UserModel>> fetchAllUsers();
}