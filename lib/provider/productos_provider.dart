import 'package:carrito/models/producto_model.dart';
import 'package:carrito/provider/auth_provider.dart';
import 'package:carrito/services/productos_service.dart';
import 'package:carrito/services/usuarios_service.dart';
import 'package:flutter/material.dart';

class ProductosProvider extends ChangeNotifier {
  List<ProductoModel> _productos = [];
  List<ProductoModel> _bagProducts = [];
  ProductosService ps = ProductosService();
  AuthProvider authProv = AuthProvider();
  UsuariosService us = UsuariosService();

  ProductosProvider() {
    _cargarProductos();
  }

  List<ProductoModel> get productos => _productos;

  List<ProductoModel> get bagProducts => _bagProducts;

  void addToBag(ProductoModel p) {
    _bagProducts.add(p);
    ps.putCesta(authProv.key_user, _bagProducts.map((e) => e.id!).toList());
    notifyListeners();
  }

  void removeFromBag(ProductoModel p) {
    _bagProducts.remove(p);
    ps.putCesta(authProv.key_user, _bagProducts.map((e) => e.id!).toList());
    notifyListeners();
  }

  _cargarProductos() async {
    _productos.addAll(await ps.get_productos());
    notifyListeners();
  }

  cargarProductosBolsa(String token) async {
    _bagProducts.clear();
    final List<String> cesta = await authProv.cargaCesta(token);
    //print('cesta string');
    //print(cesta);

    _bagProducts.addAll(await ps.getProductosCesta(cesta));
    //print('LLLEEEGGAAAA');
    notifyListeners();
  }
}
