import 'dart:convert';

class ModelListNodos {
  List<Nodo>? nodos;
  String? idEmpresa;

  ModelListNodos({
    this.nodos,
    this.idEmpresa,
  });

  factory ModelListNodos.fromJson(String str) => ModelListNodos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelListNodos.fromMap(Map<String, dynamic> json) => ModelListNodos(
        nodos: json["nodos"] == null
            ? []
            : List<Nodo>.from(json["nodos"]!.map((x) => Nodo.fromMap(x))),
        idEmpresa: json["id_empresa"],
      );

  Map<String, dynamic> toMap() => {
        "nodos": nodos == null ? [] : List<dynamic>.from(nodos!.map((x) => x.toMap())),
        "id_empresa": idEmpresa,
      };
}

class Nodo {
  String? longitud;
  String? latitud;
  String? nombre;
  int? idEmpresas;
  String? nombrePresentar;
  int? idDiccionario;
  int? idNodos;

  Nodo({
    this.longitud,
    this.latitud,
    this.nombre,
    this.idEmpresas,
    this.nombrePresentar,
    this.idDiccionario,
    this.idNodos,
  });

  factory Nodo.fromJson(String str) => Nodo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Nodo.fromMap(Map<String, dynamic> json) => Nodo(
        longitud: json["longitud"],
        latitud: json["latitud"],
        nombre: json["nombre"],
        idEmpresas: json["id_empresas"],
        nombrePresentar: json["nombre_presentar"],
        idDiccionario: json["id_diccionario"],
        idNodos: json["id_nodos"],
      );

  Map<String, dynamic> toMap() => {
        "longitud": longitud,
        "latitud": latitud,
        "nombre": nombre,
        "id_empresas": idEmpresas,
        "nombre_presentar": nombrePresentar,
        "id_diccionario": idDiccionario,
        "id_nodos": idNodos,
      };

  @override
  String toString() {
    return 'Nodo{longitud: $longitud, latitud: $latitud, nombre: $nombre, idEmpresas: $idEmpresas, nombrePresentar: $nombrePresentar, idDiccionario: $idDiccionario, idNodos: $idNodos}';
  }
}
