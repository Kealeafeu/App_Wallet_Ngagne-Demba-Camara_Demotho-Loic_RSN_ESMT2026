import 'package:flutter/material.dart';
import 'package:app_wallet/models/transaction_model.dart';
import 'package:app_wallet/repositories/transaction_repository.dart';

class TransactionViewModel extends ChangeNotifier {
  final TransactionRepository _transactionRepository;

  TransactionViewModel(this._transactionRepository);

  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadTransactions(int accountId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _transactions = await _transactionRepository.fetchTransactions(accountId);
    } catch (e) {
      debugPrint("Erreur lors du chargement des transactions: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}