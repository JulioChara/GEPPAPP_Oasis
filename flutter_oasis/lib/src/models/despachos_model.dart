import 'dart:convert';

DespachoModel despachoFromJson(String str) => DespachoModel.fromJson(json.decode(str));

String despachoToJson(DespachoModel data) => json.encode(data.toJson());


class DespacholistaModel {
  String? id;
  String? fecha;
  String? contInicial;
  String? contFinal;
  String? destino;
  String? conductor;
  String? placa;
  String? cantidad;
  String? Estado;
  String? monto;
  String? tipoDespacho;
  String? usrCreacion;
  String? mensaje;
  String? resultado;
  String? puntoFk;
  String? puntoFkDesc;

  DespacholistaModel({
    this.id,
    this.fecha,
    this.contInicial,
    this.contFinal,
    this.destino,
    this.conductor,
    this.placa,
    this.cantidad,
    this.Estado,
    this.monto,
    this.tipoDespacho,
    this.usrCreacion,
    this.mensaje,
    this.resultado,
    this.puntoFk,
    this.puntoFkDesc,
  });

  factory DespacholistaModel.fromJson(Map<String, dynamic> json) => DespacholistaModel(
    id: json["id"] ?? "",
    fecha: json["fecha"] ?? "",
    contInicial: json["contInicial"] ?? "",
    contFinal: json["contFinal"] ?? "",
    destino: json["destino"] ?? "",
    conductor: json["conductor"] ?? "",
    placa: json["placa"] ?? "",
    cantidad: json["cantidad"] ?? "",
    Estado: json["Estado"] ?? "",
    monto: json["monto"] ?? "",
    tipoDespacho: json["tipoDespacho"] ?? "",
    usrCreacion: json["usrCreacion"] ?? "",
    mensaje: json["mensaje"] ?? "",
    resultado: json["resultado"] ?? "",
    puntoFk: json["puntoFk"] ?? "",
    puntoFkDesc: json["puntoFkDesc"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fecha": fecha,
    "contInicial": contInicial,
    "contFinal": contFinal,
    "destino": destino,
    "conductor": conductor,
    "placa": placa,
    "cantidad": cantidad,
    "Estado": Estado,
    "monto": monto,
    "tipoDespacho": tipoDespacho,
    "usrCreacion": usrCreacion,
    "mensaje": mensaje,
    "resultado": resultado,
    "puntoFk": puntoFk,
    "puntoFkDesc": puntoFkDesc,
  };
}


class DespachoModel {
  String? id;
  String? fecha;
  String? contInicial;
  String? contFinal;
  String? destino;
  String? clienteFinal;
  String? conductor;
  String? placa;
  String? cantidad;
  String? Estado;
  String? monto;
  String? observacion;
  String? tipoDespacho;
  String? usrCreacion;
  String? mensaje;
  String? resultado;
  String? docOnline;
  String? razOnline;
  String? puntoFk;
  String? puntoFkDesc;
  String? telefono;
  String? sucursal;


  DespachoModel({
    this.id,
    this.fecha,
    this.contInicial,
    this.contFinal,
    this.destino,
    this.clienteFinal,
    this.conductor,
    this.placa,
    this.cantidad,
    this.Estado,
    this.monto,
    this.observacion,
    this.tipoDespacho,
    this.usrCreacion,
    this.mensaje,
    this.resultado,
    this.docOnline,
    this.razOnline,
    this.puntoFk,
    this.puntoFkDesc,
    this.telefono,
    this.sucursal,
  });

  factory DespachoModel.fromJson(Map<String, dynamic> json) => DespachoModel(
    id: json["id"] ?? "",
    fecha: json["fecha"] ?? "",
    contInicial: json["contInicial"] ?? "",
    contFinal: json["contFinal"] ?? "",
    destino: json["destino"] ?? "",
    clienteFinal: json["clienteFinal"] ?? "",
    conductor: json["conductor"] ?? "",
    placa: json["placa"] ?? "",
    cantidad: json["cantidad"] ?? "",
    Estado: json["Estado"] ?? "",
    monto: json["monto"] ?? "",
    observacion: json["observacion"] ?? "",
    tipoDespacho: json["tipoDespacho"] ?? "",
    usrCreacion: json["usrCreacion"] ?? "",
    mensaje: json["mensaje"] ?? "",
    resultado: json["resultado"] ?? "",
    docOnline: json["docOnline"] ?? "",
    razOnline: json["razOnline"] ?? "",
    puntoFk: json["puntoFk"] ?? "",
    puntoFkDesc: json["puntoFkDesc"] ?? "",
    telefono: json["telefono"] ?? "",
    sucursal: json["sucursal"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fecha": fecha,
    "contInicial": contInicial,
    "contFinal": contFinal,
    "destino": destino,
    "clienteFinal": clienteFinal,
    "conductor": conductor,
    "placa": placa,
    "cantidad": cantidad,
    "Estado": Estado,
    "monto": monto,
    "observacion": observacion,
    "tipoDespacho": tipoDespacho,
    "usrCreacion": usrCreacion,
    "mensaje": mensaje,
    "resultado": resultado,
    "docOnline": docOnline,
    "razOnline": razOnline,
    "puntoFk": puntoFk,
    "puntoFkDesc": puntoFkDesc,
    "telefono": telefono,
    "sucursal": sucursal,
  };
}


//CONSULTADOR DE DOCUMENTOS //

class ConsultaSunatModel {
  ConsultaSunatModel({
    this.direccion,
    this.razonSocial,
    this.ruc,
  });

  String? direccion;
  String? razonSocial;
  String? ruc;

  factory ConsultaSunatModel.fromJson(Map<String, dynamic> json) => ConsultaSunatModel(
    direccion: json["Direccion"],
    razonSocial: json["RazonSocial"],
    ruc: json["Ruc"],
  );

  Map<String, dynamic> toJson() => {
    "Direccion": direccion,
    "RazonSocial": razonSocial,
    "Ruc": ruc,
  };
}



class ConsultaReniecModel {
  ConsultaReniecModel({
    this.aMaterno,
    this.aPaterno,
    this.dni,
    this.direccion,
    this.nombres,
    this.razonSocial,
  });

  String? aMaterno;
  String? aPaterno;
  String? dni;
  String? direccion;
  String? nombres;
  String? razonSocial;

  factory ConsultaReniecModel.fromJson(Map<String, dynamic> json) => ConsultaReniecModel(
    aMaterno: json["AMaterno"],
    aPaterno: json["APaterno"],
    dni: json["DNI"],
    direccion: json["Direccion"],
    nombres: json["Nombres"],
    razonSocial: json["RazonSocial"],
  );

  Map<String, dynamic> toJson() => {
    "AMaterno": aMaterno,
    "APaterno": aPaterno,
    "DNI": dni,
    "Direccion": direccion,
    "Nombres": nombres,
    "RazonSocial": razonSocial,
  };
}
