import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/services.dart';
import 'package:flutteroasis/src/models/general_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutteroasis/src/models/consumos_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutteroasis/src/services/consumos_services.dart';
import 'package:flutteroasis/src/services/detail_services.dart';
import 'package:snack/snack.dart';


class ConsumoCreatePage extends StatefulWidget {
  @override
  _ConsumoCreatePageState createState() => _ConsumoCreatePageState();
}

class _ConsumoCreatePageState extends State<ConsumoCreatePage> {
  bool loading = true;
  bool loadingSend = false;

  static List<Responsable> responsables = [];
  GlobalKey<AutoCompleteTextFieldState<Responsable>> keyResponsable =  new GlobalKey();

  static List<TipoProducto> tipoProducto = [];
  GlobalKey<AutoCompleteTextFieldState<TipoProducto>> keyTipo = new GlobalKey();

  AutoCompleteTextField? searchResponsable;

  AutoCompleteTextField? searchTipoProducto;

  TextEditingController DestinoEditingController = new TextEditingController();
  TextEditingController TicketEditingController = new TextEditingController();
  TextEditingController CantidadEditingController = new TextEditingController();
  TextEditingController MontoEditingController = new TextEditingController();

  var objDetailServices = new DetailServices();

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  ConsumoModel consumoModel = new ConsumoModel();

  TipoProducto ? _selectedProducto;
  List<DropdownMenuItem<TipoProducto>>? _tipoProductoDropdownMenuItems;

  void getData() async {
    try {


      tipoProducto = await objDetailServices.cargarTipoProducto();
      _tipoProductoDropdownMenuItems = buildDropDownMenuTipos(tipoProducto);

      responsables = await objDetailServices.cargarResponsable();

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

  List<DropdownMenuItem<TipoProducto>> buildDropDownMenuTipos(List tipos) {
    List<DropdownMenuItem<TipoProducto>> items = [];
    for (TipoProducto tipo in tipos) {
      items.add(DropdownMenuItem( value: tipo, child: Text(tipo.descripcion!),));
    }
    return items;
  }

  onChangeDropdownTipos(TipoProducto? selectedProducto) {
    consumoModel.combustible = selectedProducto!.id; //A_mig
    print(selectedProducto.id);  //A_mig
    setState(() {
      _selectedProducto = selectedProducto;
    });
  }



  @override
  Widget build(BuildContext context) {
    final bar = SnackBar(content: Text('Hello, world!'));

    return Scaffold(
        appBar: AppBar(
          title: Text("Consumo Combustible"),
          backgroundColor: Colors.redAccent,
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
                          labelText: "Tipo Producto",
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
                        value: _selectedProducto,
                        items: _tipoProductoDropdownMenuItems,
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
                        controller: DestinoEditingController ,
                        decoration: InputDecoration(
                          hintText: "Destino",
                          labelText: "Destino",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/travel.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          consumoModel.destino = value;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      searchResponsable = fieldResponsable(),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: TicketEditingController  ,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Ticket",
                          labelText: "Ticket",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/tick.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        //keyboardType: TextInputType.emailAddress,
                        keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String text) {},
                        onChanged: (value) {
                          consumoModel.ticket = value.toString();
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: CantidadEditingController   ,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Cantidad Gal",
                          labelText: "Cantidad Gal",
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
                        onChanged: (value) {
                          consumoModel.cantidad = value.toString();
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: MontoEditingController    ,
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
                          consumoModel.monto = value.toString();
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
                            "REGISTRAR CONSUMO",
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
                        color: Colors.redAccent,
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
                            desc: "Esta seguro de grabar el Consumo?",
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
//                                           "Esta seguro de grabar el Informe"),
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
                'consumos',
              );
            }
            break;
        }
      },
    ).show();
  }



  _sendData() async {
    ConsumoService service = new ConsumoService();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString("idUser")!;
    print(id);
    consumoModel.usrCreacion = id;
    setState(() {
      loadingSend = true;
    });


    String res = await service.registrarConsumo(consumoModel);


    if (res == "1") {
      showMessajeAW(
          DialogType.SUCCES, "Confirmacion", "Consumo grabado Correctamente",
          1);
      setState(() {
        loadingSend = false;
      });
    } else {
      showMessajeAW(
          DialogType.ERROR, "Error", "Ocurrio un error al grabar el consumo",
          0);
      setState(() {
        loadingSend = false;
      });
    }
  }

    //
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
    //           content: Text("Consumo Combustible Grabado Correctamente"),
    //           actions: <Widget>[
    //             FlatButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //                 Navigator.pop(context);
    //                 Navigator.pushReplacementNamed(context, 'consumos');
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


  //}


  AutoCompleteTextField<Responsable> fieldResponsable() {
    return AutoCompleteTextField<Responsable>(
      key: keyResponsable,
      clearOnSubmit: false,
      suggestions: responsables,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),
      decoration: InputDecoration(
        hintText: "Responsable",
        labelText: "Responsable",
        hintStyle: TextStyle(color: Colors.black54),
        prefixIcon: Container(
          padding: EdgeInsets.all(10),
          width: 20.0,
          height: 20.0,
          child: SvgPicture.asset("assets/icons/user.svg"),
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
          searchResponsable!.textField!.controller!.text = item.RazonSocial!;  //A_mig rarisimo
          consumoModel.responsable = item.Id;
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowResponsable(item);
      },
    );
  }


  AutoCompleteTextField<TipoProducto> fieldTipo() {
    return AutoCompleteTextField<TipoProducto>(
      key: keyTipo,
      clearOnSubmit: false,
      suggestions: tipoProducto,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),
      decoration: InputDecoration(
        hintText: "Tipo Producto",
        labelText: "Tipo Producto",
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
        return item.descripcion!.toLowerCase().contains(query.toLowerCase()); //A_mig
      },
      itemSorter: (a, b) {
        return a.descripcion!.compareTo(b.descripcion.toString()); //A_mig
      },
      itemSubmitted: (item) {
        setState(() {
          searchTipoProducto!.textField!.controller!.text = item.descripcion.toString();
          consumoModel.combustible = item.id;
          print(item.id);
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowTipo(item);
      },
    );
  }




  Widget rowTipo(TipoProducto tipoProducto) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              tipoProducto.descripcion!,
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
              tipoProducto.categoria!,
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


  Widget rowResponsable(Responsable responsable) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              responsable.RazonSocial!,
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
              responsable.Documento!,
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



}
