import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/services.dart';
import 'package:flutteroasis/src/models/general_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutteroasis/src/models/despachos_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutteroasis/src/services/despachos_services.dart';
import 'package:flutteroasis/src/services/detail_services.dart';
import 'package:snack/snack.dart';


class DespachoCreatePage extends StatefulWidget {
  @override
  _DespachoCreatePageState createState() => _DespachoCreatePageState();
}

class _DespachoCreatePageState extends State<DespachoCreatePage> {
  bool loading = true;
  bool loadingSend = false;
  String selDate = DateTime.now().toString().substring(0, 10);


  static List<Conductor> conductores = [];
  GlobalKey<AutoCompleteTextFieldState<Conductor>> keyConductor =  new GlobalKey();

  static List<Cliente> clientes = [];
  GlobalKey<AutoCompleteTextFieldState<Cliente>> keyCliente = new GlobalKey();
  static List<Cliente> clientesFinal = [];
  GlobalKey<AutoCompleteTextFieldState<Cliente>> keyclientesFinal = new GlobalKey();

  static List<Placa> placas = [];
  GlobalKey<AutoCompleteTextFieldState<Placa>> keyPlaca = new GlobalKey();

  static List<TipoTipo> tipoSituacion= [];
  GlobalKey<AutoCompleteTextFieldState<TipoTipo>> keyTipo = new GlobalKey();

  static ConsultaSunatModel consultaRuc = new ConsultaSunatModel(); //new
  static ConsultaReniecModel consultaDni = new ConsultaReniecModel(); //new

  GlobalKey<AutoCompleteTextFieldState<Cliente>> keyEntidad = new GlobalKey(); //new


  AutoCompleteTextField? searchConductor;
  // AutoCompleteTextField? searchCliente;
  AutoCompleteTextField? searchPlaca;
  AutoCompleteTextField? searchTipoSituacion;
  AutoCompleteTextField? searchEntidad;   //new
  AutoCompleteTextField? searchClienteFinal;   //new

  TextEditingController ContometroInicialEditingController = new TextEditingController();
  TextEditingController ContometroFinalEditingController = new TextEditingController();
  TextEditingController TotalEditingController = new TextEditingController();
  TextEditingController CantidadEditingController = new TextEditingController();
  TextEditingController MontoEditingController = new TextEditingController();
  TextEditingController ObservacionController = new TextEditingController();
  TextEditingController TelefonoEditingController = new TextEditingController();


  TextEditingController _rucController = new TextEditingController();
  TextEditingController _clientesFinalController = new TextEditingController();

  var objDetailServices = new DetailServices();
  var _despachoServices = new DespachoService();
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  DespachoModel despachoModel = new DespachoModel();

  Placa ? _selectedPlaca;
  TipoTipo? _selectedSituacion;

  String idEntidad = "";
  String idClienteFinal = "";
  String docConsOnline = "";
  String razConsOnline = "";

  List<DropdownMenuItem<Placa>>? _placaDropdownMenuItems;
  List<DropdownMenuItem<TipoTipo>>? _tipoSituacionDropdownMenuItems;


