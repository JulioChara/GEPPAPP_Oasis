import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutteroasis/src/models/turnos_model.dart';
import 'package:flutteroasis/src/models/general_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutteroasis/src/services/turnos_services.dart';
import 'package:flutteroasis/src/services/detail_services.dart';
import 'package:snack/snack.dart';
import 'package:flutteroasis/src/widgets/dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class turnoCerrarPage extends StatefulWidget {
  @override
  _turnoCerrarPageState createState() => _turnoCerrarPageState();
}

class _turnoCerrarPageState extends State<turnoCerrarPage> {
  bool loading = true;
  bool loadingSend = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController MontoFinalEditingController = new TextEditingController();
  TextEditingController GalonajeCierreController = new TextEditingController();

  var objDetailServices = new DetailServices();
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  TurnoModel turnoModel = new TurnoModel();

  void getData() async {
    try {
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
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
              //Cuando se genera el pedido
              Navigator.pushReplacementNamed(
                context,
                'turno',
              );
            }
            break;
        }
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final bar = SnackBar(content: Text('Hello, world!'));

    return Scaffold(
        appBar: AppBar(
          title: Text("Cerrar Turno"),
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: loading
            ? Center(child: CircularProgressIndicator())
            : Stack(
          children: <Widget>[
            Container(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "DATOS GENERALES",
                        style: TextStyle(
                            fontSize: 18.0,
                            letterSpacing: 1.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: GalonajeCierreController,
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                          hintText: "Galonaje Cierre",
                          labelText: "Galonaje Cierre",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/gear.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        //keyboardType: TextInputType.emailAddress,
                        keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String text) {},
                        onChanged: (value) {
                          turnoModel.galCierre = value.toString();
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: MontoFinalEditingController    ,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Monto Cierre s/.",
                          labelText: "Monto Cierre s/.",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/price.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        //keyboardType: TextInputType.emailAddress,
                        keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String text) {},
                        onChanged: (value) {
                          turnoModel.turnoMonto = value.toString();
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      SizedBox(
                        height: 20.0,
                      ),
                      CupertinoButton(
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            "Cerrar Turno",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        color: Colors.deepOrangeAccent,
                        onPressed: () {
                          AwesomeDialog(
                            dismissOnTouchOutside: false,
                            context: context,
                            dialogType: DialogType.WARNING,
                            headerAnimationLoop: false,
                            animType: AnimType.TOPSLIDE,
                            showCloseIcon: true,
                            closeIcon: const Icon(Icons.close_fullscreen_outlined),
                            title: "Confirmacion",
                            descTextStyle: TextStyle(fontSize: 18),
                            desc: "Esta seguro de Cerrar el Turno?",
                            btnCancelOnPress: () {},
                            onDissmissCallback: (type) {
                              debugPrint('Dialog Dissmiss from callback $type');
                            },
                            btnCancelText: "No",
                            btnOkText: "Si",
                            btnCancelIcon: Icons.cancel,
                            btnOkIcon: Icons.check,
                            btnOkOnPress: () {
                              _sendData();
                            },
                          ).show().then((val) {
                            //Acciones para finalizar el formulario
                            getData();
                            setState(() {});
                          });



//                           showDialog(
//                               context: context,
//                               barrierDismissible: true,
//                               builder: (context) {
//                                 return AlertDialog(
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius:
//                                       BorderRadius.circular(20.0)),
//                                   title: Text("Atención"),
//                                   content: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: <Widget>[
//                                       Text(
//                                           "Esta seguro de Cerrar el turno"),
//                                       SizedBox(
//                                         height: 10.0,
//                                       ),
// //                                      Icon(Icons.warning, size: 45.0, color: Colors.yellow,)
//                                     ],
//                                   ),
//                                   actions: <Widget>[
//                                     FlatButton(
//                                       onPressed: () {
//                                         Navigator.pop(context);
//                                       },
//                                       child: Text("Cancelar"),
//                                     ),
//                                     FlatButton(
//                                       onPressed: () {
//                                         _sendData();
//                                         setState(() {
//                                         });
//                                         Navigator.pop(context);
//                                       },
//                                       child: Text("Enviar"),
//                                     )
//                                   ],
//                                 );
//                               });
                        },
                      ),
                      SizedBox(
                        height: 70.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (loadingSend)
              Positioned(
                child: Container(
                  color: Colors.black26,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ));
  }



  _sendData() async {
    TurnoService service = new TurnoService();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString("idUser")!;
    String idTurno = await prefs.getString("IdTurno")!;

    print(id);
    print(idTurno);
    turnoModel.usrCreacion = id;
    turnoModel.id = idTurno;
    setState(() {
      loadingSend = true;
    });

    String res = await service.cerrarTurno(turnoModel);

    if (res == "1") {
      showMessajeAW(DialogType.SUCCES, "Confirmacion",
          "Turno Cerrado Correctamente", 1);
    } else {
      showMessajeAW(DialogType.ERROR, "Error",
          "Ocurrio un error al Cerrar el turno", 0);
    }
    loadingSend = false;
    setState(() {});
  }



    // if (res == "1") {
    //
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context){
    //         return AlertDialog(
    //           shape: RoundedRectangleBorder(
    //               borderRadius:
    //               BorderRadius.circular(20.0)),
    //           title: Text("Atención"),
    //           content: Text("Se Cerro correctamente el turno"),
    //           actions: <Widget>[
    //             FlatButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //                 Navigator.pop(context);
    //                 Navigator.pushReplacementNamed(context, 'turno');
    //               },
    //               child: Text("Aceptar"),
    //             )
    //           ],
    //         );
    //       }
    //   );
    //
    //   setState(() {
    //     loadingSend = false;
    //   });
    //
    // }else{
    //
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context){
    //         return AlertDialog(
    //           shape: RoundedRectangleBorder(
    //               borderRadius:
    //               BorderRadius.circular(20.0)),
    //           title: Text("Atención"),
    //           content: Text("Hubo un problema, Verifique que coloco el monto para cerrar el turno"),
    //           actions: <Widget>[
    //             FlatButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //               },
    //               child: Text("Aceptar"),
    //             )
    //           ],
    //         );
    //       }
    //   );
    //   setState(() {
    //     loadingSend = false;
    //   });
    // }
 // }


}
