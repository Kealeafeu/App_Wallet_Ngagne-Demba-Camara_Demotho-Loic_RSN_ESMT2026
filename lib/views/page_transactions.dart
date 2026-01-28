import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_wallet/view_models/transaction_view_model.dart';

class PageTransactions extends StatefulWidget {
  final int accountId;
  const PageTransactions({super.key, required this.accountId});

  @override
  State<PageTransactions> createState() => _PageTransactionsState();
}

class _PageTransactionsState extends State<PageTransactions> {
  @override
  void initState() {
    super.initState();
    // Charger les transactions après le premier build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final transactionVM = Provider.of<TransactionViewModel>(
        context,
        listen: false,
      );
      transactionVM.loadTransactions(widget.accountId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final transactionVM = context.watch<TransactionViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Transactions")),
      body: transactionVM.isLoading
          ? const Center(child: CircularProgressIndicator())
          : transactionVM.transactions.isEmpty
          ? const Center(child: Text("Aucune transaction trouvée"))
          : ListView.builder(
              itemCount: transactionVM.transactions.length,
              itemBuilder: (context, index) {
                final tx = transactionVM.transactions[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: Icon(
                      tx.type == "credit"
                          ? Icons.arrow_downward
                          : Icons.arrow_upward,
                      color: tx.type == "credit" ? Colors.green : Colors.red,
                    ),
                    title: Text("${tx.amount.toStringAsFixed(2)}"),
                    subtitle: Text("${tx.description} - ${tx.date.toLocal()}"),
                  ),
                );
              },
            ),
    );
  }
}
