import 'package:flutter/material.dart';
import 'package:app_wallet/models/user_model.dart';
import 'package:app_wallet/repositories/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  UserViewModel(this._userRepository);

  List<UserModel> _users = [];
  List<UserModel> get users => _users;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _users = await _userRepository.fetchAllUsers();
    } catch (e) {
      debugPrint("Erreur lors du chargement des utilisateurs: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}