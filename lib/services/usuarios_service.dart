import 'dart:convert';

import 'package:carrito/models/producto_model.dart';
import 'package:http/http.dart' as http;

class UsuariosService {
  //Esta url no funciona para no mostrar el endpoint de mi proyecto
  final _url = 'https://{endpoint-de-tu-proyecto-firebase}/usuarios.json';

  Future<Map<String, List<String>>> getCesta(String local_id) async {
    List<String> ls = [];

    final res = await http.get(Uri.parse(_url));
    String key2 = '';
    final map = jsonDecode(res.body);

    map.forEach((key, value) {
      if (value['local_id'] == local_id) {
        key2 = key;

        value['cesta'].forEach((p) {
          ls.add(p.toString());
        });
      }
    });

    return {key2: ls};
  }
}
