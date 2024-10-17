import 'dart:convert';

class DatosDevice {
  Nodo? nodo;
  List<UltimosDato>? ultimosDatos;

  DatosDevice({
    this.nodo,
    this.ultimosDatos,
  });

  factory DatosDevice.fromJson(String str) => DatosDevice.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DatosDevice.fromMap(Map<String, dynamic> json) => DatosDevice(
        nodo: json["nodo"] == null ? null : Nodo.fromMap(json["nodo"]),
        ultimosDatos: json["ultimos_datos"] == null
            ? []
            : List<UltimosDato>.from(
                json["ultimos_datos"]!.map((x) => UltimosDato.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "nodo": nodo?.toMap(),
        "ultimos_datos": ultimosDatos == null
            ? []
            : List<dynamic>.from(ultimosDatos!.map((x) => x.toMap())),
      };

  @override
  String toString() {
    return 'DatosDevice{nodo: $nodo, ultimosDatos: $ultimosDatos}';
  }
}

class Nodo {
  int? id;
  String? nombre;
  String? latitud;
  String? longitud;
  String? nombrePresentar;

  Nodo({
    this.id,
    this.nombre,
    this.latitud,
    this.longitud,
    this.nombrePresentar,
  });

  factory Nodo.fromJson(String str) => Nodo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Nodo.fromMap(Map<String, dynamic> json) => Nodo(
        id: json["id"],
        nombre: json["nombre"],
        latitud: json["latitud"],
        longitud: json["longitud"],
        nombrePresentar: json["nombre_presentar"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "latitud": latitud,
        "longitud": longitud,
        "nombre_presentar": nombrePresentar,
      };

  @override
  String toString() {
    return 'Nodo{id: $id, nombre: $nombre, latitud: $latitud, longitud: $longitud, nombrePresentar: $nombrePresentar}';
  }
}

class UltimosDato {
  double? valor;
  DateTime? fechahora;
  int? idDiccionario;
  String? alias;
  String? unidadMedida;
  String? tipo;
  int? identificador;

  UltimosDato(
      {this.valor,
      this.fechahora,
      this.idDiccionario,
      this.alias,
      this.unidadMedida,
      this.tipo,
      this.identificador});

  factory UltimosDato.fromJson(String str) => UltimosDato.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UltimosDato.fromMap(Map<String, dynamic> json) => UltimosDato(
        valor: json["valor"]?.toDouble(),
        fechahora: json["fechahora"] == null ? null : DateTime.parse(json["fechahora"]),
        idDiccionario: json["id_diccionario"],
        alias: json["alias"],
        unidadMedida: json["unidad_medida"],
        tipo: json["tipo"],
        identificador: json["identificador"],
      );

  Map<String, dynamic> toMap() => {
        "valor": valor,
        "fechahora": fechahora?.toIso8601String(),
        "id_diccionario": idDiccionario,
        "alias": alias,
        "tipo": tipo,
        "identificador": identificador,
        "unidad_medida": unidadMedida,
      };

  @override
  String toString() {
    return 'UltimosDato{valor: $valor, fechahora: $fechahora, idDiccionario: $idDiccionario, alias: $alias, unidadMedida: $unidadMedida, tipo: $tipo, identificador: $identificador}';
  }
}
