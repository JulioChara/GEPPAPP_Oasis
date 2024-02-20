import 'dart:convert';

ConsumoModel consumoFromJson(String str) => ConsumoModel.fromJson(json.decode(str));

String consumoToJson(ConsumoModel data) => json.encode(data.toJson());


class ConsumolistaModel {
  String? id;
  String? fecha;
  String? ticket;
  String? responsable;
  String? combustible;
  String? destino;
  String? cantidad;
  String? monto;
  String? Estado;
  String? usrCreacion;
  String? mensaje;
  String? resultado;

  ConsumolistaModel({
    this.id,
    this.fecha,
    this.ticket,
    this.responsable,
    this.combustible,
    this.destino,
    this.cantidad,
    this.monto,
    this.Estado,
    this.usrCreacion,
    this.mensaje,
    this.resultado,
  });

  factory ConsumolistaModel.fromJson(Map<String, dynamic> json) => ConsumolistaModel(
    id: json["id"] ?? "",
    fecha: json["fecha"] ?? "",
    ticket: json["ticket"] ?? "",
    responsable: json["responsable"] ?? "",
    destino: json["destino"] ?? "",
    combustible: json["combustible"] ?? "",
    cantidad: json["cantidad"] ?? "",
    monto: json["monto"] ?? "",
    Estado: json["Estado"] ?? "",
    usrCreacion: json["usrCreacion"] ?? "",
    mensaje: json["mensaje"] ?? "",
    resultado: json["resultado"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fecha": fecha,
    "ticket": ticket,
    "responsable": responsable,
    "destino": destino,
    "combustible": combustible,
    "cantidad": cantidad,
    "monto": monto,
    "Estado": Estado,
    "usrCreacion": usrCreacion,
    "mensaje": mensaje,
    "resultado": resultado,
  };
}


class ConsumoModel {
  String? id;
  String? fecha;
  String? ticket;
  String? responsable;
  String? destino;
  String? combustible;
  String? cantidad;
  String? monto;
  String? Estado;
  String? usrCreacion;
  String? mensaje;
  String? resultado;
  String? sucursal;
  String? idCompraFk;

  ConsumoModel({
    this.id,
    this.fecha,
    this.ticket,
    this.responsable,
    this.destino,
    this.combustible,
    this.cantidad,
    this.monto,
    this.Estado,
    this.usrCreacion,
    this.mensaje,
    this.resultado,
    this.sucursal,
    this.idCompraFk,
  });

  factory ConsumoModel.fromJson(Map<String, dynamic> json) => ConsumoModel(
    id: json["id"] ?? "",
    fecha: json["fecha"] ?? "",
    ticket: json["ticket"] ?? "",
    responsable: json["responsable"] ?? "",
    destino: json["destino"] ?? "",
    combustible: json["combustible"] ?? "",
    cantidad: json["cantidad"] ?? "",
    monto: json["monto"] ?? "",
    Estado: json["Estado"] ?? "",
    usrCreacion: json["usrCreacion"] ?? "",
    mensaje: json["mensaje"] ?? "",
    resultado: json["resultado"] ?? "",
    sucursal: json["sucursal"] ?? "",
    idCompraFk: json["idCompraFk"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fecha": fecha,
    "ticket": ticket,
    "responsable": responsable,
    "destino": destino,
    "combustible": combustible,
    "cantidad": cantidad,
    "monto": monto,
    "Estado": Estado,
    "usrCreacion": usrCreacion,
    "mensaje": mensaje,
    "resultado": resultado,
    "sucursal": sucursal,
    "idCompraFk": idCompraFk,
  };
}





class vinculacionModel {
  String? Id;
  String? fecha;
  String? documento;
  String? cantidad;
  String? proveedor;
  String? total;
  String? descripcion;


  vinculacionModel({
    this.Id,
    this.fecha,
    this.documento,
    this.cantidad,
    this.proveedor,
    this.total,
    this.descripcion,
  });

  factory vinculacionModel.fromJson(Map<String, dynamic> json) => vinculacionModel(
    Id: json["Id"] ?? "",
    fecha: json["fecha"] ?? "",
    documento: json["documento"] ?? "",
    cantidad: json["cantidad"] ?? "",
    proveedor: json["proveedor"] ?? "",
    total: json["total"] ?? "",
    descripcion: json["descripcion"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "Id": Id,
    "fecha": fecha,
    "documento": documento,
    "cantidad": cantidad,
    "proveedor": proveedor,
    "total": total,
    "descripcion": descripcion,
  };
}
