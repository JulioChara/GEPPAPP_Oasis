


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutteroasis/src/models/controlPozo_model.dart';
import 'package:flutteroasis/src/services/controlPozos_services.dart';
import 'package:flutteroasis/src/widgets/controlPozo/controlPozo_crear_widget.dart';
import 'package:flutteroasis/src/widgets/menu_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class controlPozosPage extends StatefulWidget {

  @override
  State<controlPozosPage> createState() => _controlPozosPageState();
}

class _controlPozosPageState extends State<controlPozosPage> {






  var _controlPozosServices = new ControlPozosService();

  String initDate = DateTime.now().toString().substring(0, 10);
  String endDate = DateTime.now().toString().substring(0, 10);
  // String idPedGlobLocal = "0";
  // String cantTotalGlob = "0";
  // String usr = "";
  int Accion = 0;

  TextEditingController inputFieldDateController = new TextEditingController();

  DateTime selectedDate = DateTime.now();

  String idInformeSeleccionada = "";

  List<ControlPozoModel> informeModelList2 = [];
  List<ControlPozoModel> informeModelList3 = [];

  // List<PedidosDeliveryDetalleModel> pendientes = [];

  bool isLoading = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<String> getIdRol() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("rolId")!;
  }
//19.10
  getData() {


    isLoading = true;
     _controlPozosServices.listadoRegistrosPozos(initDate, endDate).then((value) {
    //DBAdmin().getDBPedidosOffline("nada","nada")
   // DBAdmin().getDBPedidosOffline("nada","nada").then((value) {
      informeModelList2 = value;
      informeModelList3.addAll(informeModelList2);
      Accion = 0;
      setState(() {
        isLoading = false;
      });
    });
  }

  //
  // showDetalle(String estimado) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return PedidosDeliveryMostrarEstimaciones(
  //         estimacion: estimado,
  //       );
  //     },
  //   );
  // }


  // void filtrarPorPlaca(String query) {
  //   print("xxxx 1");
  //   List<OfflinePedidosDeliveryModel> tempSearchList = [];
  //
  //   if (query.isNotEmpty) {
  //     tempSearchList.addAll(informeModelList3);
  //     List<OfflinePedidosDeliveryModel> tempDataList = [];
  //     tempSearchList.forEach((element) {
  //       if (element.pedNumero!.toLowerCase().contains(query.toLowerCase())) {
  //         //
  //         tempDataList.add(element);
  //       }
  //     });
  //     informeModelList2.clear();
  //     informeModelList2.addAll(tempDataList);
  //     setState(() {});
  //   } else {
  //     print("xxxx 3");
  //     print(informeModelList3);
  //     informeModelList2.clear();
  //     informeModelList2.addAll(informeModelList3);
  //     setState(() {});
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registros de Contometros"),
        backgroundColor: Colors.green,
        actions: <Widget>[
          // existTurn == "0" ? IconButton(
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            color: Colors.white,
            iconSize: 30.0,
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return ControlPozoCreateWidget();
                },
              ).then((val) {
                //Navigator.pop(context);
                getData();
              });
            },
          ),
        ],
      ),
      drawer: MenuWidget(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => setState(() {
      //     getData();
      //   }),
      //   tooltip: 'Actualizar',
      //   child: const Icon(Icons.refresh),
      // ),
      body: !isLoading
          ? Column(
        children: <Widget>[
          // TextField(
          //   onChanged: (String value) {
          //     filtrarPorPlaca(value);
          //   },
          //   decoration: const InputDecoration(
          //     labelText: 'Filtrar por Numero Pedido',
          //     suffixIcon: Icon(
          //       Icons.search,
          //     ),
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: informeModelList2.length,
              itemBuilder: (BuildContext context, int i) {
                return ListTile(
                  // tileColor: miColor,
                  onTap: () {
                    // DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
                    // String formattedDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
                    // print(formattedDate);
                    print(informeModelList2[i].cpEstado!);
                    // showEstadoDetalle(
                    //     informeModelList2[i].id!,
                    //     informeModelList2[i].tipoNota!,
                    //     informeModelList2[i].documento!,
                    //     informeModelList2[i].placaDesc!,
                    //     informeModelList2[i].fecha!,
                    //     informeModelList2[i].responsableDesc!,
                    //     informeModelList2[i].conductorDesc!,
                    //     informeModelList2[i].total!);
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${informeModelList2[i].pozoFkDesk}",
                        // "${informeModelList2[i].pedSerie}" +
                        //     "-" +
                        //     "${informeModelList2[i].pedNumero}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      Text(
                        "${double.parse(informeModelList2[i].cpContometroActual!).toStringAsFixed(2)}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                  // subtitle: Text(informeModelList2[i].fecha!),
                  subtitle: Column(
                    children: [
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${(informeModelList2[i].cpFechaRegistro)}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                        Text(
                          "${(double.parse(informeModelList2[i].cpConsumoDiferencial!) ).toStringAsFixed(2)}",
                          //   "RESTANTES?",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ],
                    ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                          Text(

                          //  "(informeModelList2[i].cpUsuarioCreacionDesc)}",
                            "${(informeModelList2[i].cpUsuarioCreacionDesc)}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),

                   //     ],
                   //   ),

                  ],
                  ),
                  // leading: Icon(
                  //   Icons.content_paste,
                  //   color: Colors.redAccent,
                  //
                  // ),

                  leading: IconButton(
                    icon: Icon(Icons.paste, color: Colors.red),
                    onPressed: () {
                      // showDetalle(informeModelList2[i].descripcion != null ? informeModelList2[i].descripcion!: "-");
                      // print(informeModelList2[i].idPedido);
                    },
                  ),
                  // leading: informeModelList2[i].estadoPedidoFk == "11501"
                  //     ? IconButton(
                  //   icon: Icon(Icons.print, color: Colors.blue),
                  //   onPressed: () {
                  //     globalizar(informeModelList2[i].idPedido!);
                  //     Navigator.pushNamed(context, 'impPedFull');
                  //   },
                  // )
                  //     : IconButton(
                  //   icon: Icon(Icons.paste, color: Colors.red),
                  //   onPressed: () {
                  //     print(informeModelList2[i].idPedido);
                  //   },
                  // ),

                  //    trailing:
                  trailing: informeModelList2[i].puedeAnular! ==
                      "False"
                      ? Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 50.0,
                  )
                  :IconButton(
                    icon: Icon(Icons.remove_circle),
                    color: Colors.red,
                    iconSize: 30.0,
                    onPressed: () {
                      anularRegistro(informeModelList2[i].cpId!);
                    },
                  ),
                );
              },
            ),
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
                        BoxShadow(
                            color: Colors.grey.shade400, blurRadius: 3)
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
                          style: TextStyle(
                              color: Colors.white, fontSize: 18),
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
                        BoxShadow(
                            color: Colors.grey.shade400, blurRadius: 3)
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
                          style: TextStyle(
                              color: Colors.white, fontSize: 18),
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
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }


  anularRegistro(String id) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: DialogType.WARNING,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      closeIcon: const Icon(Icons.close_fullscreen_outlined),
      title: 'Advertencia',
      descTextStyle: TextStyle(fontSize: 18),
      desc: 'Desea anular el registro?',
      btnCancelOnPress: () {},
      onDissmissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
      btnOkOnPress: () {
        anularRegistroProcess(id);
      },
    ).show();
  }

  anularRegistroProcess(String id) async {
  //  PedidosDeliveryServices _ service = new PedidosDeliveryServices();
   ControlPozoModel anul_model = new ControlPozoModel();
    anul_model.cpId = id;
    String res = await _controlPozosServices.anularControlPozos(anul_model);

    if (res == "1") {
      showMensajeriaAW(
          DialogType.SUCCES, "Confirmacion", "Registro Anulado Correctamente");
    } else {
      showMensajeriaAW(
          DialogType.ERROR, "Error", "Ocurrio un error al anular el registro");
    }
  }







  //
  // void choiceAction(String choice) {
  //   idInformeSeleccionada = choice;
  //   var arr = choice.split(',');
  //
  //   if (arr[1] == "Alertas")
  //   {
  //     print("Somos Alertas");
  //     vincularId2(arr[0], arr[1]);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => AlertasPage(),
  //       ),
  //     );
  //
  //   }
  // }
  //
  //

  showMensajeriaAW(DialogType tipo, String titulo, String desc) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: tipo,
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
      btnOkOnPress: () {},
    ).show().then((value) {
      getData();
      setState(() {});
    });
  }

  globalizar(String id) async {
    //idPedGlobLocal = id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("idPed", id);
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
                'home',
              );
            }
            break;
        }
      },
    ).show();
  }


  // void choiceAction(int choice,String cantTotal, BuildContext context) {
  //   if (choice == 1) {
  //     print("a");
  //     // Navigator.pushNamed(context, 'pedidosDetalleOffline');
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => OfflinePedidosDetallePage(pendienteTotal: cantTotal),
  //       ),
  //     );
  //   }
  // }

  Future<Null> _selectDateInit(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: DateTime.parse(initDate),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null)
      setState(() {
        initDate = picked.toString().substring(0, 10);
        //_listInforme(context, informe);
        getData();
      });
  }

  Future<Null> _selectDateEnd(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: DateTime.parse(endDate),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null)
      setState(() {
        endDate = picked.toString().substring(0, 10);
        //_listInforme(context, informe);
        getData();
      });
  }













}
