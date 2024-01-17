import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutteroasis/src/models/puntosDespacho_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutteroasis/src/models/turnos_model.dart';
import 'package:flutteroasis/src/models/general_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutteroasis/src/services/turnos_services.dart';
import 'package:flutteroasis/src/services/detail_services.dart';
import 'package:snack/snack.dart';
import 'package:flutteroasis/src/widgets/dialog.dart';

class turnoCrearPage extends StatefulWidget {
  @override
  _turnoCrearPageState createState() => _turnoCrearPageState();
}

class _turnoCrearPageState extends State<turnoCrearPage> {
  bool loading = true;
  bool loadingSend = false;
  String existTurn = ""; // CUANDO SEA 0 no existe y podremos grabar
  PuntosDespachoModel? _selectedPuntos;

  List<DropdownMenuItem<PuntosDespachoModel>>? _puntoDespachosDropdownMenuItems;
  static List<PuntosDespachoModel> puntoDespachos= [];
  GlobalKey<AutoCompleteTextFieldState<TipoTipo>> keyTipo = new GlobalKey();


  final scaffoldKey = GlobalKey<ScaffoldState>();
  var turnoServices_ = new TurnoService();
  TextEditingController MontoFinalEditingController = new TextEditingController();
  TextEditingController GalonajeAperturaController = new TextEditingController();

  var turnos = new DetailServices();
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  TurnoModel turnoModel = new TurnoModel();

  void getData() async {
    try {

      puntoDespachos = await turnoServices_.cargarPuntosDespacho();
      _puntoDespachosDropdownMenuItems = buildDropDownMenuTipos(puntoDespachos);

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


  List<DropdownMenuItem<PuntosDespachoModel>> buildDropDownMenuTipos(List tipos) {
    List<DropdownMenuItem<PuntosDespachoModel>> items = [];
    for (PuntosDespachoModel tipo in tipos) {
      items.add(DropdownMenuItem( value: tipo, child: Text(tipo.pdDescripcion!),));
    }
    return items;
  }

  onChangeDropdownTipos(PuntosDespachoModel? selectedSituacion) {

    turnoModel.puntoDespachoFk = selectedSituacion!.pdId;
    print(selectedSituacion.pdId!);
    setState(() {
      _selectedPuntos = selectedSituacion;
    });
  }


  @override
  Widget build(BuildContext context) {
    final bar = SnackBar(content: Text('Hello, world!'));

    return Scaffold(
        appBar: AppBar(
          title: Text("Abrir Turno"),
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
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Punto Despacho",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                              "assets/icons/tick.svg", color: Colors.black54,),
                          ),
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        isExpanded: true,
                        value: _selectedPuntos,
                        items: _puntoDespachosDropdownMenuItems,
                        onChanged: onChangeDropdownTipos,
                        elevation: 2,
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                        isDense: true,
                        iconSize: 40.0,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: GalonajeAperturaController,
                        keyboardType: TextInputType.numberWithOptions(),
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: "Galonaje Inicial",
                          labelText: "Galonaje Inicial",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/lock.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        //keyboardType: TextInputType.emailAddress,
                        keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String text) {},
                        onChanged: (value) {
                          turnoModel.galApertura = value.toString();
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: MontoFinalEditingController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Contraseña",
                          labelText: "Contraseña",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/lock.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        //keyboardType: TextInputType.emailAddress,
                        keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String text) {},
                        onChanged: (value) {
                          turnoModel.mensaje = value.toString();
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
                            "Abrir Turno 🥵",
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
                       ///  print(turnoModel.puntoDespachoFk);

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
                            desc: "Esta seguro de Aperturar el Turno?",
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
                           // getData();
                            setState(() {});
                          });

   //                       showMessajeAW(DialogType.QUESTION, "Consulta","Esta seguro de Aperturar el turno?", 2);
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
//                                           "Esta seguro de Abrir Turno"),
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
//                                       child: Text("Abrir"),
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
                'turno',
              );
            }
            break;
        }
      },
    ).show();
  }




  _sendData() async {
    TurnoService service = new TurnoService();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString("idUser")!;
    existTurn = await turnoServices_.turnoConsultaExistenciaxUsuario(id);

    if (turnoModel.puntoDespachoFk==null){
      showMessajeAW(DialogType.ERROR, "Error","Debe seleccionar el punto de despacho", 0);
      return;
    }
    print("Variable: " + existTurn);
    if (existTurn=="1"){
      showMessajeAW(DialogType.ERROR, "Error","Ya existe un turno aperturado para su usuario, cierrelo antes de abrir Otro", 0);
      return;
    }

    print(id);
    turnoModel.usrCreacion = id;
    setState(() {
      loadingSend = true;
    });



    String res = await service.registrarTurno(turnoModel);


    if (res == "1") {

      // showDialog(
      //     context: context,
      //     builder: (BuildContext context){
      //       return AlertDialog(
      //         shape: RoundedRectangleBorder(
      //             borderRadius:
      //             BorderRadius.circular(20.0)),
      //         title: Text("Atención"),
      //         content: Text("Se Abrio correctamente el turno"),
      //         actions: <Widget>[
      //           FlatButton(
      //             onPressed: () {
      //               Navigator.pop(context);
      //               Navigator.pop(context);
      //               Navigator.pushReplacementNamed(context, 'turno');
      //             },
      //             child: Text("Aceptar"),
      //           )
      //         ],
      //       );
      //     }
      // );

      showMessajeAW(DialogType.SUCCES, "Confirmacion","Turno Aperturado Correctamente", 1);

      setState(() {
        loadingSend = false;
      });

    }else{

      showMessajeAW(DialogType.ERROR, "Error","Ocurrio un error al Aperturar el turno", 0);

  //     showDialog(
  //         context: context,
  //         builder: (BuildContext context){
  //           return AlertDialog(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius:
  //                 BorderRadius.circular(20.0)),
  //             title: Text("Atención"),
  //             content: Text("Hubo un problema, Verifique la contraseña correcta"),
  //             actions: <Widget>[
  //               FlatButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text("Aceptar"),
  //               )
  //             ],
  //           );
  //         }
  //     );
      setState(() {
        loadingSend = false;
      });
    }
  }


}
