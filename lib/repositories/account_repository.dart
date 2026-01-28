import 'package:app_wallet/models/account_model.dart';

abstract class AccountRepository {
  Future<List<AccountModel>> fetchAllAccounts(int userId);
  Future<AccountModel> fetchAccount(int accountId);
}