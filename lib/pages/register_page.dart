import 'package:carrito/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/top_wave.png'),
                    fit: BoxFit.fill)),
          ),
          Positioned.fill(
            bottom: -875,
            left: -150,
            child: RotatedBox(
              quarterTurns: 2,
              child: Opacity(
                opacity: 0.35,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    scale: 0.1,
                    image: AssetImage('assets/bottom_wave.png'),
                  )),
                ),
              ),
            ),
          ),
          Positioned(
            top: 200,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Registro',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800]),
                  ),
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: 400,
                  child: Stack(
                    children: [
                      Column(children: [
                        _crearInput('Email', context),
                        _crearInputPassword('Contraseña', context)
                      ]),
                      Positioned(
                          top: 42.5,
                          right: 30,
                          child: FloatingActionButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(
                                      width: 0.25,
                                      color: Colors.orange.shade300)),
                              child: Icon(Icons.check, size: 40),
                              onPressed: () async {
                                await p.register(p.email, p.password)
                                    ? Navigator.pushNamed(context, 'home')
                                    : mostrarError(context);
                              },
                              backgroundColor: Colors.cyan[200]))
                    ],
                  ),
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                            side: BorderSide(
                                width: 0.25, color: Colors.orange.shade300)),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'login');
                        },
                        minWidth: 200,
                        height: 60,
                        color: Colors.cyan[200],
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> mostrarError(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text(
              'Error al registrar el usuario',
              textAlign: TextAlign.center,
            ),
          );
        });
  }

  Widget _crearInput(String text, context) {
    final p = Provider.of<AuthProvider>(context);
    return Container(
      width: 345,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50), topLeft: Radius.circular(10)),
          border: Border.all(color: Colors.grey.shade300)),
      child: TextFormField(
        cursorColor: Colors.black,
        autofocus: false,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: text,
          labelStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          floatingLabelStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          hintStyle: TextStyle(color: Colors.black),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        onChanged: (valor) {
          p.email = valor;
          p.notifyListeners();
        },
      ),
    );
  }

  Widget _crearInputPassword(String text, context) {
    final p = Provider.of<AuthProvider>(context);

    return Container(
      width: 345,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(50),
          ),
          border: Border.all(color: Colors.grey.shade300)),
      child: TextFormField(
        obscureText: true,
        cursorColor: Colors.black,
        autofocus: false,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: text,
          labelStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          floatingLabelStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          hintStyle: TextStyle(color: Colors.black),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        onChanged: (valor) {
          p.password = valor;
          p.notifyListeners();
        },
      ),
    );
  }
}
