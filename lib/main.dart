import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_proyecto_2/src/detalle_pelicula_page.dart';
import 'package:my_proyecto_2/src/home_page.dart';

//metodo de acceso
void main() => runApp(MyApp());

//mi app 
class MyApp  extends StatelessWidget {

@override
Widget build (context){
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "mi proyecto_2",
    // "/"
    initialRoute: "home",


      routes: <String, WidgetBuilder>{
        "home": (context) => HomePage(),
        "detalles" :(context) => PeliculaDetalles(),
        
        
      },

  //support EN ESP

  localizationsDelegates: [
   // ... app-specific localization delegate[s] here
   GlobalMaterialLocalizations.delegate,
   GlobalWidgetsLocalizations.delegate,
   GlobalCupertinoLocalizations.delegate,
 ],
 supportedLocales: [
    const Locale('en'), // English
    const Locale('es'), // spanish
 ],

  );
}

}

