import 'dart:convert';

class ModelBusinessNodo {
  List<Nodo>? data;

  ModelBusinessNodo({
    this.data,
  });

  factory ModelBusinessNodo.fromJson(String str) => ModelBusinessNodo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelBusinessNodo.fromMap(Map<String, dynamic> json) => ModelBusinessNodo(
    data: json["data"] == null ? [] : List<Nodo>.from(json["data"]!.map((x) => Nodo.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Nodo {
  double? valMax;
  String? log;
  String? fechahora;
  String? tipoDato;
  String? lat;
  int? id_nodo;
  int? valor;
  int? datosEnviados;
  double? valMin;
  String? nombre;
  String? clase;

  Nodo({
    this.valMax,
    this.log,
    this.fechahora,
    this.tipoDato,
    this.lat,
    this.id_nodo,
    this.valor,
    this.datosEnviados,
    this.valMin,
    this.nombre,
    this.clase,
  });

  factory Nodo.fromJson(String str) => Nodo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Nodo.fromMap(Map<String, dynamic> json) => Nodo(
    valMax: json["val_max"],
    log: json["log"],
    fechahora: json["fechahora"],
    tipoDato: json["tipo_dato"],
    lat: json["lat"],
    id_nodo: json["id_nodo"],
    valor: json["valor"],
    datosEnviados: json["datos_enviados"],
    valMin: json["val_min"],
    nombre: json["nombre"],
    clase: json["clase"],
  );

  Map<String, dynamic> toMap() => {
    "val_max": valMax,
    "log": log,
    "fechahora": fechahora,
    "tipo_dato": tipoDato,
    "lat": lat,
    "id_nodo": id_nodo,
    "valor": valor,
    "datos_enviados": datosEnviados,
    "val_min": valMin,
    "nombre": nombre,
    "clase": clase,
  };
}
