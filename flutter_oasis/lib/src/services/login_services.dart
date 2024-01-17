import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutteroasis/src/constants/constants.dart';


class LoginServices {
  Future<String> login(String user, String pwd, String Sucursal) async {
    try {

      // var resp = await http.post(kUrl + "/Login", headers: {
      String url = kUrl + "/Login";
      http.Response resp = await http.post(Uri.parse(url),
        headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
          body: jsonEncode({'usr': user, 'pwd': pwd, 'sucursal': Sucursal}));

      var decodeData = json.decode(resp.body);

      var result = decodeData["resultado"];

      if(result == "1"){
        return decodeData["id"];
      }
      else{
        return decodeData["resultado"];
      }


    } catch (e) {
      print(e);
      return "0";
    }
  }
}