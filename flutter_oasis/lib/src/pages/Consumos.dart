import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutteroasis/src/models/consumos_model.dart';
import 'package:flutteroasis/src/widgets/menu_widget.dart';
import 'package:flutteroasis/src/services/consumos_services.dart';
import 'package:flutteroasis/src/services/detail_services.dart';

import '../services/turnos_services.dart';

class ConsumosPage extends StatefulWidget {
  @override
  _ConsumoPageState createState() => _ConsumoPageState();
}

class _ConsumoPageState extends State<ConsumosPage> {
  //String idUser = "";
  var consumo = new ConsumoService();
  var datailServices = new DetailServices();
  String initDate = DateTime.now().toString().substring(0, 10);
  String endDate = DateTime.now().toString().substring(0, 10);
  String usr = "";

  TextEditingController inputFieldDateController = new TextEditingController();
  DateTime selectedDate = DateTime.now();

  String idConsumoSeleccionada = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              // Navigator.pushReplacementNamed(
              //   context,
              //   'turno',
              // );
            }
            break;
        }
      },
    ).show();
  }

  existeTurno() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString("idUser")!;
    var turnoServices_ = new TurnoService();
    String existTurn = await turnoServices_.turnoConsultaExistenciaxUsuario(id);

    if (existTurn == "1") {
      //cuando existe si podremos crear
      Navigator.pushNamed(context, 'consumosCreate');
    } else if (existTurn == "0") {
      showMessajeAW(
          DialogType.ERROR,
          "SIN TURNO",
          "No hay turno aperturado, aperture uno antes de registrar consumos",
          0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Consumos"),
          backgroundColor: Colors.redAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              color: Colors.white,
              iconSize: 30.0,
              onPressed: () {
                existeTurno();
                // Navigator.pushNamed(context, 'consumosCreate');
              },
            )
          ],
        ),
        drawer: MenuWidget(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: _listConsumo(context, consumo),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0XFF51E2A7),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade400, blurRadius: 3)
                        ]),
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.date_range,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 7.0,
                          ),
                          Text(
                            initDate,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                      onPressed: () {
                        _selectDateInit(context);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade400, blurRadius: 3)
                        ]),
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.date_range,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 7.0,
                          ),
                          Text(
                            endDate,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                      onPressed: () {
                        _selectDateEnd(context);
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  Widget _listConsumo(BuildContext context, ConsumoService consumoService) {
    //print(usr);

    return FutureBuilder(
      future: consumoService.cargarConsumo(initDate, endDate),
      builder: (BuildContext context,
          AsyncSnapshot<List<ConsumolistaModel>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            {
              return new Center(
                child: CircularProgressIndicator(),
              );
            }
          case ConnectionState.active:
            {
              break;
            }
          case ConnectionState.none:
            {
              break;
            }
          case ConnectionState.done:
            {
              if (snapshot.hasData) {
                final consumoModel = snapshot.data;
                return consumoModel!.length > 0
                    ? ListView.builder(
                        itemCount: consumoModel.length,
                        itemBuilder: (context, i) {
                          return (ListTile(
                            title: Text(
                              "${consumoModel[i].fecha}-${consumoModel[i].responsable}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            subtitle: Text(
                                "${consumoModel[i].combustible}  |Dest. ${consumoModel[i].destino} |Cant. ${consumoModel[i].cantidad} | s/.  ${consumoModel[i].monto}"),
                            leading: Icon(
                              Icons.content_paste,
                              color: Colors.redAccent,
                            ),
                            trailing: Container(
                              child: PopupMenuButton<String>(
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: Colors.redAccent,
                                  ),
                                  itemBuilder: (BuildContext context) {
                                    String anular = "Anular";
                                    // List<String> choices = new List();
                                    List<String> choices = [];
                                    if (consumoModel[i].Estado == "ANULADO") {
                                    } else {
                                      choices.add(anular);
                                    }
                                    return choices.map((String choice) {
                                      return PopupMenuItem<String>(
                                        value:
                                            consumoModel[i].id! + "," + choice,
                                        child: Text(choice),
                                      );
                                    }).toList();
                                  },
                                  onSelected: choiceAction),
                            ),
                          ));
                        },
                      )
                    : Center(
                        child: Text(
                          "No hay información disponible.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.black26),
                        ),
                      );
              }
            }
        }

        return new Center(child: CircularProgressIndicator());
      },
    );
  }

  void choiceAction(String choice) {
    idConsumoSeleccionada = choice;
    var arr = choice.split(',');

    //print(arr[0]);
    //print(arr[1]);
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: DialogType.QUESTION,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      closeIcon: const Icon(Icons.close_fullscreen_outlined),
      title: "CONSULTA",
      descTextStyle: TextStyle(fontSize: 18),
      desc: "Esta seguro de anular el Consumo?",
      btnCancelOnPress: () {},
      onDissmissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
      btnCancelText: "No",
      btnOkText: "Si",
      btnCancelIcon: Icons.cancel,
      btnOkIcon: Icons.check,
      btnOkOnPress: () {
        _anularConsumo(arr[0]);
      },
    ).show().then((val) {
      //Acciones para finalizar el formulario
      // getData();
      setState(() {});
    });
  }

