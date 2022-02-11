import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  //Cambiar {your_key} por tu propia key}
  final _url_login =
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key={your_key}&';

  final _url_register =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key={your_key}&';

  Future<String> login(String email, String password) async {
    final res = await http.post(Uri.parse(_url_login), body: {
      "email": email,
      "password": password,
      "returnSecureToken": 'false'
    });
    //print('JSON:' + jsonDecode(res.body)['localId']);
    return res.statusCode == 200 ? jsonDecode(res.body)['localId'] : '';
  }

  Future<String> register(String email, String password) async {
    final res = await http.post(Uri.parse(_url_register),
        body: jsonEncode({
          "email": email,
          "password": password,
          "returnSecureToken": 'false'
        }));
    print(res.body);
    return res.statusCode == 200 ? jsonDecode(res.body)['localId'] : '';
  }
}
