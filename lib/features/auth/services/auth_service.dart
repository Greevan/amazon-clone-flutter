import 'dart:convert';

import 'package:amazon_clone/constants/error_handler.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_clone/constants/global_variables.dart';

class AuthService {
  //signUp user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: '',
          email: email,
          name: name,
          password: password,
          address: '',
          type: '',
          token: ''
      );

      String jsonBody = jsonEncode(user);

      // if (kDebugMode) {
      //   print('Testing for Json Body : $jsonBody');
      // }

      http.Response res = await http.post(Uri.parse("$uri/api/signup"),
          body: jsonBody,
          headers: <String, String>{
            'Content-Type': 'application/json;charset=utf-8',
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, 'Account Created! Login with the same credentials');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e);
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      // if (kDebugMode) {
      //   print('Testing for Json Body : $jsonBody');
      // }
      http.Response res = await http.post(Uri.parse("$uri/api/signin"),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            'Content-Type': 'application/json;charset=utf-8',
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, 'Account Created! Login with the same credentials');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e);
    }
  }
}


