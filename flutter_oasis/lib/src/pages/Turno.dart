import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutteroasis/src/models/turnos_model.dart';
import 'package:flutteroasis/src/widgets/menu_widget.dart';
import 'package:flutteroasis/src/services/turnos_services.dart';
import 'package:flutteroasis/src/services/detail_services.dart';

class TurnosPage extends StatefulWidget {


  @override
  _TurnoPageState createState() => _TurnoPageState();
}

class _TurnoPageState extends State<TurnosPage> {

  //String idUser = "";
  var turno = new TurnoService();
  var datailServices = new DetailServices();
  String initDate = DateTime.now().toString().substring(0, 10);
  String endDate = DateTime.now().toString().substring(0, 10);
  String usr="";

  String existTurn = ""; // CUANDO SEA 0 no existe y podremos grabar


  TextEditingController inputFieldDateController = new TextEditingController();
  DateTime selectedDate = DateTime.now();

  String idTurnoSeleccionada = "";

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String iduser = prefs.getString("idUser").toString();
      existTurn = await turno.turnoConsultaExistenciaxUsuario(iduser);


      setState(() {
      });
    } catch (e) {
      print(e);
    }
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Turnos"),
          backgroundColor: Colors.redAccent,
          actions: <Widget>[
            // existTurn == "0" ? IconButton(
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              color: Colors.white,
              iconSize: 30.0,
              onPressed: () {
                //agregar condicionar de acceso


                Navigator.pushNamed(context, 'turnosCreate');
              },
            // ): Text("")
            ),
          ],
        ),
        drawer: MenuWidget(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: _listTurno(context, turno),
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




  Widget _listTurno(BuildContext context, TurnoService turnoService) {
    //print(usr);

    return FutureBuilder(

      future: turnoService.cargarTurno(initDate, endDate),
      builder: (BuildContext context, AsyncSnapshot<List<TurnolistaModel>> snapshot) {
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
                final turnoModel = snapshot.data;
                return turnoModel!.length > 0
                    ? ListView.builder(
                  itemCount: turnoModel.length,
                  itemBuilder: (context, i) {
                    return (ListTile(
                      title: Text(
                        "${turnoModel[i].id}-${turnoModel[i].tipoEstado}-${turnoModel[i].usuarioApertura}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: '${turnoModel[i].puntoFkDesc} \n ', style: const TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.systemGreen)),
                            TextSpan(text: "${turnoModel[i].fechaDesde}  |Fin. ${turnoModel[i].fechaHasta} | s/. ${turnoModel[i].turnoMonto} | Sis. s/.  ${turnoModel[i].turnoMontoSistema} |Usr. Cierre ${turnoModel[i].usuarioCierre} "),
                          ],
                        ),
                      ),
                      // subtitle: Text(
                      //     "${turnoModel[i].puntoFkDesc} \n ${turnoModel[i].fechaDesde}  |Fin. ${turnoModel[i].fechaHasta} | s/. ${turnoModel[i].turnoMonto} | Sis. s/.  ${turnoModel[i].turnoMontoSistema} |Usr. Cierre ${turnoModel[i].usuarioCierre} "),
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
                              String cerrar = "Cerrar Turno";
                              List<String> choices = [];
                              if (turnoModel[i].tipoEstado =="Tipo Turno Cerrado") {
                              } else {
                                choices.add(cerrar);
                              }
                              return choices.map((String choice) {
                                return PopupMenuItem<String>(
                                  value: turnoModel[i].id! + ","+choice,
                                  // child: Text(choice),
                                  child: ListTile(
                                    leading: const Icon(Icons.close),
                                    title:  Text(choice),
                                    iconColor: Colors.red,
                                    // tileColor: Colors.blueGrey.shade100,
                                  ),


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
    idTurnoSeleccionada  = choice;
    var arr = choice.split(',');
    if(arr[1] == "Cerrar Turno"){
      print("entro a finalizar");
      vincularId(arr[0]);
      Navigator.pushNamed(context, 'turnoCerrar');
    }
  }

  vincularId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("IdTurno", id);
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
        _listTurno(context, turno);
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
        _listTurno(context, turno);
      });
  }
}
