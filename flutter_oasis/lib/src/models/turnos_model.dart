import 'dart:convert';

TurnoModel turnoFromJson(String str) => TurnoModel.fromJson(json.decode(str));

String turnoToJson(TurnoModel data) => json.encode(data.toJson());


class TurnolistaModel {
  String? id;
  String? tipoEstado;
  String? turnoApertura;
  String? turnoMonto;
  String? turnoMontoSistema;
  String? usuaridAperturaId;
  String? usuarioApertura;
  String? usuarioCierreId;
  String? usuarioCierre;
  String? fechaDesde;
  String? fechaHasta;
  String? usrCreacion;
  String? mensaje;
  String? resultado;
  String? puntoFkDesc;

  TurnolistaModel({
    this.id,
    this.tipoEstado,
    this.turnoApertura,
    this.turnoMonto,
    this.turnoMontoSistema,
    this.usuaridAperturaId,
    this.usuarioApertura,
    this.usuarioCierreId,
    this.usuarioCierre,
    this.fechaDesde,
    this.fechaHasta,
    this.usrCreacion,
    this.mensaje,
    this.resultado,
    this.puntoFkDesc,
  });

  factory TurnolistaModel.fromJson(Map<String, dynamic> json) => TurnolistaModel(
    id: json["id"] ?? "",
    tipoEstado: json["tipoEstado"] ?? "",
    turnoApertura: json["turnoApertura"] ?? "",
    turnoMonto: json["turnoMonto"] ?? "",
    turnoMontoSistema: json["turnoMontoSistema"] ?? "",
    usuaridAperturaId: json["usuarioAperturaId"] ?? "",
    usuarioApertura: json["usuarioApertura"] ?? "",
    usuarioCierreId: json["usuarioCierreId"] ?? "",
    usuarioCierre: json["usuarioCierre"] ?? "",
    fechaDesde: json["fechaDesde"] ?? "",
    fechaHasta: json["fechaHasta"] ?? "",
    usrCreacion: json["usrCreacion"] ?? "",
    mensaje: json["mensaje"] ?? "",
    resultado: json["resultado"] ?? "",
    puntoFkDesc: json["puntoFkDesc"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tipoEstado": tipoEstado,
    "turnoApertura": turnoApertura,
    "turnoMonto": turnoMonto,
    "turnoMontoSistema": turnoMontoSistema,
    "usuaridAperturaId": usuaridAperturaId,
    "usuarioApertura": usuarioApertura,
    "usuarioCierreId": usuarioCierreId,
    "usuarioCierre": usuarioCierre,
    "fechaDesde": fechaDesde,
    "fechaHasta": fechaHasta,
    "usrCreacion": usrCreacion,
    "mensaje": mensaje,
    "resultado": resultado,
    "puntoFkDesc": puntoFkDesc,
  };
}


class TurnoModel {
  String? id;
  String? tipoEstado;
  String? turnoApertura;
  String? turnoMonto;
  String? turnoMontoSistema;
  String? usuaridAperturaId;
  String? usuarioApertura;
  String? usuarioCierreId;
  String? usuarioCierre;
  String? fechaDesde;
  String? fechaHasta;
  String? usrCreacion;
  String? mensaje;
  String? resultado;
  String? puntoDespachoFk;
  String? galApertura;
  String? galCierre;
  String? galTurno;
  String? galCubosCalculados;
  String? sucursal;

  TurnoModel({
    this.id,
    this.tipoEstado,
    this.turnoApertura,
    this.turnoMonto,
    this.turnoMontoSistema,
    this.usuaridAperturaId,
    this.usuarioApertura,
    this.usuarioCierreId,
    this.usuarioCierre,
    this.fechaDesde,
    this.fechaHasta,
    this.usrCreacion,
    this.mensaje,
    this.resultado,
    this.puntoDespachoFk,
    this.galApertura,
    this.galCierre,
    this.galTurno,
    this.galCubosCalculados,
    this.sucursal,
  });

  factory TurnoModel.fromJson(Map<String, dynamic> json) => TurnoModel(
    id: json["id"] ?? "",
    tipoEstado: json["tipoEstado"] ?? "",
    turnoApertura: json["turnoApertura"] ?? "",
    turnoMonto: json["turnoMonto"] ?? "",
    turnoMontoSistema: json["turnoMontoSistema"] ?? "",
    usuaridAperturaId: json["usuaridAperturaId"] ?? "",
    usuarioApertura: json["usuarioApertura"] ?? "",
    usuarioCierreId: json["usuarioCierreId"] ?? "",
    usuarioCierre: json["usuarioCierre"] ?? "",
    fechaDesde: json["fechaDesde"] ?? "",
    fechaHasta: json["fechaHasta"] ?? "",
    usrCreacion: json["usrCreacion"] ?? "",
    mensaje: json["mensaje"] ?? "",
    resultado: json["resultado"] ?? "",
    puntoDespachoFk: json["puntoDespachoFk"] ?? "",
    galApertura: json["galApertura"] ?? "",
    galCierre: json["galCierre"] ?? "",
    galTurno: json["galTurno"] ?? "",
    galCubosCalculados: json["galCubosCalculados"] ?? "",
    sucursal: json["sucursal"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tipoEstado": tipoEstado,
    "turnoApertura": turnoApertura,
    "turnoMonto": turnoMonto,
    "turnoMontoSistema": turnoMontoSistema,
    "usuaridAperturaId": usuaridAperturaId,
    "usuarioApertura": usuarioApertura,
    "usuarioCierreId": usuarioCierreId,
    "usuarioCierre": usuarioCierre,
    "fechaDesde": fechaDesde,
    "fechaHasta": fechaHasta,
    "usrCreacion": usrCreacion,
    "mensaje": mensaje,
    "resultado": resultado,
    "puntoDespachoFk": puntoDespachoFk,
    "galApertura": galApertura,
    "galCierre": galCierre,
    "galTurno": galTurno,
    "galCubosCalculados": galCubosCalculados,
    "sucursal": sucursal,
  };
}
