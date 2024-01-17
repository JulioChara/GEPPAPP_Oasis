import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutteroasis/src/services/turnos_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutteroasis/src/models/despachos_model.dart';
import 'package:flutteroasis/src/widgets/menu_widget.dart';
import 'package:flutteroasis/src/services/despachos_services.dart';
import 'package:flutteroasis/src/services/detail_services.dart';

class DespachosPage extends StatefulWidget {


  @override
  _DespachoPageState createState() => _DespachoPageState();
}

class _DespachoPageState extends State<DespachosPage> {

  //String idUser = "";
  var despacho = new DespachoService();
  var datailServices = new DetailServices();
  String initDate = DateTime.now().toString().substring(0, 10);
  String endDate = DateTime.now().toString().substring(0, 10);
  String usr="";

  TextEditingController inputFieldDateController = new TextEditingController();
  DateTime selectedDate = DateTime.now();

  String idInformeSeleccionada = "";

  @override
  void initState(){
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




  existeTurno() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString("idUser")!;
    var turnoServices_ = new TurnoService();
    String existTurn = await turnoServices_.turnoConsultaExistenciaxUsuario(id);

    if(existTurn == "1"){ //cuando existe si podremos crear
      Navigator.pushNamed(context, 'despachoCreate');
    }else if(existTurn =="0"){
      showMessajeAW(DialogType.ERROR, "SIN TURNO","No hay turno aperturado, aperture uno antes de registrar despachos", 0);
    }


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Despachos"),
          backgroundColor: Colors.lightBlueAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              color: Colors.white,
              iconSize: 30.0,
              onPressed: () {

                existeTurno();


                // Navigator.pushNamed(context, 'despachoCreate');
              },
            )
          ],
        ),
        drawer: MenuWidget(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: _listDespacho(context, despacho),
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
                        color: Colors.lightBlueAccent,
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




  Widget _listDespacho(BuildContext context, DespachoService despachoService) {
    //print(usr);

    return FutureBuilder(

      future: despachoService.cargarDespacho(initDate, endDate),
      builder: (BuildContext context, AsyncSnapshot<List<DespacholistaModel>> snapshot) {
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
                final despachoModel = snapshot.data;
                return despachoModel!.length > 0
                    ? ListView.builder(
                  itemCount: despachoModel.length,
                  itemBuilder: (context, i) {
                    return (ListTile(
                      title: Text(
                        "${despachoModel[i].fecha}-${despachoModel[i].destino}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      subtitle: Text(
                         // " ${despachoModel[i].conductor==null ? '--' : 'aña'} |C. Ini. ${despachoModel[i].contInicial}   |C. Fin.  ${despachoModel[i].contFinal} | ${despachoModel[i].placa} |Cant. ${despachoModel[i].cantidad} "),
                          " PUNTO: ${despachoModel[i].puntoFkDesc} \n |${despachoModel[i].conductor} |C. Ini. ${despachoModel[i].contInicial}   |C. Fin.  ${despachoModel[i].contFinal} | ${despachoModel[i].placa} |Cant. ${despachoModel[i].cantidad} "),
                      leading: Icon(
                        Icons.content_paste,
                        color: Colors.lightBlueAccent,
                      ),
                      trailing: Container(
                        child: PopupMenuButton<String>(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.lightBlueAccent,
                            ),
                            itemBuilder: (BuildContext context) {
                              //String enviar = "Enviar SUNAT";

                              String anular = "Anular";

                              List<String> choices = []; //A_mig

                              if (despachoModel[i].Estado =="ANULADO") {
                              } else {
                                choices.add(anular);
                              }


                              return choices.map((String choice) {
                                return PopupMenuItem<String>(
                                  value: despachoModel[i].id! + ","+choice,
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
    idInformeSeleccionada  = choice;
    var arr = choice.split(',');

    //print(arr[0]);
    //print(arr[1]);

    if(arr[1] == "Anular"){

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
        desc: "Esta seguro de anular el Despacho?",
        btnCancelOnPress: () {},
        onDissmissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
        btnCancelText: "No",
        btnOkText: "Si",
        btnCancelIcon: Icons.cancel,
        btnOkIcon: Icons.check,
        btnOkOnPress: () {
          _anularInforme(arr[0]);
        },
      ).show().then((val) {
        //Acciones para finalizar el formulario
        // getData();
        setState(() {});
      });

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
//                   Text("Anular Despacho"),
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
//                     _anularInforme(arr[0]);
//                     Navigator.pop(context);
//                   },
//                   child: Text("Aceptar"),
//                 )
//               ],
//             );
//           });
    }

  }







  _anularInforme(String id) async{

    DespachoService service = new DespachoService();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String  idUser =  prefs.getString('idUser')!;

    String res = await service.estadoAnularDespacho(id,idUser);


    switch(res) {
      case "1": {
        showMessajeAW(DialogType.SUCCES, "CONFIRMACION", "Despacho Anulado Correctamente", 0);
      }
      break;

      case "turno": {
        showMessajeAW(DialogType.ERROR, "ERROR", "No se puede anular porque el turno al que pertenece ya esta CERRADO", 0);
      }
      break;
      default: {
        showMessajeAW(DialogType.ERROR, "ERROR", "Ocurrio un error al tratar de anular el despacho", 0);
      }
      break;
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
    //           content: Text("Despachos Anulado Correctamente"),
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


  }


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
        _listDespacho(context, despacho);
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
        _listDespacho(context, despacho);
      });
  }
}
