import 'dart:convert';

class ModelDiccionarioNodo {
  List<Datum>? data;

  ModelDiccionarioNodo({
    this.data,
  });

  factory ModelDiccionarioNodo.fromJson(String str) =>
      ModelDiccionarioNodo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelDiccionarioNodo.fromMap(Map<String, dynamic> json) => ModelDiccionarioNodo(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datum {
  int? idDatos;
  String? nombreDiccionario;
  double? valor;
  DateTime? fechahora;
  String? hora;

  Datum({
    this.idDatos,
    this.nombreDiccionario,
    this.valor,
    this.fechahora,
    this.hora,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        idDatos: json["id_datos"],
        nombreDiccionario: json["nombre_diccionario"],
        valor: json["valor"],
        fechahora: json["fechahora"] == null ? null : DateTime.parse(json["fechahora"]),
        hora: json["hora"],
      );

  Map<String, dynamic> toMap() => {
        "id_datos": idDatos,
        "nombre_diccionario": nombreDiccionario,
        "valor": valor,
        "fechahora":
            "${fechahora!.year.toString().padLeft(4, '0')}-${fechahora!.month.toString().padLeft(2, '0')}-${fechahora!.day.toString().padLeft(2, '0')}",
        "hora": hora,
      };

  @override
  String toString() {
    return 'Datum{idDatos: $idDatos, nombreDiccionario: $nombreDiccionario, valor: $valor, fechahora: $fechahora, hora: $hora}';
  }
}
