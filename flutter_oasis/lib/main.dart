import 'package:flutter/material.dart';
import 'package:flutteroasis/src/pages/Turno.dart';
import 'package:flutteroasis/src/pages/controlPozos_page.dart';
import 'package:flutteroasis/src/pages/turnoCerrar_page.dart';
import 'package:flutteroasis/src/pages/turnoCreate_page.dart';
import 'package:flutteroasis/src/pages/login_page.dart';
import 'package:flutteroasis/src/pages/Despachos.dart';
import 'package:flutteroasis/src/pages/Consumos.dart';
import 'package:flutteroasis/src/pages/consumosCreate_page.dart';
import 'package:flutteroasis/src/pages/despachosCreate_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutteroasis/utils/SP_Global.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SPGlobal prefs = SPGlobal();
  await prefs.initShared();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MaterialApp(
        title: 'FUNDO JOYA ROMAN',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        // localizationsDelegates: [
        //   // ... app-specific localization delegate[s] here
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        supportedLocales: [
          const Locale('en'), // English
          const Locale('es'), // Hebrew
          const Locale.fromSubtags(languageCode: 'zh'), // Chinese *See Advanced Locales below*
          // ... other locales the app supports
        ],
        routes: {
          'home' :  (BuildContext context) => DespachosPage(),
          'consumos' :  (BuildContext context) => ConsumosPage(),
          'consumosCreate' : (BuildContext context) => ConsumoCreatePage(),
          'despachoCreate' :  (BuildContext context) => DespachoCreatePage(),
          'login':  (BuildContext context) => LoginPage(),
          'turno':  (BuildContext context) => TurnosPage(),
          'turnoCerrar':  (BuildContext context) => turnoCerrarPage(),
          'turnosCreate': (BuildContext context) => turnoCrearPage(),
          'controlPozos': (BuildContext context) => controlPozosPage(),

        },
      ),
      onTap: (){
        final FocusScopeNode focus =  FocusScope.of(context);
        if(!focus.hasPrimaryFocus){
          focus.unfocus();
        }
      },
    );
  }
}
