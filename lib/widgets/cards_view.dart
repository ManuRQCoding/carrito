import 'package:carrito/models/producto_model.dart';
import 'package:carrito/provider/notification_provider.dart';
import 'package:carrito/provider/productos_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CardsView extends StatefulWidget {
  CardsView({Key? key}) : super(key: key);

  @override
  _CardsViewState createState() => _CardsViewState();
}

class _CardsViewState extends State<CardsView> {
  @override
  Widget build(BuildContext context) {
    final productosProv = Provider.of<ProductosProvider>(context);
    return Container(
      width: double.infinity,
      height: 460.0,
      child: PageView(
        controller: PageController(viewportFraction: 0.85),
        children: productosProv.productos.map((prod) => _Card(prod)).toList(),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  ProductoModel prod;

  _Card(this.prod);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Row(
            children: [
              SizedBox(
                width: 55.0,
              ),
              _TarjetaDescripcion(prod),
            ],
          ),
          Positioned(
              top: 90,
              left: 20,
              child: FadeInImage(
                placeholder: AssetImage('assets/loading.jpeg'),
                image: NetworkImage(prod.imagen),
                width: 160.0,
              ))
        ],
      ),
    );
  }
}

class _TarjetaDescripcion extends StatelessWidget {
  ProductoModel prod;
  _TarjetaDescripcion(this.prod);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final productosProv = Provider.of<ProductosProvider>(context);
    final notificationProv = Provider.of<NotificationProvider>(context);

    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: size.width * 0.65,
          height: 450,
          color: Color.fromRGBO(248, 68, 11, 1),
          child: Column(
            children: [
              SizedBox(height: 25.0),
              RotatedBox(
                quarterTurns: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      prod.nombre,
                      style: TextStyle(
                          color: Colors.white24,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      prod.nombre,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                  child: Text(
                    '${prod.precio}€',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  width: 80.0,
                ),
                GestureDetector(
                  onTap: () async {
                    productosProv.addToBag(prod);

                    notificationProv.up();
                    await Future.delayed(Duration(milliseconds: 500));
                    notificationProv.down();
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        'Add to bag',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    width: 120.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(15))),
                  ),
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}
