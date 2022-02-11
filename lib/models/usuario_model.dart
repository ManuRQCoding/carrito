// To parse this JSON data, do
//
//     final usuarioModel = usuarioModelFromMap(jsonString);

import 'dart:convert';

class UsuarioModel {
  UsuarioModel({
    required this.cesta,
    required this.localId,
  });

  List<String> cesta;
  String localId;

  factory UsuarioModel.fromJson(String str) =>
      UsuarioModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsuarioModel.fromMap(Map<String, dynamic> json) => UsuarioModel(
        cesta: List<String>.from(json["cesta"].map((x) => x)),
        localId: json["local_id"],
      );

  Map<String, dynamic> toMap() => {
        "cesta": List<dynamic>.from(cesta.map((x) => x)),
        "local_id": localId,
      };
}
