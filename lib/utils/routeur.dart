import 'package:app_wallet/views/page_accueil.dart';
import 'package:app_wallet/views/page_profil.dart';
import 'package:app_wallet/views/page_transactions.dart';
import 'package:flutter/material.dart';

class Routeur {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const PageProfil());
      // ← on démarre par la page profil pour choisir l'utilisateur
      case '/profil':
        return MaterialPageRoute(builder: (_) => const PageProfil());
      case '/accueil':
        final args = settings.arguments as int; // userId
        return MaterialPageRoute(builder: (_) => PageAccueil(userId: args));
      case '/transactions':
        final args = settings.arguments as int; // accountId
        return MaterialPageRoute(
          builder: (_) => PageTransactions(accountId: args),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("Route inconnue : ${settings.name}")),
          ),
        );
    }
  }
}
