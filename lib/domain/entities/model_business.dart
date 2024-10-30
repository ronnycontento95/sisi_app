import 'dart:convert';

class Company {
  Company({
    this.bandera,
    this.topic,
    this.nombre_empresa,
    this.id_empresas,
    this.imagen,
    this.descripcion,
    this.imagen_app
  });

  bool? bandera;
  String? topic;
  String? nombre_empresa;
  int? id_empresas;
  String? imagen;
  String? descripcion;
  String? imagen_app;

  factory Company.fromJson(String str) => Company.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Company.fromMap(Map<String, dynamic> json) => Company(
        bandera: json["bandera"],
        topic: json["topic"],
        nombre_empresa: json["nombre_empresa"],
        id_empresas: json["id_empresas"],
        imagen: json["imagen"],
        descripcion: json["descripcion"],
        imagen_app: json["imagen_app"],
      );

  Map<String, dynamic> toMap() => {
        "bandera": bandera,
        "topic": topic,
        "nombre_empresa": nombre_empresa,
        "id_empresas": id_empresas,
        "imagen": imagen,
        "descripcion": descripcion,
        "imagen_app": imagen_app,
      };

  // cover to map
  Company.map(dynamic obj) {
    bandera = obj["bandera"];
    topic = obj["topic"];
    nombre_empresa = obj["nombre_empresa"];
    id_empresas = obj["id_empresas"];
    imagen = obj["imagen"];
    descripcion = obj["descripcion"];
    imagen_app = obj["imagen_app"];
  }

  @override
  String toString() {
    return 'Company{bandera: $bandera, topic: $topic, nombre_empresa: $nombre_empresa, id_empresas: $id_empresas, imagen: $imagen, descripcion: $descripcion, imagen_app: $imagen_app}';
  }
}
