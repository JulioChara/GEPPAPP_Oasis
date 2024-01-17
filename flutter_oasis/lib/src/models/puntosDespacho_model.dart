import 'dart:convert';

List<PuntosDespachoModel?>? puntosDespachoModelFromJson(String str) => json.decode(str) == null ? [] : List<PuntosDespachoModel?>.from(json.decode(str)!.map((x) => PuntosDespachoModel.fromJson(x)));

String puntosDespachoModelToJson(List<PuntosDespachoModel?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));  //comillas despues de dataXD?

class PuntosDespachoModel {
  PuntosDespachoModel({
    this.pdContometroActual,
    this.pdDescripcion,
    this.pdEstado,
    this.pdFechaAnulacion,
    this.pdFechaCreacion,
    this.pdFechaModificacion,
    this.pdId,
    this.pdUsuarioAnulacion,
    this.pdUsuarioCreacion,
    this.pdUsuarioModificacion,
    this.mensaje,
    this.resultado,
  });

  String? pdContometroActual;
  String? pdDescripcion;
  String? pdEstado;
  String? pdFechaAnulacion;
  String? pdFechaCreacion;
  String? pdFechaModificacion;
  String? pdId;
  String? pdUsuarioAnulacion;
  String? pdUsuarioCreacion;
  String? pdUsuarioModificacion;
  String? mensaje;
  String? resultado;

  factory PuntosDespachoModel.fromJson(Map<String, dynamic> json) => PuntosDespachoModel(
    pdContometroActual: json["PdContometroActual"],
    pdDescripcion: json["PdDescripcion"],
    pdEstado: json["PdEstado"],
    pdFechaAnulacion: json["PdFechaAnulacion"],
    pdFechaCreacion: json["PdFechaCreacion"],
    pdFechaModificacion: json["PdFechaModificacion"],
    pdId: json["PdId"],
    pdUsuarioAnulacion: json["PdUsuarioAnulacion"],
    pdUsuarioCreacion: json["PdUsuarioCreacion"],
    pdUsuarioModificacion: json["PdUsuarioModificacion"],
    mensaje: json["mensaje"],
    resultado: json["resultado"],
  );

  Map<String, dynamic> toJson() => {
    "PdContometroActual": pdContometroActual,
    "PdDescripcion": pdDescripcion,
    "PdEstado": pdEstado,
    "PdFechaAnulacion": pdFechaAnulacion,
    "PdFechaCreacion": pdFechaCreacion,
    "PdFechaModificacion": pdFechaModificacion,
    "PdId": pdId,
    "PdUsuarioAnulacion": pdUsuarioAnulacion,
    "PdUsuarioCreacion": pdUsuarioCreacion,
    "PdUsuarioModificacion": pdUsuarioModificacion,
    "mensaje": mensaje,
    "resultado": resultado,
  };
}
