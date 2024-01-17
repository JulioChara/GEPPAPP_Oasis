import 'package:flutter/material.dart';
import 'package:flutteroasis/utils/SP_Global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuWidget extends StatefulWidget {


  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {

  SPGlobal _prefs = SPGlobal();
  String nameUser = "";
  _cerrarSesion(context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacementNamed(context, 'login');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _valorInicial();
  }


  _valorInicial()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nameUser = await prefs.getString("nameUser")!;
    print(nameUser);
  }

  @override
  Widget build(BuildContext context) {



    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(''),
            decoration: BoxDecoration(

                color: Colors.blue,
                image: DecorationImage(
                    image: NetworkImage("https://c4.wallpaperflare.com/wallpaper/200/112/950/material-design-design-wallpaper-preview.jpg"),
                    fit: BoxFit.cover)
            ),
          ),

          // ListTile(
          //   leading: Icon(
          //     Icons.person_pin,
          //     size: 50,
          //     color: Colors.green,
          //   ),
          ListTile(
            leading: _prefs.usNombre== "JULIO"? CircleAvatar(
              radius: 30,
              backgroundColor: Colors.teal,
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    "https://www.anmosugoi.com/wp-content/uploads/2022/04/date-a-live-iv-portada-1.jpg"),
              ),
            ): Icon(
                Icons.person_pin,
                size: 50,
                color: Colors.green,
              ),
            title: Text(_prefs.usNombre,overflow: TextOverflow.ellipsis),
            subtitle: Text(_prefs.sucursal,overflow: TextOverflow.ellipsis),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(2),
            ),
            //  subtitle: Text(_prefs.rolName, style: TextStyle(color: Colors.black)),
          ),



          ListTile(
            leading: Icon(
              Icons.devices_other,
              color: Colors.blueAccent,
            ),
            title: Text("Turnos"),
            onTap: () =>
                Navigator.pushReplacementNamed(context, 'turno'),
            // Navigator.pushReplacementNamed(context, 'home', arguments: _email);
          ),
          ListTile(
            leading:Icon(
              Icons.directions_car,
              color: Colors.blueAccent,
            ),
            title: Text("Despachos Agua"),
            onTap: () =>
                Navigator.pushReplacementNamed(context, 'home'),
          ),
          ListTile(
            leading: Icon(
              Icons.error,
              color: Colors.red,
            ),
            title: Text("Consumos Combustibles"),
            onTap: () =>
                Navigator.pushReplacementNamed(context, 'consumos'),
          ),
          ListTile(
            leading: Icon(
              Icons.punch_clock_outlined,
              color: Colors.green,
            ),
            title: Text("Control Pozos"),
            onTap: () => Navigator.pushReplacementNamed(context, 'controlPozos'),
          ),


          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.blueAccent,
            ),
            title: Text("Cerrar Sesión"),
            onTap: () {
              //Navigator.pushReplacementNamed(context, SettingsPage.routeName);
              _cerrarSesion(context);
            },
          ),
        ],
      ),
    );
  }
}
