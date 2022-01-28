import 'package:flutter/cupertino.dart';
import 'package:instagram_fullstack_clone/models/user_model.dart';
import 'package:instagram_fullstack_clone/services/auth_service.dart';

class UserProvider extends ChangeNotifier {
  LulzUser? _user;
  final AuthService _auth = AuthService();

  LulzUser? get getUser => _user;
  Future<void> refreshUser() async {
    _user = await _auth.getUserDetails();
    notifyListeners();
  }
}
