import 'dart:convert';
import 'dart:io';
import 'package:flutteroasis/src/models/controlPozo_model.dart';
import 'package:flutteroasis/src/models/general_model.dart';
import 'package:flutteroasis/utils/SP_Global.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutteroasis/src/models/despachos_model.dart';
import 'package:flutteroasis/src/constants/constants.dart';


class ControlPozosService {

  SPGlobal _prefs = SPGlobal();

  ///HIBRIDO
  Future<List<ControlPozoModel>> listadoRegistrosPozos(String initDate, String endDate) async {
    try {
      List<ControlPozoModel> pedidosList = [];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String  idUser =  prefs.getString('idUser')!;

      String url = kUrl + "/ListadoRegistrosPozos";
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode({
          "FecIni": initDate,
          "FecFin": endDate,
          "usr": idUser,
          "sucursal": _prefs.sucursal
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        List list = jsonDecode(response.body);
        print(response.body);
        print(list);
        pedidosList = list.map((e) => ControlPozoModel.fromJson(e)).toList();
        return pedidosList;
      }
      return pedidosList;
    } catch (e) {

      print(e);
      return [];
    }
  }

  ///HIBRIDO
  Future<List<TiposModel>> getDestinosPozos() async {
    List<TiposModel> tiposList = [];
    String url = kUrl + "/ListarDestinoPozos";
    http.Response response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode({'sucursal': _prefs.sucursal}));
    // http.Response response = await http.get(Uri.parse(url), headers: {
    //   'Content-type': 'application/json',
    //   'Accept': 'application/json'
    // });
    print(response.statusCode);
    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      tiposList = list.map((e) => TiposModel.fromJson(e)).toList();
      return tiposList;
    }
    return tiposList;
  }

  ///HIBRIDO
  Future<String> grabarControlPozos(
      ControlPozoModel model) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String usuario = prefs.getString('idUser')!;
      model.usuario = usuario;
      model.sucursal = _prefs.sucursal;
      print(jsonEncode(model.toJson()));

      String url = kUrl + "/grabarControlPozo";
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(model.toJson()));

      print(jsonEncode(response.body));
      var decodeData = json.decode(response.body);
      print(decodeData["resultado"]);
      return decodeData["resultado"];
    } catch (e) {
      print("Error");
      print(e);
      return "0";
    }
  }

  ///HIBRIDO
  Future<String> anularControlPozos(
      ControlPozoModel model) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String usuario = prefs.getString('idUser')!;
      model.usuario = usuario;
      model.sucursal = _prefs.sucursal;
      print(jsonEncode(model.toJson()));

      String url = kUrl + "/anularControlPozo";
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(model.toJson()));

      print(jsonEncode(response.body));
      var decodeData = json.decode(response.body);
      print(decodeData["resultado"]);
      return decodeData["resultado"];
    } catch (e) {
      print("Error");
      print(e);
      return "0";
    }
  }








}
