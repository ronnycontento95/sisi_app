import 'dart:convert';

class DatosDiccionario {
  String? nombrePresentar;
  List<Datum>? data;
  String? idNodo;
  String? nombre;

  DatosDiccionario({
    this.nombrePresentar,
    this.data,
    this.idNodo,
    this.nombre,
  });

  factory DatosDiccionario.fromJson(String str) => DatosDiccionario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DatosDiccionario.fromMap(Map<String, dynamic> json) => DatosDiccionario(
    nombrePresentar: json["nombre_presentar"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    idNodo: json["id_nodo"],
    nombre: json["nombre"],
  );

  Map<String, dynamic> toMap() => {
    "nombre_presentar": nombrePresentar,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "id_nodo": idNodo,
    "nombre": nombre,
  };
}

class Datum {
  DateTime? fechahora;
  int? idDatos;
  int? identificador;
  String? nombreDiccionario;
  int? idDiccionario;
  double? valor;
  String? hora;
  String? alias_diccionario;

  Datum({
    this.fechahora,
    this.idDatos,
    this.identificador,
    this.nombreDiccionario,
    this.idDiccionario,
    this.valor,
    this.hora,
    this.alias_diccionario
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    fechahora: json["fechahora"] == null ? null : DateTime.parse(json["fechahora"]),
    idDatos: json["id_datos"],
    identificador: json["identificador"],
    nombreDiccionario: json["nombre_diccionario"],
    idDiccionario: json["id_diccionario"],
    valor: json["valor"]?.toDouble(),
    hora: json["hora"],
    alias_diccionario: json["alias_diccionario"],
  );

  Map<String, dynamic> toMap() => {
    "fechahora": "${fechahora!.year.toString().padLeft(4, '0')}-${fechahora!.month.toString().padLeft(2, '0')}-${fechahora!.day.toString().padLeft(2, '0')}",
    "id_datos": idDatos,
    "identificador": identificador,
    "nombre_diccionario": nombreDiccionario,
    "id_diccionario": idDiccionario,
    "valor": valor,
    "hora": hora,
    "alias_diccionario": alias_diccionario,

  };

  @override
  String toString() {
    return 'Datum{fechahora: $fechahora, idDatos: $idDatos, identificador: $identificador, nombreDiccionario: $nombreDiccionario, idDiccionario: $idDiccionario, valor: $valor, hora: $hora}';
  }

}
