import 'package:carrito/pages/bag_page.dart';
import 'package:carrito/pages/home_page.dart';
import 'package:carrito/pages/login_page.dart';
import 'package:carrito/pages/register_page.dart';
import 'package:carrito/provider/auth_provider.dart';
import 'package:carrito/provider/drag_provider.dart';
import 'package:carrito/provider/notification_provider.dart';
import 'package:carrito/provider/productos_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductosProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => DragProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          'home': (context) => HomePage(),
          'login': (context) => LoginPage(),
          'register': (context) => RegisterPage(),
          'bag': (_) => BagPage(),
        },
        initialRoute: 'login',
      ),
    );
  }
}
