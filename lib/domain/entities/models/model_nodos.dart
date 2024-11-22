import 'dart:convert';

class ModelNodos {
  List<Nodo>? nodos;

  ModelNodos({
    this.nodos,
  });

  factory ModelNodos.fromJson(String str) => ModelNodos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelNodos.fromMap(Map<String, dynamic> json) => ModelNodos(
        nodos: json["nodos"] == null
            ? []
            : List<Nodo>.from(json["nodos"]!.map((x) => Nodo.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "nodos": nodos == null ? [] : List<dynamic>.from(nodos!.map((x) => x.toMap())),
      };
}

class Nodo {
  int? ide;
  String? nombre;
  String? lat;
  String? lot;
  int? valor;
  double? valMin;
  double? valMax;
  String? fecha;
  String? hora;
  String? tipoDato;

  Nodo({
    this.ide,
    this.nombre,
    this.lat,
    this.lot,
    this.valor,
    this.valMin,
    this.valMax,
    this.fecha,
    this.hora,
    this.tipoDato,
  });

  factory Nodo.fromJson(String str) => Nodo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Nodo.fromMap(Map<String, dynamic> json) => Nodo(
        ide: json["ide"],
        nombre: json["nombre"],
        lat: json["lat"],
        lot: json["lot"],
        valor: json["valor"] != null
            ? (json["valor"] is String ? int.tryParse(json["valor"]) ?? 0 : json["valor"])
            : 0,
        valMin: (json["val_min"] != null)
            ? (json["val_min"] is int
                ? (json["val_min"] as int).toDouble()
                : (json["val_min"] is String
                    ? double.tryParse(json["val_min"]) ?? 0.0
                    : json["val_min"] as double))
            : 0.0,
        valMax: (json["val_max"] != null)
            ? (json["val_max"] is int
                ? (json["val_max"] as int).toDouble()
                : (json["val_max"] is String
                    ? double.tryParse(json["val_max"]) ?? 0.0
                    : json["val_max"] as double))
            : 0.0,
        fecha: json["fecha"],
        hora: json["hora"],
        tipoDato: json["tipo_dato"],
      );

  Map<String, dynamic> toMap() => {
        "ide": ide,
        "nombre": nombre,
        "lat": lat,
        "lot": lot,
        "valor": valor,
        "val_min": valMin,
        "val_max": valMax,
        "fecha": fecha,
        "hora": hora,
        "tipo_dato": tipoDato,
      };
}
