import 'dart:convert';
import 'dart:io';
import 'package:flutteroasis/src/models/puntosDespacho_model.dart';
import 'package:flutteroasis/utils/SP_Global.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutteroasis/src/models/turnos_model.dart';
import 'package:flutteroasis/src/constants/constants.dart';


class TurnoService {
  SPGlobal _prefs = SPGlobal();

  ///HIBRIDO
  Future<List<TurnolistaModel>> cargarTurno(String initDate, String endDate) async {
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String  idUser =  prefs.getString('idUser')! ;

      // var resp = await http.post(kUrl+"/ListadoTurnos",
      String url = kUrl + "/ListadoTurnos";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'FecIni': initDate, 'FecFin': endDate, 'usr':idUser, 'sucursal': _prefs.sucursal}));

      var decodeData = json.decode(resp.body);

      final List<TurnolistaModel> turnos = [];

      decodeData.forEach((turnoMap) {
        final prodTemp = TurnolistaModel.fromJson(turnoMap);
        turnos.add(prodTemp);
      });
      return turnos;
    } catch (e) {
      print(e);
      return [];
    }
  }

  ///HIBRIDO
  Future<String> registrarTurno(TurnoModel turno) async{

    try {

      turno.sucursal = _prefs.sucursal;
      print(turno.toJson());

      // var resp = await http.post(kUrl+"/GenerarTurno",
      String url = kUrl + "/GenerarTurno";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(turno.toJson()));
      print(jsonEncode(turno.toJson()));
      var decodeData = json.decode(resp.body);

      print(decodeData["resultado"]);

      return decodeData["resultado"];



    } catch (e) {
      print(e);
      return "0";
    }
  }


  ///HIBRIDO
  Future<String> cerrarTurno(TurnoModel turno) async{

    try {

      TurnoModel f = new  TurnoModel();
      print(turno.toJson());
      turno.sucursal = _prefs.sucursal;
      // var resp = await http.post(kUrl+"/CerrarTurno",
      String url = kUrl + "/CerrarTurno";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(turno.toJson()));
      print(jsonEncode(turno.toJson()));
      var decodeData = json.decode(resp.body);

      print(decodeData["resultado"]);

      return decodeData["resultado"];



    } catch (e) {
      print(e);
      return "0";
    }
  }

  ////////////////////NUEVBAS MIAS XD 01/12/2022 ///////////////
  ///HIBRIDO
  Future<String> turnoConsultaExistenciaxUsuario(String idUsuario) async{

    try {

      String url = kUrl + "/turnoConfirmarExistenciaTurnoxUsuario";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'idUsuario': idUsuario,'sucursal': _prefs.sucursal}));
          // body: jsonEncode(turno.toJson()));
   //   print(jsonEncode(turno.toJson()));
      var decodeData = json.decode(resp.body);
      print(decodeData["resultado"]);
      return decodeData["resultado"];
    } catch (e) {
      print(e);
      return "error";
    }
  }


  ///HIBRIDO
  Future<List<PuntosDespachoModel>> cargarPuntosDespacho() async {
    try {
      String url = kUrl + "/ListadoPuntosdeDespacho";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'sucursal': _prefs.sucursal}));
      var decodeData = json.decode(resp.body);

      final List<PuntosDespachoModel> informe = [];

      decodeData.forEach((informeMap) {
        final prodTemp = PuntosDespachoModel.fromJson(informeMap);
        informe.add(prodTemp);
      });
      return informe;
    } catch (e) {
      print(e);
      return [];
    }
  }



//
  // Future<List<PuntosDespachoModel>> cargarPuntosDespacho() async {
  //   try {
  //
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String  idUser =  prefs.getString('idUser')!;
  //
  //     // var resp = await http.post(kUrl+"/ListadoDespachos",
  //     String url = kUrl + "/ListadoPuntosdeDespacho";
  //     http.Response resp = await http.get(Uri.parse(url),
  //         headers: {
  //           'Content-type': 'application/json',
  //           'Accept': 'application/json'
  //         });
  //
  //
  //     var decodeData = json.decode(resp.body);
  //
  //     final List<PuntosDespachoModel> informe = [];
  //
  //     decodeData.forEach((informeMap) {
  //       final prodTemp = PuntosDespachoModel.fromJson(informeMap);
  //       informe.add(prodTemp);
  //     });
  //     return informe;
  //   } catch (e) {
  //     print(e);
  //     return [];
  //   }
  // }



}
