import 'package:flutter/material.dart';
import 'package:app_wallet/models/account_model.dart';
import 'package:app_wallet/repositories/account_repository.dart';

class AccountViewModel extends ChangeNotifier {
  final AccountRepository _accountRepository;

  AccountViewModel(this._accountRepository);

  List<AccountModel> _accounts = [];
  List<AccountModel> get accounts => _accounts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadAccounts(int userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _accounts = await _accountRepository.fetchAllAccounts(userId);
    } catch (e) {
      debugPrint("Erreur lors du chargement des comptes: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