  void getData() async {
    try {

      placas = await objDetailServices.cargarPlaca();
      _placaDropdownMenuItems = buildDropDownMenuItems(placas);

      tipoSituacion = await objDetailServices.cargarTipoTipo();
      _tipoSituacionDropdownMenuItems = buildDropDownMenuTipos(tipoSituacion);

      ContometroInicialEditingController.text= await _despachoServices.obtenerContometroDePuntoDespacho();


      clientes = await objDetailServices.cargarCliente();
      clientesFinal = clientes;
      conductores = await objDetailServices.cargarConductor();

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
  List<DropdownMenuItem<Placa>> buildDropDownMenuItems(List placas) {
    List<DropdownMenuItem<Placa>> items = [];
    for (Placa placa in placas) {
      items.add(DropdownMenuItem( value: placa, child: Text(placa.Descripcion!),));
    }
    return items;
  }

  List<DropdownMenuItem<TipoTipo>> buildDropDownMenuTipos(List tipos) {
    List<DropdownMenuItem<TipoTipo>> items = [];
    for (TipoTipo tipo in tipos) {
      items.add(DropdownMenuItem( value: tipo, child: Text(tipo.descripcion!),));
    }
    return items;
  }


  //
  // onChangeDropdownItem(Placa? selectedPlaca) {
  //   despachoModel.placa = selectedPlaca!.Descripcion;
  //   setState(() {
  //     _selectedPlaca = selectedPlaca;
  //     print(_selectedPlaca!.Descripcion);
  //   });
  // }

  onChangeDropdownTipos(TipoTipo? selectedSituacion) {
    despachoModel.tipoDespacho = selectedSituacion!.id;
    print(selectedSituacion.id);
    setState(() {
      _selectedSituacion = selectedSituacion;
    });
  }



  @override
  Widget build(BuildContext context) {
    final bar = SnackBar(content: Text('Hello, world!'));

    return Scaffold(
        appBar: AppBar(
          title: Text("Despachos Agua"),
          backgroundColor: Colors.lightBlueAccent,
        ),
            floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
            tooltip: 'Increment',
            onPressed: (){
              print("Que riko aprietas kata");
              print(idEntidad);
              print(idClienteFinal);


            },
          child: const Icon(Icons.add, color: Colors.white, size: 28),
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

                      Column(
                        children: [
                          searchPlaca = fieldPlaca(),
                        ] ,
                      ),

                      // DropdownButtonFormField(
                      //   decoration: InputDecoration(
                      //     labelText: "Placa",
                      //     prefixIcon: Container(
                      //       width: 20,
                      //       height: 40,
                      //       padding: EdgeInsets.all(10),
                      //       child: SvgPicture.asset(
                      //         "assets/icons/car-parking.svg", color: Colors.black54,),
                      //     ),
                      //     contentPadding: EdgeInsets.all(10.0),
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10)),
                      //   ),
                      //   isExpanded: true,
                      //   value: _selectedPlaca,
                      //   items: _placaDropdownMenuItems,
                      //   onChanged: onChangeDropdownItem,
                      //   elevation: 2,
                      //   style: TextStyle(color: Colors.black54, fontSize: 16),
                      //   isDense: true,
                      //   iconSize: 40.0,
                      // ),

                      SizedBox(
                        height: 20.0,
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Tipo Situacion",
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
                        value: _selectedSituacion,
                        items: _tipoSituacionDropdownMenuItems,
                        onChanged: onChangeDropdownTipos,
                        elevation: 2,
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                        isDense: true,
                        iconSize: 40.0,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      // searchCliente = fieldCliente(),
                      // SizedBox(
                      //   height: 20.0,
                      // ),
                      // aquaNuevas

                      Column(
                        children: [
                          searchEntidad = fieldEntidad(),
                        ] ,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Column(
                        children: [
                          searchClienteFinal = fieldClientesFinal(),
                        ] ,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      TextFormField(
                        controller: TelefonoEditingController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Telefono",
                          labelText: "Telefono",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/send.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        //keyboardType: TextInputType.emailAddress,
                        keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String text) {},
                        onChanged: (value) {
                          despachoModel.telefono = value.toString();
                        },
                      ),


                      // AquaNuevasEnd

                      SizedBox(height: 15.0,),
                      Text("Fecha Despacho",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 3)
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
                                selDate,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )
                            ],
                          ),
                          onPressed: () {
                            _selectSelDate(context);
                          },
                        ),
                      ),



                      SizedBox(height: 20.0,),
                      searchConductor = fieldConductor(),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: ContometroInicialEditingController ,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Cont. Inicial",
                          labelText: "Cont. Inicial",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/kilometro.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        //keyboardType: TextInputType.emailAddress,
                        keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String text) {},
                        readOnly: true,
                        onChanged: (value) {
                          despachoModel.contInicial = value.toString();
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: ContometroFinalEditingController  ,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Cont. Final",
                          labelText: "Cont. Final",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/kilometro.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        //keyboardType: TextInputType.emailAddress,
                        keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String text) {},
                        onChanged: (value) {
                          try{

                            despachoModel.contFinal = value.toString();

                            double ini= double.parse(ContometroInicialEditingController.text);
                            double end = double.parse(ContometroFinalEditingController.text);
                            CantidadEditingController.text = (end-ini).toString();

                          }catch(e){
                              print(e.toString());
                            //  ContometroFinalEditingController.text = "0";
                              CantidadEditingController.text = "0";
                          }


                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: CantidadEditingController   ,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Cantidad M3",
                          labelText: "Cantidad M3",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/adjust.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        //keyboardType: TextInputType.emailAddress,
                        keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String text) {},
                        //readOnly: true,
                        onChanged: (value) {
                          despachoModel.cantidad = value.toString();
                        },
                      ),

                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: MontoEditingController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Monto s/.",
                          labelText: "Monto s/.",
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
                          despachoModel.monto = value.toString();
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: ObservacionController    ,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Observacion",
                          labelText: "Observacion",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/adjust.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        //keyboardType: TextInputType.emailAddress,
                        keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String text) {},
                        maxLines: 3,
                        onChanged: (value) {
                          despachoModel.observacion = value.toString();
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      Divider(
                        height: 20.0,
                      ),

                      CupertinoButton(
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            "REGISTRAR DESPACHO",
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
                        color: Colors.lightBlueAccent,
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
                            desc: "Esta seguro de grabar el Despacho?",
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
//                                           "Esta seguro de grabar el Despacho"),
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

  _sendData() async {
    DespachoService service = new DespachoService();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString("idUser")!;
    print(id);


    despachoModel.contInicial = ContometroInicialEditingController.text;
    despachoModel.contFinal = ContometroFinalEditingController.text;
    despachoModel.cantidad = CantidadEditingController.text;
    despachoModel.fecha = selDate; //aquaNEW

    despachoModel.usrCreacion = id;
    despachoModel.placa = searchPlaca!.textField!.controller!.text;

    if(idEntidad == "0"){
      despachoModel.destino = "0";
      despachoModel.docOnline = docConsOnline;
      despachoModel.razOnline = razConsOnline;
    }else{
      despachoModel.docOnline = "";
      despachoModel.razOnline = "";
      docConsOnline = "";
      razConsOnline = "";
    }
    if(idClienteFinal == "0"){
      despachoModel.clienteFinal = "0";
    }else{

    }


    setState(() {
      loadingSend = true;
    });



    String res = await service.registrarDespacho(despachoModel);



    if (res == "1") {
      showMessajeAW(DialogType.SUCCES, "Confirmacion","Despacho grabado Correctamente", 1);
      setState(() {
        loadingSend = false;
      });
    }else{
      showMessajeAW(DialogType.ERROR, "Error","Ocurrio un error al grabar el despacho", 0);
      setState(() {
        loadingSend = false;
      });
    }
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
    //           content: Text("Despacho Grabado Correctamente"),
    //           actions: <Widget>[
    //             FlatButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //                 Navigator.pop(context);
    //                 Navigator.pushReplacementNamed(context, 'home');
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
    //           content: Text("Hubo un problema, Verifique que todos los datos esten llenos o que el turno este abierto."),
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





  AutoCompleteTextField<Conductor> fieldConductor() {
    return AutoCompleteTextField<Conductor>(
      key: keyConductor,
      clearOnSubmit: false,
      suggestions: conductores,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),
      decoration: InputDecoration(
        hintText: "Conductor",
        labelText: "Conductor",
        hintStyle: TextStyle(color: Colors.black54),
        prefixIcon: Container(
          padding: EdgeInsets.all(10),
          width: 20.0,
          height: 20.0,
          child: SvgPicture.asset("assets/icons/truck.svg"),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      itemFilter: (item, query) {
        return item.RazonSocial!.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.RazonSocial!.compareTo(b.RazonSocial.toString());
      },
      itemSubmitted: (item) {
        setState(() {
          searchConductor!.textField!.controller!.text = item.RazonSocial.toString();
          despachoModel.conductor = item.Id;
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowConductor(item);
      },
    );
  }
  //
  // AutoCompleteTextField<Cliente> fieldCliente() {
  //
  //   return AutoCompleteTextField<Cliente>(
  //     key: keyCliente,
  //     clearOnSubmit: false,
  //     suggestions: clientes,
  //     style: TextStyle(color: Colors.black54, fontSize: 16.0),
  //
  //     decoration: InputDecoration(
  //       hintText: "Cliente",
  //       labelText: "Cliente",
  //       hintStyle: TextStyle(color: Colors.black54),
  //
  //       prefixIcon: Container(
  //         padding: EdgeInsets.all(10),
  //         width: 17.0,
  //         height: 17.0,
  //         child: SvgPicture.asset(
  //           "assets/icons/frame.svg",
  //           color: Colors.black87.withOpacity(0.6),
  //         ),
  //       ),
  //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  //     ),
  //     itemFilter: (item, query) {
  //       return item.razonSocial!.toLowerCase().contains(query.toLowerCase());
  //     },
  //     itemSorter: (a, b) {
  //       return a.razonSocial!.compareTo(b.razonSocial.toString());
  //     },
  //     itemSubmitted: (item) {
  //       setState(() {
  //         searchCliente!.textField!.controller!.text = item.razonSocial.toString();
  //         despachoModel.destino = item.id;
  //         idEntidad = "";  //para contrarestar new
  //         docConsOnline = "";
  //         razConsOnline = "";
  //
  //
  //         //guiaModel.dirPartida = item.direccion;
  //         //direccionOrigenEditingController.text = item.direccion;
  //       });
  //     },
  //     itemBuilder: (context, item) {
  //       // ui for the autocompelete row
  //       return rowCliente(item);
  //     },
  //   );
  // }


  AutoCompleteTextField<Placa> fieldPlaca() {
      return AutoCompleteTextField<Placa>(
        key: keyPlaca,
        clearOnSubmit: false,
        suggestions: placas,
        style: TextStyle(color: Colors.black54, fontSize: 16.0),

        decoration: InputDecoration(
          hintText: "Placas",
          labelText: "Placas",
          hintStyle: TextStyle(color: Colors.black54),

          prefixIcon: Container(
            padding: EdgeInsets.all(10),
            width: 17.0,
            height: 17.0,
            child: SvgPicture.asset(
              "assets/icons/car-parking.svg",
              color: Colors.black87.withOpacity(0.6),
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        itemFilter: (item, query) {
          return item.Descripcion!.toLowerCase().contains(query.toLowerCase());
        },
        itemSorter: (a, b) {
          return a.Descripcion!.compareTo(b.Descripcion.toString());
        },
        itemSubmitted: (item) {
          setState(() {
            searchPlaca!.textField!.controller!.text = item.Descripcion.toString();
            despachoModel.placa = item.Descripcion.toString();
            print("Placa actual" + item.Descripcion.toString());

          });
        },
        itemBuilder: (context, item) {
          // ui for the autocompelete row
          return rowPlaca(item);
        },
      );

    // return AutoCompleteTextField<Placa>(
    //   key: keyPlaca,
    //   clearOnSubmit: false,
    //   suggestions: placas,
    //   style: TextStyle(color: Colors.black54, fontSize: 16.0),
    //   decoration: InputDecoration(
    //     hintText: "Placa",
    //     labelText: "Placa",
    //     hintStyle: TextStyle(color: Colors.black54),
    //     prefixIcon: Container(
    //       padding: EdgeInsets.all(10),
    //       width: 17.0,
    //       height: 17.0,
    //       child: SvgPicture.asset(
    //         "assets/icons/car-parking.svg",
    //         color: Colors.black87.withOpacity(0.6),
    //       ),
    //     ),
    //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    //   ),
    //   itemFilter: (item, query) {
    //     return item.Descripcion!.toLowerCase().contains(query.toLowerCase());
    //   },
    //   itemSorter: (a, b) {
    //     return a.Descripcion!.compareTo(b.Descripcion.toString());
    //   },
    //   itemSubmitted: (item) {
    //     setState(() {
    //       searchPlaca!.textField!.controller!.text = item.Descripcion.toString();
    //       despachoModel.placa = item.Descripcion;
    //     });
    //   },
    //   itemBuilder: (context, item) {
    //     // ui for the autocompelete row
    //     return rowPlaca(item);
    //   },
    // );
  }


  AutoCompleteTextField<TipoTipo> fieldTipo() {
    return AutoCompleteTextField<TipoTipo>(
      key: keyTipo,
      clearOnSubmit: false,
      suggestions: tipoSituacion,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),
      decoration: InputDecoration(
        hintText: "Tipo Situacion",
        labelText: "Tipo Situacion",
        hintStyle: TextStyle(color: Colors.black54),
        prefixIcon: Container(
          padding: EdgeInsets.all(10),
          width: 17.0,
          height: 17.0,
          child: SvgPicture.asset(
            "assets/icons/tick.svg",
            color: Colors.black87.withOpacity(0.6),
          ),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      itemFilter: (item, query) {
        return item.descripcion!.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.descripcion!.compareTo(b.descripcion.toString());
      },
      itemSubmitted: (item) {
        setState(() {
          searchTipoSituacion!.textField!.controller!.text = item.descripcion.toString();
          despachoModel.tipoDespacho = item.id;
          print(item.id);
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowTipo(item);
      },
    );
  }



  Widget rowPlaca(Placa placa) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              placa.Descripcion!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Flexible(
            child: Text(
              placa.Categoria!,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget rowTipo(TipoTipo tipoSituacion) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              tipoSituacion.descripcion!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Flexible(
            child: Text(
              tipoSituacion.categoria!,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }


  Widget rowConductor(Conductor conductor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              conductor.RazonSocial!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Flexible(
            child: Text(
              conductor.Documento!,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
  // Widget rowCliente(Cliente cliente) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: <Widget>[
  //         Flexible(
  //           child: Text(
  //             cliente.razonSocial!,
  //             overflow: TextOverflow.ellipsis,
  //             style: TextStyle(
  //               fontSize: 16.0,
  //               color: Colors.black54,
  //             ),
  //           ),
  //         ),
  //         SizedBox(
  //           width: 10.0,
  //         ),
  //         Flexible(
  //           child: Text(
  //             cliente.documento!,
  //             style: TextStyle(
  //               fontSize: 16.0,
  //               color: Colors.black54,
  //             ),
  //             overflow: TextOverflow.ellipsis,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }






  //NUEVAS PARA BUSCADOR //
  void consultaSunat(String ruc) async {
    consultaRuc = await _despachoServices.getConsultaSunat(ruc);
    _rucController.text = consultaRuc.razonSocial.toString();  //newwww
    idEntidad = "0";
    docConsOnline = consultaRuc.ruc.toString();
    razConsOnline = consultaRuc.razonSocial.toString();
    setState(() {
      loading = false;
    });
  }

  void consultaReniec(String ruc) async {
    consultaDni = await _despachoServices.getConsultaReniec(ruc);
    _rucController.text = consultaDni.razonSocial.toString();  //newwww
    idEntidad = "0";
    docConsOnline = consultaDni.dni.toString();
    razConsOnline = consultaDni.razonSocial.toString();
    setState(() {
      loading = false;
    });
  }


  AutoCompleteTextField<Cliente> fieldEntidad() {
    return AutoCompleteTextField<Cliente>(
      controller: _rucController,
      key: keyEntidad,
      clearOnSubmit: false,
      suggestions: clientes,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),
      decoration: InputDecoration(
        hintText: "Cliente",
        labelText: "Cliente",
        hintStyle: TextStyle(color: Colors.black54),
        prefixIcon: Container(
          padding: EdgeInsets.all(10),
          width: 17.0,
          height: 17.0,
          child: SvgPicture.asset(
            "assets/icons/frame.svg",
            color: Colors.black87.withOpacity(0.6),
          ),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon:
        CircleAvatar(
          radius: 25,
          backgroundColor: Color(0xFF000000),
          child: IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              if (_rucController.text.length ==8){
                consultaReniec(_rucController.text);
              }else {
                consultaSunat(_rucController.text);
              }

            },
          ),
        ),
      ),
      itemFilter: (item, query) {
        return item.razonSocial!.toLowerCase().contains(query.toLowerCase());
        //return item.entiNroDocumento.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        //return a.entiRazonSocial.compareTo(b.entiRazonSocial);
        return a.razonSocial!.compareTo(b.razonSocial.toString());
      },
      itemSubmitted: (item) {
        setState(() {
         // searchEntidad.textField.controller.text = item.entiNroDocumento;
          //_razonController.text = item.entiRazonSocial; old
          _rucController.text = item.razonSocial.toString();
          idEntidad = item.id.toString();
          despachoModel.destino = item.id;
        //  idEntidad = "";  //para contrarestar new
          docConsOnline = "";
          razConsOnline = "";
          //pene
          print("EXITO");
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowEntidad(item);
      },
    );

  }

  Widget rowEntidad(Cliente empleado) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              empleado.razonSocial.toString(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                // fontSize: 16.0,
                fontSize: 14.0,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }



  AutoCompleteTextField<Cliente> fieldClientesFinal() {
    return AutoCompleteTextField<Cliente>(
      controller: _clientesFinalController,
      key: keyclientesFinal,
      clearOnSubmit: false,
      suggestions: clientesFinal,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),
      decoration: InputDecoration(
        hintText: "Cliente Final",
        labelText: "Cliente Final",
        hintStyle: TextStyle(color: Colors.black54),
        prefixIcon: Container(
          padding: EdgeInsets.all(10),
          width: 17.0,
          height: 17.0,
          child: SvgPicture.asset(
            "assets/icons/frame.svg",
            color: Colors.black87.withOpacity(0.6),
          ),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
     //   suffixIcon:
        // CircleAvatar(
        //   radius: 25,
        //   backgroundColor: Color(0xFF000000),
        //   child: IconButton(
        //     icon: Icon(
        //       Icons.search,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {
        //       if (_clientesFinalController.text.length ==8){
        //         consultaReniec(_clientesFinalController.text);
        //       }else {
        //         consultaSunat(_clientesFinalController.text);
        //       }
        //
        //     },
        //   ),
        // ),
      ),
      itemFilter: (item, query) {
        return item.razonSocial!.toLowerCase().contains(query.toLowerCase());
        //return item.entiNroDocumento.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        //return a.entiRazonSocial.compareTo(b.entiRazonSocial);
        return a.razonSocial!.compareTo(b.razonSocial.toString());
      },
      itemSubmitted: (item) {
        setState(() {
          // searchEntidad.textField.controller.text = item.entiNroDocumento;
          //_razonController.text = item.entiRazonSocial; old
          _clientesFinalController.text = item.razonSocial.toString();
          idClienteFinal = item.id.toString();
          despachoModel.clienteFinal = item.id;
          //  idEntidad = "";  //para contrarestar new
          docConsOnline = "";
          razConsOnline = "";
          //pene
          print("EXITO");
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowClienteFinal(item);
      },
    );

  }

  Widget rowClienteFinal(Cliente empleado) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              empleado.razonSocial.toString(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                // fontSize: 16.0,
                fontSize: 14.0,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

//END BUSCADOR


  Future<Null> _selectSelDate(BuildContext context) async {
    final DateTime ? picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: new DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null)
      setState(() {
        selDate = picked.toString().substring(0, 10);
        print(selDate);
        //  _listViaje(context, viaje);
      });
  }






}
