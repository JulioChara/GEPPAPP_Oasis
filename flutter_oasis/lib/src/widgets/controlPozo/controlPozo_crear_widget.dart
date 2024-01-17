

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutteroasis/src/models/controlPozo_model.dart';
import 'package:flutteroasis/src/models/general_model.dart';
import 'package:flutteroasis/src/services/controlPozos_services.dart';

class ControlPozoCreateWidget extends StatefulWidget {

  // String? id = "";
  // ControlPozoCreateWidget({this.id});

  @override
  State<ControlPozoCreateWidget> createState() => _ControlPozoCreateWidgetState();
}

class _ControlPozoCreateWidgetState extends State<ControlPozoCreateWidget> {





  var _controlPozosServices = new ControlPozosService();
  int idTipoPozo = 0;



  final formKey = GlobalKey<FormState>();
  var loading = true;

  TextEditingController contometroController = new TextEditingController();
  TextEditingController descripcionController = new TextEditingController();

 // GeneralServices _generalServices = GeneralServices();
 // PedidosDeliveryServices _pedidosServices = PedidosDeliveryServices();

  TiposModel? _modelTipos;
  ControlPozoModel? _modelPozo;

  List<DropdownMenuItem<TiposModel>> _tiposDropdownMenuItems = [];

  static List<TiposModel> tipos = [];
  List<TiposModel> tipos2 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  //
  getData() async {


   // print("IdDetalle: " + widget.id!);
    tipos = await _controlPozosServices.getDestinosPozos();
    tipos2 = tipos; //
    //  print(productos2);
    _tiposDropdownMenuItems = buildDropDownMenuTipos(tipos2);


  //  contometroController.text = widget.pendiente!;
    loading = false;
    setState(() {});

  }



  showMensajeriaAW(DialogType tipo, String titulo, String desc, int accion){
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: tipo,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      closeIcon: const Icon(Icons.close_fullscreen_outlined),
      title: titulo,
      descTextStyle: TextStyle(fontSize: 18,),
      desc:
      desc,
      //   btnCancelOnPress: () {},
      onDissmissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
      btnOkOnPress: () {
        switch (accion){
          case 0:{

          }break;
          case 1:{
            Navigator.pop(context);
          }break;
        }
      },
    ).show();

  }


  validar() {
    try {
      String val = "";
      String cab = "Complete los siguientes Campos: \n ";
      String contenido = "";

      if(idTipoPozo ==0){
        contenido = contenido + "\n > Seleccione un pozo destino";
      }
      if(contometroController.text ==""){
        contenido = contenido + "\n > Ingrese un valor de contometro";
      }
      if(double.parse(contometroController.text) <=0){
        contenido = contenido + "\n > contometro debe ser mayor a 0";
      }

      if(contenido.length >0){
        val= cab + contenido;
      }
      return val;
    }   catch (e) {
      showMensajeriaAW(DialogType.ERROR,"Error",e.toString(),0);

    }
  }

  void registrar() async {
    setState(() {
      loading = true;
    });
    _modelPozo = new ControlPozoModel();
    String val = "";
    val = validar();
    print(val);
    try {
      if (val.length == 0) {
      //  _modelPozo!.idDet = widget.idDet;
        _modelPozo!.pozoFk = idTipoPozo.toString();
        _modelPozo!.cpObservaciones = descripcionController.text;
        _modelPozo!.cpContometroActual = contometroController.text;

        String res = await _controlPozosServices.grabarControlPozos(_modelPozo!);
        if (res == "1") {
          showMensajeriaAW(DialogType.SUCCES,"Confirmacion","Registro generado Correctamente",1);
        }else{
          showMensajeriaAW(DialogType.ERROR,"Error","Error al procesar el registro",0);
        }
        //desea grabar?
      }else
      {
        showMensajeriaAW(DialogType.ERROR,"Validacion Error",val,0);
        //mensaje de que debe ingresar una cantidad Valida
      }

      setState(() {
        loading = false;
      });

    } catch (e) {
      loading = false;
      print("Error Try Catch");
      showMensajeriaAW(DialogType.ERROR,"Error",e.toString(),0);
      print(e);

    }
    // setState(() {
    //   loading = false;
    // });

  }




  @override
  Widget build(BuildContext context) {
    return !loading
        ?  AlertDialog(
      content: Form(
        key: formKey,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("REGISTRAR CONTOMETRO",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),


                SizedBox(height: 15.0,),



                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: "Seleccione un Pozo",
                    prefixIcon: Container(
                      width: 20,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        "assets/icons/travel.svg",
                        color: Colors.black54,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  isExpanded: true,
                  value: _modelTipos,
                  items: _tiposDropdownMenuItems,
                  onChanged: onChangeDropdownTipos,
                  elevation: 2,
                  style: TextStyle(
                      color: Colors.black54, fontSize: 16),
                  isDense: true,
                  iconSize: 40.0,
                ),

                SizedBox(height: 15.0,),
                TextFormField(
                  controller: contometroController,
                  style: TextStyle(
                      color: Colors.black, fontSize: 16.0),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Contometro Actual",
                    labelText: "Contometro Actual",
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
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  keyboardAppearance: Brightness.light,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (String text) {},
                  readOnly: false,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                SizedBox(height: 15.0,),
                TextFormField(
                  controller: descripcionController,
                  style: TextStyle(
                      color: Colors.black, fontSize: 16.0),
                  textAlign: TextAlign.center,
                 // autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Observaciones",
                    labelText: "Observaciones",
                    prefixIcon: Container(
                      width: 20,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      child: SvgPicture.asset(
                          "assets/icons/edit.svg"),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  maxLines: 2,
                  keyboardType: TextInputType.emailAddress,
                  keyboardAppearance: Brightness.light,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (String text) {},
                  readOnly: false,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),



              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancelar",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            registrar();
          },
          child: Text(
            "Grabar",
          ),
        ),
      ],
    ): Center(child: CircularProgressIndicator());
  }





  onChangeDropdownTipos(TiposModel? selectTipos) {
    setState(() {
      _modelTipos = selectTipos;
      // print(_modelTipos!.toJson());
      idTipoPozo = int.parse(_modelTipos!.tipoId!);
    });
  }




  List<DropdownMenuItem<TiposModel>>
  buildDropDownMenuTipos(List tipos) {
    List<DropdownMenuItem<TiposModel>> items = [];
    // print("Build: ");
    // print(tipos);
    for (TiposModel tipo in tipos) {
      // print(tipo.productoFkDesc!);
      // print(tipo.precioFinal!);
      items.add(DropdownMenuItem(
          value: tipo,
          child:
          //Text(tipo.productoFkDesc!),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${(tipo.tipoDescripcion!)}",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              // Text(
              //   "${double.parse(tipo.precioFinal!).toStringAsFixed(2)}",
              //   overflow: TextOverflow.ellipsis,
              //   maxLines: 1,
              //   style:
              //   TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              // ),
            ],
          )));
    }
    return items;
  }











}
