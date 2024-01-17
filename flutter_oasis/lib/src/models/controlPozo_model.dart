
import 'dart:convert';

List<ControlPozoModel> controlPozoModelFromJson(String str) => List<ControlPozoModel>.from(json.decode(str).map((x) => ControlPozoModel.fromJson(x)));

String controlPozoModelToJson(List<ControlPozoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ControlPozoModel {
  ControlPozoModel({
    this.cpConsumoDiferencial,
    this.cpContometroActual,
    this.cpEstado,
    this.cpFechaAnulacion,
    this.cpFechaCreacion,
    this.cpFechaModificacion,
    this.cpFechaRegistro,
    this.cpId,
    this.cpObservaciones,
    this.cpUsuarioAnulacion,
    this.cpUsuarioCreacion,
    this.cpUsuarioCreacionDesc,
    this.cpUsuarioModificacion,
    this.pozoFk,
    this.pozoFkDesk,
    this.mensaje,
    this.resultado,
    this.usuario,
    this.puedeAnular,
    this.sucursal,
  });

  String? cpConsumoDiferencial;
  String? cpContometroActual;
  String? cpEstado;
  String? cpFechaAnulacion;
  String? cpFechaCreacion;
  String? cpFechaModificacion;
  String? cpFechaRegistro;
  String? cpId;
  String? cpObservaciones;
  String? cpUsuarioAnulacion;
  String? cpUsuarioCreacion;
  String? cpUsuarioCreacionDesc;
  String? cpUsuarioModificacion;
  String? pozoFk;
  String? pozoFkDesk;
  String? mensaje;
  String? resultado;
  String? usuario;
  String? puedeAnular;
  String? sucursal;

  factory ControlPozoModel.fromJson(Map<String, dynamic> json) => ControlPozoModel(
    cpConsumoDiferencial: json["CpConsumoDiferencial"],
    cpContometroActual: json["CpContometroActual"],
    cpEstado: json["CpEstado"],
    cpFechaAnulacion: json["CpFechaAnulacion"],
    cpFechaCreacion: json["CpFechaCreacion"],
    cpFechaModificacion: json["CpFechaModificacion"],
    cpFechaRegistro: json["CpFechaRegistro"],
    cpId: json["CpId"],
    cpObservaciones: json["CpObservaciones"],
    cpUsuarioAnulacion: json["CpUsuarioAnulacion"],
    cpUsuarioCreacion: json["CpUsuarioCreacion"],
    cpUsuarioCreacionDesc: json["CpUsuarioCreacionDesc"],
    cpUsuarioModificacion: json["CpUsuarioModificacion"],
    pozoFk: json["PozoFk"],
    pozoFkDesk: json["PozoFkDesk"],
    mensaje: json["mensaje"],
    resultado: json["resultado"],
    usuario: json["usuario"],
    puedeAnular: json["puedeAnular"],
    sucursal: json["sucursal"],
  );

  Map<String, dynamic> toJson() => {
    "CpConsumoDiferencial": cpConsumoDiferencial,
    "CpContometroActual": cpContometroActual,
    "CpEstado": cpEstado,
    "CpFechaAnulacion": cpFechaAnulacion,
    "CpFechaCreacion": cpFechaCreacion,
    "CpFechaModificacion": cpFechaModificacion,
    "CpFechaRegistro": cpFechaRegistro,
    "CpId": cpId,
    "CpObservaciones": cpObservaciones,
    "CpUsuarioAnulacion": cpUsuarioAnulacion,
    "CpUsuarioCreacion": cpUsuarioCreacion,
    "CpUsuarioCreacionDesc": cpUsuarioCreacionDesc,
    "CpUsuarioModificacion": cpUsuarioModificacion,
    "PozoFk": pozoFk,
    "PozoFkDesk": pozoFkDesk,
    "mensaje": mensaje,
    "resultado": resultado,
    "usuario": usuario,
    "puedeAnular": puedeAnular,
    "sucursal": sucursal,
  };
}
