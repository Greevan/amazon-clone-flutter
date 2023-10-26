import 'package:amazon_clone/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_clone/constants/global_variables.dart';

class AuthService {
  //signUp user
  void signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          password: password,
          address: '',
          type: '',
          token: '');

      http.post(uri);//url import from global variable.dart
    } catch (e) {}
  }
}
