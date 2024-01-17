import 'dart:convert';

List<Conductor> conductorFromJson(String str) => List<Conductor>.from(json.decode(str).map((x) => Conductor.fromJson(x)));

String conductorToJson(List<Conductor> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Conductor {
  String? Titulo;
  String? Id;
  String? Documento;
  String? RazonSocial;

  Conductor({
    this.Titulo,
    this.Id,
    this.Documento,
    this.RazonSocial,
  });

  factory Conductor.fromJson(Map<String, dynamic> json) => Conductor(
    Titulo: json["Titulo"] ?? "",
    Id: json["Id"] ?? "",
    Documento: json["Documento"] ?? "",
    RazonSocial: json["RazonSocial"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "Titulo": Titulo,
    "Id": Id,
    "Documento": Documento,
    "RazonSocial": RazonSocial,
  };
}


class Responsable {
  String? Titulo;
  String? Id;
  String? Documento;
  String? RazonSocial;

  Responsable({
    this.Titulo,
    this.Id,
    this.Documento,
    this.RazonSocial,
  });

  factory Responsable.fromJson(Map<String, dynamic> json) => Responsable(
    Titulo: json["Titulo"] ?? "",
    Id: json["Id"] ?? "",
    Documento: json["Documento"] ?? "",
    RazonSocial: json["RazonSocial"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "Titulo": Titulo,
    "Id": Id,
    "Documento": Documento,
    "RazonSocial": RazonSocial,
  };
}


class Cliente {
  String? direccion;
  String? documento;
  String? id;
  String? razonSocial;
  String? titulo;

  Cliente({
    this.direccion,
    this.documento,
    this.id,
    this.razonSocial,
    this.titulo,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
    direccion: json["Direccion"] ?? "",
    documento: json["Documento"] ?? "",
    id: json["Id"] ?? "",
    razonSocial: json["RazonSocial"] ?? "",
    titulo: json["Titulo"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "Direccion": direccion,
    "Documento": documento,
    "Id": id,
    "RazonSocial": razonSocial,
    "Titulo": titulo,
  };
}


class Placa {
  String? Titulo;
  String? Id;
  String? Descripcion;
  String? Categoria;
  String? Serie;

  Placa({
    this.Titulo,
    this.Id,
    this.Descripcion,
    this.Categoria,
    this.Serie,
  });

  factory Placa.fromJson(Map<String, dynamic> json) => Placa(
    Titulo: json["Titulo"] ?? "",
    Id: json["Id"] ?? "",
    Descripcion: json["Descripcion"] ?? "",
    Categoria: json["Categoria"] ?? "",
    Serie: json["Serie"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "Titulo": Titulo,
    "Id": Id,
    "Descripcion": Descripcion,
    "Categoria": Categoria,
    "Serie": Serie,
  };
}



class TipoTipo {
  String? categoria;
  String? descripcion;
  String? id;
  String? titulo;

  TipoTipo({
    this.categoria,
    this.descripcion,
    this.id,
    this.titulo,
  });

  factory TipoTipo.fromJson(Map<String, dynamic> json) => TipoTipo(
    categoria: json["Categoria"] ?? "",
    descripcion: json["Descripcion"] ?? "",
    id: json["Id"] ?? "",
    titulo: json["Titulo"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "Categoria": categoria,
    "Descripcion": descripcion,
    "Id": id,
    "Titulo": titulo,
  };
}


class TipoProducto {
  String? categoria;
  String? descripcion;
  String? id;
  String? titulo;

  TipoProducto({
    this.categoria,
    this.descripcion,
    this.id,
    this.titulo,
  });

  factory TipoProducto.fromJson(Map<String, dynamic> json) => TipoProducto(
    categoria: json["Categoria"] ?? "",
    descripcion: json["Descripcion"] ?? "",
    id: json["Id"] ?? "",
    titulo: json["Titulo"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "Categoria": categoria,
    "Descripcion": descripcion,
    "Id": id,
    "Titulo": titulo,
  };
}




class TiposModel {
  TiposModel({
    this.tipoDescripcion,
    this.tipoDescripcionCorta,
    this.tipoEstado,
    this.tipoId,
    this.tiposGeneralFk,
  });

  String? tipoDescripcion;
  String? tipoDescripcionCorta;
  String? tipoEstado;
  String? tipoId;
  String? tiposGeneralFk;

  factory TiposModel.fromJson(Map<String, dynamic> json) => TiposModel(
    tipoDescripcion: json["TipoDescripcion"],
    tipoDescripcionCorta: json["TipoDescripcionCorta"],
    tipoEstado: json["TipoEstado"],
    tipoId: json["TipoId"],
    tiposGeneralFk: json["TiposGeneralFk"],
  );

  Map<String, dynamic> toJson() => {
    "TipoDescripcion": tipoDescripcion,
    "TipoDescripcionCorta": tipoDescripcionCorta,
    "TipoEstado": tipoEstado,
    "TipoId": tipoId,
    "TiposGeneralFk": tiposGeneralFk,
  };
}



class AquaModel {
  AquaModel({
    this.id,
    this.mensaje,
    this.resultado,
    this.valor,
  });

  String? id;
  String? mensaje;
  String? resultado;
  String? valor;

  factory AquaModel.fromJson(Map<String, dynamic> json) => AquaModel(
    id: json["id"],
    mensaje: json["mensaje"],
    resultado: json["resultado"],
    valor: json["valor"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mensaje": mensaje,
    "resultado": resultado,
    "valor": valor,
  };
}
