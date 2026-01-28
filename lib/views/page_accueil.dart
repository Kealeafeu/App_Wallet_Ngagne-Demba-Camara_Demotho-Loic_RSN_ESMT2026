import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_wallet/view_models/account_view_model.dart';
import 'package:app_wallet/views/page_transactions.dart';

class PageAccueil extends StatefulWidget {
  final int userId; // ← reçoit l'id de l'utilisateur
  const PageAccueil({super.key, required this.userId});

  @override
  State<PageAccueil> createState() => _PageAccueilState();
}

class _PageAccueilState extends State<PageAccueil> {
  @override
  void initState() {
    super.initState();
    // Charger les comptes après le premier build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final accountVM = Provider.of<AccountViewModel>(context, listen: false);
      accountVM.loadAccounts(widget.userId); // ← userId dynamique
    });
  }

  @override
  Widget build(BuildContext context) {
    final accountVM = context.watch<AccountViewModel>();

    // Calcul du solde total
    double soldeTotal = accountVM.accounts.fold(
      0.0,
      (sum, acc) => sum + acc.balance,
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Accueil Wallet")),
      body: accountVM.isLoading
          ? const Center(child: CircularProgressIndicator())
          : accountVM.accounts.isEmpty
              ? const Center(child: Text("Aucun compte trouvé"))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Solde total : ${soldeTotal.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: accountVM.accounts.length,
                        itemBuilder: (context, index) {
                          final account = accountVM.accounts[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: ListTile(
                              leading: Icon(
                                account.currency == "BTC"
                                    ? Icons.currency_bitcoin
                                    : Icons.account_balance_wallet,
                              ),
                              title: Text("Compte ${account.currency}"),
                              subtitle: Text("Solde : ${account.balance.toStringAsFixed(2)}"),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PageTransactions(accountId: account.id),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}