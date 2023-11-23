import 'dart:convert';

import 'package:amazon_clone/constants/error_handler.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          //cart: '',
          type: '',
          token: '');

      //String jsonBody = jsonEncode(user);

      // if (kDebugMode) {
      //   print('Testing for Json Body : $jsonBody');
      // }

      http.Response res = await http.post(Uri.parse("$uri/api/signup"),
          body: jsonEncode({
            'email': email,
            'password': password,
            'name': name,
          }),
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
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // sign in user- OWNER
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

//CHATGPT
// void signInUser({
//   required BuildContext context,
//   required String email,
//   required String password,
// }) async {
//   try {
//     http.Response res = await http.post(Uri.parse("$uri/api/signin"),
//         body: jsonEncode({'email': email, 'password': password}),
//         headers: <String, String>{
//           'Content-Type': 'application/json;charset=utf-8',
//         });
//
//     // Check if the response status code is OK (200) before processing the response
//
//     if (res.statusCode == 200) {
//       String responseBody = res.body;
//       Map<String, dynamic> userData = jsonDecode(responseBody);
//        SharedPreferences prefs = await SharedPreferences.getInstance();
//
//        //ISSUES FROM HERE :
//       Provider.of(context, listen: false).setUser(responseBody);
//         await prefs.setString('x-auth-token', userData['token']);
//
//       // //Copilot Code
//       //   Provider.of<UserProvider>(context, listen: false).setUser(responseBody as User);
//       //   await prefs.setString('x-auth-token', userData['token']);
//
//
//         Navigator.pushNamedAndRemoveUntil(
//           context,
//           HomeScreen.routeName,
//               (Route<dynamic> route) => false,
//         );
//
//     } else {
//       showSnackBar(context, 'Failed to sign in. Server returned status code ${res.statusCode}');
//     }
//   } catch (e) {
//     showSnackBar(context, e.toString());
//     if (kDebugMode) {
//       print(e);
//     }
//   }
// }

// void signInUser({
//   required BuildContext context,
//   required String email,
//   required String password,
// }) async {
//   try {
//     // if (kDebugMode) {
//     //   print('Testing for Json Body : $jsonBody');
//     // }
//     http.Response res = await http.post(Uri.parse("$uri/api/signin"),
//         body: jsonEncode({'email': email, 'password': password}),
//         headers: <String, String>{
//           'Content-Type': 'application/json;charset=utf-8',
//         });
//
//     // httpErrorHandle(
//     //     response: res,
//     //     context: context,
//     //     onSuccess: () {
//     //       showSnackBar(
//     //           context, 'Account Logged-In!');
//     //     });
//
//     httpErrorHandle(
//         response: res,
//         context: context,
//         onSuccess: () async {
//           SharedPreferences preferences =
//               await SharedPreferences.getInstance();
//           String responseBody = res.body;
//           Map<String, dynamic> userData = jsonDecode(responseBody); // Decode the JSON
//           Provider.of<UserProvider>(context, listen: false).setUser(userData);
//           await preferences.setString(
//               'x-Auth-Token', (userData)['token']!);
//
//           Navigator.pushNamedAndRemoveUntil(
//             context,
//             HomeScreen.routeName,
//             (Route<dynamic> route) => false,
//           );
//         });
//   } catch (e) {
//     showSnackBar(context, e.toString());
//     if (kDebugMode) {
//       print(e);
//     }
//   }
// }
}
