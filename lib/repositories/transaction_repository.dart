import 'package:app_wallet/models/transaction_model.dart';

abstract class TransactionRepository {
  Future<List<TransactionModel>> fetchTransactions(int accountId);
  Future<TransactionModel> fetchTransaction(int transactionId);
}