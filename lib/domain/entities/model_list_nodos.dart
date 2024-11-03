import 'dart:convert';

class ModelListNodos {
  String? idEmpresa;
  List<Nodo>? nodos;

  ModelListNodos({
    this.idEmpresa,
    this.nodos,
  });

  factory ModelListNodos.fromJson(String str) => ModelListNodos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelListNodos.fromMap(Map<String, dynamic> json) => ModelListNodos(
    idEmpresa: json["id_empresa"],
    nodos: json["nodos"] == null ? [] : List<Nodo>.from(json["nodos"]!.map((x) => Nodo.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id_empresa": idEmpresa,
    "nodos": nodos == null ? [] : List<dynamic>.from(nodos!.map((x) => x.toMap())),
  };
}

class Nodo {
  int? idNodos;
  String? nombre;
  String? latitud;
  String? longitud;
  int? idDiccionario;
  String? nombrePresentar;
  String? alias;
  double? valorMaximo;
  double? valorMinimo;
  double? valor;

  Nodo({
    this.idNodos,
    this.nombre,
    this.latitud,
    this.longitud,
    this.idDiccionario,
    this.nombrePresentar,
    this.alias,
    this.valorMaximo,
    this.valorMinimo,
    this.valor,
  });

  factory Nodo.fromJson(String str) => Nodo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Nodo.fromMap(Map<String, dynamic> json) => Nodo(
    idNodos: json["id_nodos"],
    nombre: json["nombre"],
    latitud: json["latitud"],
    longitud: json["longitud"],
    idDiccionario: json["id_diccionario"],
    nombrePresentar: json["nombre_presentar"],
    alias: json["alias"],
    valorMaximo: json["valor_maximo"],
    valorMinimo: json["valor_minimo"],
    valor: json["valor"],
  );

  Map<String, dynamic> toMap() => {
    "id_nodos": idNodos,
    "nombre": nombre,
    "latitud": latitud,
    "longitud": longitud,
    "id_diccionario": idDiccionario,
    "nombre_presentar": nombrePresentar,
    "alias": alias,
    "valor_maximo": valorMaximo,
    "valor_minimo": valorMinimo,
    "valor": valor,
  };
}
