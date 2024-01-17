import 'dart:convert';
import 'dart:io';
import 'package:flutteroasis/utils/SP_Global.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutteroasis/src/models/despachos_model.dart';
import 'package:flutteroasis/src/constants/constants.dart';


class DespachoService {

  SPGlobal _prefs = SPGlobal();

  ///hibrido
  Future<List<DespacholistaModel>> cargarDespacho(String initDate, String endDate) async {
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String  idUser =  prefs.getString('idUser')!;

      // var resp = await http.post(kUrl+"/ListadoDespachos",
      String url = kUrl + "/ListadoDespachos";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'FecIni': initDate, 'FecFin': endDate, 'usr':idUser, 'sucursal': _prefs.sucursal}));

      var decodeData = json.decode(resp.body);

      final List<DespacholistaModel> despachos = [];

      decodeData.forEach((informeMap) {
        final prodTemp = DespacholistaModel.fromJson(informeMap);
        despachos.add(prodTemp);
      });
      return despachos;
    } catch (e) {
      print(e);
      return [];
    }
  }

  ///hibrido
  Future<String> estadoAnularDespacho(String id,String idUser) async {

    try{

      print(jsonEncode({'Id': id,'usr': idUser,'sucursal': _prefs.sucursal}));

      // var resp = await http.post(kUrl+"/AnularDespacho",
      String url = kUrl + "/AnularDespacho";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'Id': id,'usr': idUser,'sucursal': _prefs.sucursal}));

      var decodeData = json.decode(resp.body);

      return decodeData["resultado"];


    }catch(e){
      print(e);
      return "0";
    }

  }


  ///hibrido
  Future<String> registrarDespacho(DespachoModel despacho) async{

    try {

      DespachoModel f = new  DespachoModel();
      despacho.sucursal = _prefs.sucursal;

      print(despacho.toJson());

      // var resp = await http.post(kUrl+"/GenerarDespacho",
      String url = kUrl + "/GenerarDespacho";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(despacho.toJson()));
      print(jsonEncode(despacho.toJson()));
      var decodeData = json.decode(resp.body);

      print(decodeData["resultado"]);

      return decodeData["resultado"];



    } catch (e) {
      print(e);
      return "0";
    }
  }

  //new


  Future<ConsultaSunatModel> getConsultaSunat(String ruc) async {  //NO RETORNA LISTA
    print("Sunat Documento a Consultar: " + ruc);
    String url = "http://intranet.gepp.pe:8029/Service/Service1.svc/ObtenerValoresRuc";
    http.Response response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
      body: json.encode(
        {
          "ruc": ruc
        },
      ),
    );
    print("Estado: "+ response.statusCode.toString());
    if(response.statusCode == 200){
      print(response.body); // NO RETORENA UNA LISTA
      return ConsultaSunatModel.fromJson(json.decode(response.body));
    }
    return ConsultaSunatModel.fromJson(json.decode(response.body));
  }


  Future<ConsultaReniecModel> getConsultaReniec(String ruc) async {  //NO RETORNA LISTA
    print("Reniec Documento a Consultar: " + ruc);
    String url = "http://intranet.gepp.pe:8029/Service/Service1.svc/ObtenerValoresDNI";

    http.Response response = await http.post(Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: json.encode(
        {
          "ruc": ruc
        },
      ),
    );
    print("Estado: "+ response.statusCode.toString());
    if(response.statusCode == 200){
      print(response.body); // NO RETORENA UNA LISTA
      return ConsultaReniecModel.fromJson(json.decode(response.body));
    }
    return ConsultaReniecModel.fromJson(json.decode(response.body));
  }


  //cargar el ultimo contometro de puntos de despachos

  ///hibrido
  Future<String> obtenerContometroDePuntoDespacho() async {

    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String  idUser =  prefs.getString('idUser')!;
      // var resp = await http.post(kUrl+"/AnularConsumo",
      String url = kUrl + "/ObtenerUltimoContometro";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({"idUsuario": idUser,"sucursal": _prefs.sucursal }));

      var decodeData = json.decode(resp.body);

     // if({})

      return decodeData["valor"];


    }catch(e){
      print(e);
      return "0";
    }

  }





}
