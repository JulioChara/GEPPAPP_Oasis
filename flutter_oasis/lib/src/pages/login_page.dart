import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutteroasis/utils/SP_Global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutteroasis/src/services/login_services.dart';

const List<String> list = <String>['SELECCIONE---','CHALA VIEJO', 'TITAN'];

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isFetching = false;
  String _email = "", _password = "", _Sucursal = "";

  SPGlobal _prefs = SPGlobal();
  String dropdownValue = list.first;

  LoginServices loginServices = new LoginServices();

  _submit() async {
//    if (isValid) {
//      setState(() {
//        _isFetching = true;
//      });
//      bool isOk = await _accountAPI.login(_email, _password);
//      print(isOk);
//      if (isOk) {
//        SharedPreferences prefs = await SharedPreferences.getInstance();
//        await prefs.setBool("wasLogin", true);
//        Navigator.pushReplacementNamed(context, HomePage.routeName);
//      }else{
//        setState(() {
//          _isFetching = false;
//        });
//        await Dialogs.alert(
//          context,
//          title: "Error",
//          body: "Email o contraseña incorrectos",
//        );
//      }
//    }

    setState(() {
      _isFetching = true;
    });

    String rpta = await loginServices.login(_email, _password, _Sucursal);
    print(rpta);

    if (rpta == "0") {
      setState(() {
        _isFetching = false;
      });

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: Text("Atención"),
              content: Text(
                  "Hubo un problema, verifique sus datos e inténtelo nuevamente."),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Aceptar"),
                )
              ],
            );
          });
    }else{
      setState(() {
        _isFetching = false;
      });


      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("wasLogin", true);
      await prefs.setString("idUser", rpta);
      await prefs.setString("nameUser", _email);
      _prefs.usNombre = _email.toUpperCase();
      _prefs.sucursal = _Sucursal.toUpperCase();


      Navigator.pushReplacementNamed(context, 'home', arguments: _email);
    }



//    if (rpta != "0") {

//    } else {
//      setState(() {
//        _isFetching = false;
//      });
//
//    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
          if (_isFetching)
            Positioned(
              child: Container(
                color: Colors.black26,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final primerFondo = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blueAccent),

          // gradient: LinearGradient(Colors: <Color>[
          //   Color(0xFFF7F7F7),
          //   Color(0xFFF7F7F7),
          // ])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.1)),
    );

    return Stack(
      children: <Widget>[
        primerFondo,
        Positioned(
          top: 90.0,
          left: 30.0,
          child: circulo,
        ),
        Positioned(
          top: -40.0,
          right: -30.0,
          child: circulo,
        ),
        Positioned(
          bottom: -50.0,
          right: -10.0,
          child: circulo,
        ),
        Positioned(
          bottom: 120.0,
          right: 20.0,
          child: circulo,
        ),
        Positioned(
          bottom: -50.0,
          left: -20.0,
          child: circulo,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 200.0,
                padding: EdgeInsets.only(top: 70.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset("assets/logo.png"),
                ))
          ],
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 3.0),
                      spreadRadius: 3.0),
                ]),
            child: Column(
              children: <Widget>[


                Text(
                  "INGRESO",
                  style: TextStyle(fontSize: 30.0, letterSpacing: 1.0),
                ),
                SizedBox(
                  height: 60.0,
                ),
                _crearDropDown(),
                SizedBox(
                  height: 60.0,
                ),
                _crearEmail(),
                SizedBox(height: 20),
                _crearPassword(),
                SizedBox(height: 50),
                _crearBoton(),
              ],
            ),
          ),
          SizedBox(
            height: 50.0,
          )
        ],
      ),
    );
  }

  Widget _crearEmail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Color(0xFF2E7D32)),
          hintText: "Usuario",
          labelText: "Usuario",
        ),
        onChanged: (value) {
          _email = value;
        },
      ),
    );
  }

  Widget _crearPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline, color: Color(0xFF2E7D32)),
          labelText: "Contraseña",
        ),
        onChanged: (value) {
          _password = value;
        },
      ),
    );
  }



  showMessajeAW(DialogType type, String titulo, String desc, int accion) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: type,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      closeIcon: const Icon(Icons.close_fullscreen_outlined),
      title: titulo,
      descTextStyle: TextStyle(fontSize: 18),
      desc: desc,
      //  btnCancelOnPress: () {},
      onDissmissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
      btnOkOnPress: () {
        switch (accion) {
          case 0:
            {
              // nada
            }
            break;
          case 1:
            {
              Navigator.pushReplacementNamed(
                context,
                'home',
              );
            }
            break;
        }
      },
    ).show();
  }

  Widget _crearBoton() {
    return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text("Ingresar"),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 0.0,
        color: Color(0xFF2E7D32),
        textColor: Colors.white,
        onPressed: () {
          if(dropdownValue =='SELECCIONE---'){
            showMessajeAW(DialogType.ERROR, 'ERROR', 'DEBE SELECCIONAR UN PUNTO DE DESPACHO', 0);
          }else{
            _submit();
          }

        });
  }


  Widget _crearDropDown() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 4,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          _Sucursal=value;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

}
