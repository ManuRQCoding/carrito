import 'package:carrito/provider/auth_provider.dart';
import 'package:carrito/provider/productos_provider.dart';
import 'package:carrito/widgets/cards_view.dart';
import 'package:carrito/widgets/custom_appbar.dart';
import 'package:carrito/widgets/fondo_circular.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);
    final prodProv = Provider.of<ProductosProvider>(context, listen: false);

    if (prodProv.bagProducts.isEmpty) {
      prodProv.cargarProductosBolsa(authProv.token!);
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.cyan,
          Colors.orange.shade300,
        ]),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAppBar(),
                        _Header(),
                        CardsView(),
                      ]),
                ),
              ),
            ],
          )),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 45.0,
          ),
          Text(
            'Productos',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          SizedBox(
            height: 45.0,
          ),
        ],
      ),
    );
  }
}
