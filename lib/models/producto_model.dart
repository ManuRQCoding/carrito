// To parse this JSON data, do
//
//     final productoModel = productoModelFromMap(jsonString);

import 'dart:convert';

class ProductoModel {
  ProductoModel({
    this.id,
    required this.imagen,
    required this.nombre,
    required this.precio,
    required this.stock,
  });

  String? id;
  String imagen;
  String nombre;
  int precio;
  int stock;

  factory ProductoModel.fromJson(String str) =>
      ProductoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductoModel.fromMap(Map<String, dynamic> json) => ProductoModel(
        imagen: json["imagen"],
        nombre: json["nombre"],
        precio: json["precio"],
        stock: json["stock"],
      );

  Map<String, dynamic> toMap() => {
        "imagen": imagen,
        "nombre": nombre,
        "precio": precio,
        "stock": stock,
      };
}
