
import 'dart:convert';

class EmpresaResponse {
  EmpresaResponse({
    this.bandera,
    this.topic,
    this.nombre_empresa,
    this.id_empresas,
    this.imagen,
  });

  bool? bandera;
  String? topic;
  String? nombre_empresa;
  int? id_empresas;
  String? imagen;

  factory EmpresaResponse.fromJson(String str) => EmpresaResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmpresaResponse.fromMap(Map<String, dynamic> json) => EmpresaResponse(
    bandera: json["bandera"],
    topic: json["topic"],
    nombre_empresa: json["nombre_empresa"],
    id_empresas: json["id_empresas"],
    imagen: json["imagen"],
  );

  Map<String, dynamic> toMap() => {
    "bandera": bandera,
    "topic": topic,
    "nombre_empresa": nombre_empresa,
    "id_empresas": id_empresas,
    "imagen": imagen,
  };

  // cover to map
  EmpresaResponse.map(dynamic obj) {
    bandera= obj["bandera"];
    topic= obj["topic"];
    nombre_empresa= obj["nombre_empresa"];
    id_empresas= obj["id_empresas"];
    imagen= obj["imagen"];
  }

  @override
  String toString() {
    return 'EmpresaResponse{bandera: $bandera, topic: $topic, nombre_empresa: $nombre_empresa, id_empresas: $id_empresas, imagen: $imagen}';
  }
}
