import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/app_state.dart';
import 'utils/routeur.dart';
import 'utils/theme_perso.dart';

import 'repositories/api_user_repository.dart';
import 'repositories/api_account_repository.dart';
import 'repositories/api_transaction_repository.dart';

import 'view_models/user_view_model.dart';
import 'view_models/account_view_model.dart';
import 'view_models/transaction_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(
          create: (_) => UserViewModel(ApiUserRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => AccountViewModel(ApiAccountRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => TransactionViewModel(ApiTransactionRepository()),
        ),
      ],
      child: Consumer<AppState>(
        builder: (context, appState, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Wallet MVVM',
            theme: ThemePerso.clair,
            darkTheme: ThemePerso.sombre,
            themeMode: appState.themeChoisi ?? ThemeMode.system,
            onGenerateRoute: Routeur.generateRoute,
            initialRoute: '/profil', // ← démarre sur la page profil
          );
        },
      ),
    );
  }
}