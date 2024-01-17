import 'dart:convert';
import 'dart:io';
import 'package:flutteroasis/utils/SP_Global.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutteroasis/src/models/consumos_model.dart';
import 'package:flutteroasis/src/constants/constants.dart';


class ConsumoService {

  SPGlobal _prefs = SPGlobal();

/// HIBRIDO
  Future<List<ConsumolistaModel>> cargarConsumo(String initDate, String endDate) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String idUser = prefs.getString('idUser')!;
      String url = kUrl + "/ListadoConsumos";
      http.Response resp = await http.post(Uri.parse(url),
      // var resp = await http.post(kUrl+"/ListadoConsumos",
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },

          body: jsonEncode({'FecIni': initDate, 'FecFin': endDate, 'usr':idUser, 'sucursal': _prefs.sucursal}));

      var decodeData = json.decode(resp.body);

      final List<ConsumolistaModel> consumos = [];

      decodeData.forEach((consumoMap) {
        final prodTemp = ConsumolistaModel.fromJson(consumoMap);
        consumos.add(prodTemp);
      });
      return consumos;
    } catch (e) {

      print(e);
      return [];
    }
  }

  ///HIBRIDO
  Future<String> estadoAnularConsumo(String id,String idUser) async {

    try{

      print(jsonEncode({'Id': id,'usr': idUser,}));

      // var resp = await http.post(kUrl+"/AnularConsumo",
      String url = kUrl + "/AnularConsumo";
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


///HIBRIDO
  Future<String> registrarConsumo(ConsumoModel consumo) async{

    try {
      consumo.sucursal = _prefs.sucursal;

      print(consumo.toJson());

      // var resp = await http.post(kUrl+"/GenerarConsumo",
      String url = kUrl + "/GenerarConsumo";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(consumo.toJson()));
      print(jsonEncode(consumo.toJson()));
      var decodeData = json.decode(resp.body);

      print(decodeData["resultado"]);

      return decodeData["resultado"];



    } catch (e) {
      print(e);
      return "0";
    }
  }


}
