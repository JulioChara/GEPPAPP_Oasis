import 'dart:convert';
import 'package:flutteroasis/utils/SP_Global.dart';
import 'package:http/http.dart' as http;
import 'package:flutteroasis/src/models/general_model.dart';
import 'package:flutteroasis/src/constants/constants.dart';

class DetailServices {
  SPGlobal _prefs = SPGlobal();

  ///HIBRIDO
  Future<List<Conductor>> cargarConductor() async {
    try {
      // var resp = await http.get(kUrl + "/UtilidadesGuias");
      String url = kUrl + "/UtilidadesGuias";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'sucursal': _prefs.sucursal}));
      // http.Response resp = await http.get(Uri.parse(url), headers: {
      //   'Content-type': 'application/json',
      //   'Accept': 'application/json'
      // });
      var decodeData = json.decode(resp.body);

      final List<Conductor> conductores = [];

      decodeData["Conductores"].forEach((item) {
        final conductorTemp = Conductor.fromJson(item);
        conductores.add(conductorTemp);
      });

      return conductores;
    } catch (e) {
      print(e);
      return [];
    }
  }

  ///HIBRIDO
  Future<List<Cliente>> cargarCliente() async {
    try {
      // var resp = await http.get(kUrl + "/ObtenerClientes");
      String url = kUrl + "/ObtenerClientes";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'sucursal': _prefs.sucursal}));
      // http.Response resp = await http.get(Uri.parse(url), headers: {
      //   'Content-type': 'application/json',
      //   'Accept': 'application/json'
      // });
      var decodeData = json.decode(resp.body);

      final List<Cliente> clientes = [];

      decodeData["Clientes"].forEach((item) {
        final clienteTemp = Cliente.fromJson(item);
        clientes.add(clienteTemp);
      });

      return clientes;
    } catch (e) {
      print(e);
      return [];
    }
  }

  ///HIBRIDO
  Future<List<Responsable>> cargarResponsable() async {
    try {
      // var resp = await http.get(kUrl + "/ObtenerResponsables");
      String url = kUrl + "/ObtenerResponsables";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'sucursal': _prefs.sucursal}));
      // http.Response resp = await http.get(Uri.parse(url), headers: {
      //   'Content-type': 'application/json',
      //   'Accept': 'application/json'
      // });

      var decodeData = json.decode(resp.body);

      final List<Responsable> responsable = [];

      decodeData["Responsables"].forEach((item) {
        final clienteTemp = Responsable.fromJson(item);
        responsable.add(clienteTemp);
      });

      return responsable;
    } catch (e) {
      print(e);
      return [];
    }
  }

  ///HIBRIDO
  Future<List<Placa>> cargarPlaca() async {
    try {
      // var resp = await http.get(kUrl + "/UtilidadesGuias");
      String url = kUrl + "/UtilidadesGuias";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'sucursal': _prefs.sucursal}));
      // http.Response resp = await http.get(Uri.parse(url), headers: {
      //   'Content-type': 'application/json',
      //   'Accept': 'application/json'
      // });

      var decodeData = json.decode(resp.body);

      final List<Placa> placas = [];

      decodeData["Placas"].forEach((item) {
        final placaTemp = Placa.fromJson(item);
        placas.add(placaTemp);
      });


      return placas;
    } catch (e) {
      print(e);
      return [];
    }
  }

  ///HIBRIDO
  Future<List<TipoTipo>> cargarTipoTipo() async {
    try {
      // var resp = await http.get(kUrl + "/UtilidadesGuias");
      String url = kUrl + "/UtilidadesGuias";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'sucursal': _prefs.sucursal}));
      // http.Response resp = await http.get(Uri.parse(url), headers: {
      //   'Content-type': 'application/json',
      //   'Accept': 'application/json'
      // });
      var decodeData = json.decode(resp.body);

      final List<TipoTipo> tipos = [];

      decodeData["TipoTipo"].forEach((item) {
        final tipoTemp = TipoTipo.fromJson(item);
        tipos.add(tipoTemp);
      });


      return tipos;

    } catch (e) {
      print(e);
      return [];
    }
  }

  ///HIBRIDO
  Future<List<TipoProducto>> cargarTipoProducto() async {
    try {
      // var resp = await http.get(kUrl + "/UtilidadesGuias");
      String url = kUrl + "/UtilidadesGuias";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'sucursal': _prefs.sucursal}));
      // http.Response resp = await http.get(Uri.parse(url), headers: {
      //   'Content-type': 'application/json',
      //   'Accept': 'application/json'
      // });

      var decodeData = json.decode(resp.body);

      final List<TipoProducto> tipos = [];

      decodeData["TipoProducto"].forEach((item) {
        final tipoTemp = TipoProducto.fromJson(item);
        tipos.add(tipoTemp);
      });


      return tipos;

    } catch (e) {
      print(e);
      return [];
    }
  }

 }
