import 'package:flutter/widgets.dart';
import 'package:instagram_fullstack_clone/models/user_model.dart';
import 'package:instagram_fullstack_clone/services/auth_service.dart';

class UserProvider with ChangeNotifier {
  LulzUser? _user;
  final AuthService _authService = AuthService();

  LulzUser get getUser => _user!;

  Future<void> refreshUser() async {
    LulzUser user = await _authService.getUserDetails();
    _user = user;
    print('refreshed user');
    notifyListeners();
  }
}
