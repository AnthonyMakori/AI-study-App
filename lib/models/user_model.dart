import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  String? uid;
  String? email;

  bool get isLoggedIn => uid != null;

  void login(String id, String emailAddr) {
    uid = id;
    email = emailAddr;
    notifyListeners();
  }

  void logout() {
    uid = null;
    email = null;
    notifyListeners();
  }
}