//     if(arr[1] == "Anular"){
//       showDialog(
//           context: context,
//           barrierDismissible: true,
//           builder: (context) {
//             return AlertDialog(
//               shape: RoundedRectangleBorder(
//                   borderRadius:
//                   BorderRadius.circular(20.0)),
//               title: Text("Atención"),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Text("Anular Consumo"),
//                   SizedBox(
//                     height: 10.0,
//                   ),
// //                                      Icon(Icons.warning, size: 45.0, color: Colors.yellow,)
//                 ],
//               ),
//               actions: <Widget>[
//                 FlatButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text("Cancelar"),
//                 ),
//                 FlatButton(
//                   onPressed: () {
//                     _anularConsumo(arr[0]);
//                     Navigator.pop(context);
//                   },
//                   child: Text("Aceptar"),
//                 )
//               ],
//             );
//           });
//     }

//  }

  _anularConsumo(String id) async {
    ConsumoService service = new ConsumoService();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idUser = prefs.getString('idUser')!; //A_mig

    String res = await service.estadoAnularConsumo(id, idUser);

    switch (res) {
      case "1":
        {
          showMessajeAW(DialogType.SUCCES, "CONFIRMACION",
              "Consumo Anulado Correctamente", 0);
        }
        break;
      case "turno":
        {
          showMessajeAW(
              DialogType.ERROR,
              "ERROR",
              "No se puede anular porque el turno al que pertenece ya esta CERRADO",
              0);
        }
        break;
      default:
        {
          showMessajeAW(DialogType.ERROR, "ERROR",
              "Ocurrio un error al tratar de anular el consumo", 0);
        }
        break;
    }
  }

  // if(res == "1"){
  //
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context){
  //         return AlertDialog(
  //           shape: RoundedRectangleBorder(
  //               borderRadius:
  //               BorderRadius.circular(20.0)),
  //           title: Text("Atención"),
  //           content: Text("Consumo Anulado Correctamente"),
  //           actions: <Widget>[
  //             FlatButton(
  //               onPressed: () {
  //                 setState(() {
  //
  //                 });
  //                 Navigator.pop(context);
  //               },
  //               child: Text("Aceptar"),
  //             )
  //           ],
  //         );
  //       }
  //   );
  //
  // }else{
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context){
  //         return AlertDialog(
  //           shape: RoundedRectangleBorder(
  //               borderRadius:
  //               BorderRadius.circular(20.0)),
  //           title: Text("Atención"),
  //           content: Text("Hubo un problema, inténtelo nuevamente."),
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
  // }
  //}

  Future<Null> _selectDateInit(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: new DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null)
      setState(() {
        initDate = picked.toString().substring(0, 10);
        _listConsumo(context, consumo);
      });
  }

  Future<Null> _selectDateEnd(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: new DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null)
      setState(() {
        endDate = picked.toString().substring(0, 10);
        _listConsumo(context, consumo);
      });
  }
}
