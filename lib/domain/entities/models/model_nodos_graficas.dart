import 'dart:convert';

class ModelosNodosGraficos {
  List<GraficosEstado>? graficosEstado;
  NodoIndividual? nodoIndividual;
  List<LineDatum>? lineData;
  List<dynamic>? focoGrafica;

  ModelosNodosGraficos({
    this.graficosEstado,
    this.nodoIndividual,
    this.lineData,
    this.focoGrafica,
  });

  factory ModelosNodosGraficos.fromJson(String str) => ModelosNodosGraficos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelosNodosGraficos.fromMap(Map<String, dynamic> json) => ModelosNodosGraficos(
    graficosEstado: json["graficos_estado"] == null ? [] : List<GraficosEstado>.from(json["graficos_estado"]!.map((x) => GraficosEstado.fromMap(x))),
    nodoIndividual: json["nodo_individual"] == null ? null : NodoIndividual.fromMap(json["nodo_individual"]),
    lineData: json["line_data"] == null ? [] : List<LineDatum>.from(json["line_data"]!.map((x) => LineDatum.fromMap(x))),
    focoGrafica: json["foco_grafica"] == null ? [] : List<dynamic>.from(json["foco_grafica"]!.map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "graficos_estado": graficosEstado == null ? [] : List<dynamic>.from(graficosEstado!.map((x) => x.toMap())),
    "nodo_individual": nodoIndividual?.toMap(),
    "line_data": lineData == null ? [] : List<dynamic>.from(lineData!.map((x) => x.toMap())),
    "foco_grafica": focoGrafica == null ? [] : List<dynamic>.from(focoGrafica!.map((x) => x)),
  };
}

class GraficosEstado {
  DateTime? fechahora;
  String? nombre;
  int? restante;
  String? descripcion;
  String? color;
  int? valor;

  GraficosEstado({
    this.fechahora,
    this.nombre,
    this.restante,
    this.descripcion,
    this.color,
    this.valor,
  });

  factory GraficosEstado.fromJson(String str) => GraficosEstado.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GraficosEstado.fromMap(Map<String, dynamic> json) => GraficosEstado(
    fechahora: json["fechahora"] == null ? null : DateTime.parse(json["fechahora"]),
    nombre: json["nombre"],
    restante: json["restante"],
    descripcion: json["descripcion"],
    color: json["color"],
    valor: json["valor"],
  );

  Map<String, dynamic> toMap() => {
    "fechahora": fechahora?.toIso8601String(),
    "nombre": nombre,
    "restante": restante,
    "descripcion": descripcion,
    "color": color,
    "valor": valor,
  };
}

class LineDatum {
  String? titulo;
  String? tipo;
  String? descripcion;
  List<DateTime>? x;
  List<int>? y;
  String? unidadMedida;

  LineDatum({
    this.titulo,
    this.tipo,
    this.descripcion,
    this.x,
    this.y,
    this.unidadMedida,
  });

  factory LineDatum.fromJson(String str) => LineDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LineDatum.fromMap(Map<String, dynamic> json) => LineDatum(
    titulo: json["titulo"],
    tipo: json["tipo"],
    descripcion: json["descripcion"],
    x: json["x"] == null ? [] : List<DateTime>.from(json["x"]!.map((x) => DateTime.parse(x))),
    y: json["y"] == null ? [] : List<int>.from(json["y"]!.map((x) => x)),
    unidadMedida: json["unidad_medida"],
  );

  Map<String, dynamic> toMap() => {
    "titulo": titulo,
    "tipo": tipo,
    "descripcion": descripcion,
    "x": x == null ? [] : List<dynamic>.from(x!.map((x) => x.toIso8601String())),
    "y": y == null ? [] : List<dynamic>.from(y!.map((x) => x)),
    "unidad_medida": unidadMedida,
  };
}

class NodoIndividual {
  String? nombre;
  int? id;

  NodoIndividual({
    this.nombre,
    this.id,
  });

  factory NodoIndividual.fromJson(String str) => NodoIndividual.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NodoIndividual.fromMap(Map<String, dynamic> json) => NodoIndividual(
    nombre: json["nombre"],
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "nombre": nombre,
    "id": id,
  };
}
