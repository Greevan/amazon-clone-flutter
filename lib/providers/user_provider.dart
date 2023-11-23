import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      email: '',
      name: '',
      password: '',
      address: '',
      type: '',
      token: '');

  User get user => _user;

  void setUser(dynamic user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  // //COPILOT CODE
  // void setUser(User user) {
  //   _user = user;
  //   notifyListeners();
  // }

}
