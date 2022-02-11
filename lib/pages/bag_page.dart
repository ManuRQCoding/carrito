import 'package:carrito/models/producto_model.dart';
import 'package:carrito/provider/auth_provider.dart';
import 'package:carrito/provider/drag_provider.dart';
import 'package:carrito/provider/productos_provider.dart';
import 'package:carrito/widgets/custom_appbar.dart';
import 'package:carrito/widgets/fondo_circular.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BagPage extends StatelessWidget {
  const BagPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productosProv = Provider.of<ProductosProvider>(context);
    final dragProv = Provider.of<DragProvider>(context);
    final authProv = Provider.of<AuthProvider>(context);
    final size = MediaQuery.of(context).size;

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
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomAppBar(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Text(
                              'Productos',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: productosProv.bagProducts.length,
                              itemBuilder: (_, i) {
                                final p = productosProv.bagProducts[i];
                                return Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: 260,
                                    child: Draggable<ProductoModel>(
                                      data: p,
                                      child: listT(p),
                                      feedback: image(p),
                                      onDragStarted: () {
                                        dragProv.startDrag();
                                      },
                                      onDragEnd: (details) {
                                        dragProv.endDrag();
                                      },
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                    Positioned.fill(
                      bottom: 20,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: DragTarget<ProductoModel>(builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        ) {
                          return Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                width: dragProv.started ? 70 : 60,
                                height: dragProv.started ? 70 : 60,
                                color:
                                    dragProv.started ? Colors.red : Colors.grey,
                              ),
                            ),
                          );
                        }, onAccept: (data) async {
                          productosProv.removeFromBag(data);
                        }),
                      ),
                    ),
                    /*
                Positioned(
                  bottom: 30,
                  left: size.width * 0.45,
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.red,
                    ),
                  ),
                )*/
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Padding listT(ProductoModel p) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Color.fromRGBO(238, 98, 01, 1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 90,
            child: ListTile(
              leading: image(p),
              title: Text(
                p.nombre,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ClipRRect image(ProductoModel p) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        width: 50.0,
        height: 60.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(p.imagen),
          ),
        ),
      ),
    );
  }
}
