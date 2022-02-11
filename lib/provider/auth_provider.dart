import 'package:carrito/services/auth_service.dart';
import 'package:carrito/services/usuarios_service.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  AuthService authService = AuthService();
  UsuariosService userServ = UsuariosService();

  String? token = '';
  String email = '';
  String password = '';
  String key_user = '';

  Future<bool> login(String email, String password) async {
    token = await authService.login(email, password);
    //print('token login:' + token);
    //print('RESPUESTA_tok:' + token);
    notifyListeners();
    return token != '';
  }

  Future<bool> register(String email, String password) async {
    token = await authService.register(email, password);
    return token != '';
  }

  Future<List<String>> cargaCesta(String tokenp) async {
    print('CESTA TOKEN:' + tokenp);
    final Map<String, List<String>> map = await userServ.getCesta(tokenp);
    key_user = map.entries.first.key;
    return map.entries.first.value;
  }
}
