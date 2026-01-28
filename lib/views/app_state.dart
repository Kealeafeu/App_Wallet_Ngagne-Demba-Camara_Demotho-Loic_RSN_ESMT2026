import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  static final AppState _singleton = AppState._internal();
  AppState._internal();
  factory AppState() => _singleton;

  ThemeMode? themeChoisi;
  bool estConnect = false;

  // Variables globales pour le wallet
  int? userId;
  String? walletAddress;
  double soldeTotal = 0.0;

  void update(VoidCallback callback) {
    callback();
    notifyListeners(); // rebuilder toutes les pages abonnées
  }
}