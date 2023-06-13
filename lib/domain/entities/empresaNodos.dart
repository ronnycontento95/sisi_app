import 'dart:convert';

class EmpresaNodosResponse {
  EmpresaNodosResponse({
    this.ide,
    this.clase,
    this.nombre,
    this.datosEnviados,
    this.valor,
    this.valMin,
    this.valMax,
    this.fechahora,
    this.tipoDato,
    this.lat,
    this.lot
  });

  int? ide;
  String? clase;
  String? nombre;
  int? datosEnviados;
  double? valor;
  double? valMin;
  double? valMax;
  String? fechahora;
  String? tipoDato;
  String? lat;
  String? lot;

  factory EmpresaNodosResponse.fromJson(String str) => EmpresaNodosResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmpresaNodosResponse.fromMap(Map<String, dynamic> json) => EmpresaNodosResponse(
    ide: json["ide"],
    clase: json["clase"],
    nombre: json["nombre"],
    datosEnviados: json["datos_enviados"],
    valor: json["valor"]?.toDouble(),
    valMin: json["val_min"]?.toDouble(),
    valMax: json["val_max"]?.toDouble(),
    fechahora: json["fechahora"],
    tipoDato: json["tipo_dato"],
    lat: json["lat"],
    lot: json["lot"],
  );

  Map<String, dynamic> toMap() => {
    "ide": ide,
    "clase": clase,
    "nombre": nombre,
    "datos_enviados": datosEnviados,
    "valor": valor,
    "val_min": valMin,
    "val_max": valMax,
    "fechahora": fechahora,
    "tipo_dato": tipoDato,
    "lat": lat,
    "lot": lot,
  };

  EmpresaNodosResponse.map(dynamic obj) {
    ide= obj["ide"];
    clase= obj["clase"];
    nombre= obj["nombre"];
    datosEnviados= obj["datos_enviados"];
    valor= obj["valor"];
    valMin= obj["val_min"];
    valMax= obj["val_max"];
    fechahora= obj["fechahora"];
    tipoDato= obj["tipo_dato"];
    lat= obj["lat"];
    lot= obj["lot"];
  }

  @override
  String toString() {
    return 'EmpresaNodosResponse{ide: $ide, clase: $clase, nombre: $nombre, datosEnviados: $datosEnviados, valor: $valor, valMin: $valMin, valMax: $valMax, fechahora: $fechahora, tipoDato: $tipoDato, lat: $lat, lot: $lot}';
  }
}
