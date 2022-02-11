import 'package:carrito/provider/notification_provider.dart';
import 'package:carrito/provider/productos_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationProv = Provider.of<NotificationProvider>(context);
    final productosProv = Provider.of<ProductosProvider>(context);

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Spacer(),
          Stack(children: [
            IconButton(
              icon: Icon(FontAwesomeIcons.shoppingBag),
              onPressed: () {
                Navigator.pushNamed(context, 'bag');
              },
            ),
            AnimatedContainer(
              child: Center(
                child: Text(
                  productosProv.bagProducts.length.toString(),
                  //productosProv.bagProducts.length.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              width: notificationProv.width,
              height: notificationProv.height,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20.0),
              ),
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
            ),
          ]),
          IconButton(
            icon: Icon(FontAwesomeIcons.ellipsisV, size: 15.0),
            onPressed: () {},
          ),
          SizedBox(width: 15.0)
        ],
      ),
    );
  }
}
