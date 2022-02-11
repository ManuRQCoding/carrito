import 'dart:convert';

import 'package:carrito/models/producto_model.dart';
import 'package:http/http.dart' as http;

class ProductosService {
  //Estas url no funcionan para no mostrar el endpoint de mi proyecto
  final url = 'https://{endpoint-de-tu-proyecto-firebase}/productos.json';
  final url2 = 'https://{endpoint-de-tu-proyecto-firebase}/usuarios/';

  Future<List<ProductoModel>> get_productos() async {
    List<ProductoModel> ps = [];
    final res = await http.get(Uri.parse(url));

    final map = jsonDecode(res.body);

    map.forEach((key, value) {
      final ProductoModel p = ProductoModel.fromMap(value);
      p.id = key;
      ps.add(p);
    });
    return ps;
  }

  Future<List<ProductoModel>> getProductosCesta(List<String> productos) async {
    List<ProductoModel> ps = [];
    final res = await http.get(Uri.parse(url));

    final map = jsonDecode(res.body);

    productos.forEach((element) {
      map.forEach((key, value) {
        if (element == key) {
          final ProductoModel p = ProductoModel.fromMap(value);
          p.id = key;
          ps.add(p);
        }
      });
    });

    return ps;
  }

  Future<bool> putCesta(String key_user, List<String> cesta) async {
    final res = await http.put(Uri.parse(url2 + key_user + '/cesta.json'),
        body: jsonEncode(cesta));

    return res.statusCode == 200;
  }
}
