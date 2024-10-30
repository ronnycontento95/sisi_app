import 'dart:convert';

class ModelNodosDiccionario {
  String? idNodo;
  String? nombre;
  String? topic;
  String? lat;
  String? log;
  List<Datum>? data;

  ModelNodosDiccionario({
    this.idNodo,
    this.nombre,
    this.topic,
    this.lat,
    this.log,
    this.data,
  });

  factory ModelNodosDiccionario.fromJson(String str) => ModelNodosDiccionario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelNodosDiccionario.fromMap(Map<String, dynamic> json) => ModelNodosDiccionario(
    idNodo: json["id_nodo"],
    nombre: json["nombre"],
    topic: json["topic"],
    lat: json["lat"],
    log: json["log"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id_nodo": idNodo,
    "nombre": nombre,
    "topic": topic,
    "lat": lat,
    "log": log,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
  int? idDatos;
  int? idDiccionario;
  String? nombreDiccionario;
  double? valor;
  String? aliasDiccionario;
  double? valorMinimo;
  double? valorMaximo;
  DateTime? fechahora;
  int? identificador;
  String? hora;

  Datum({
    this.idDatos,
    this.idDiccionario,
    this.nombreDiccionario,
    this.valor,
    this.aliasDiccionario,
    this.valorMinimo,
    this.valorMaximo,
    this.fechahora,
    this.identificador,
    this.hora,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    idDatos: json["id_datos"],
    idDiccionario: json["id_diccionario"],
    nombreDiccionario: json["nombre_diccionario"],
    valor: json["valor"]?.toDouble(),
    aliasDiccionario: json["alias_diccionario"],
    valorMinimo: json["valor_minimo"],
    valorMaximo: json["valor_maximo"],
    fechahora: json["fechahora"] == null ? null : DateTime.parse(json["fechahora"]),
    identificador: json["identificador"],
    hora: json["hora"],
  );

  Map<String, dynamic> toMap() => {
    "id_datos": idDatos,
    "id_diccionario": idDiccionario,
    "nombre_diccionario": nombreDiccionario,
    "valor": valor,
    "alias_diccionario": aliasDiccionario,
    "valor_minimo": valorMinimo,
    "valor_maximo": valorMaximo,
    "fechahora": "${fechahora!.year.toString().padLeft(4, '0')}-${fechahora!.month.toString().padLeft(2, '0')}-${fechahora!.day.toString().padLeft(2, '0')}",
    "identificador": identificador,
    "hora": hora,
  };
}
