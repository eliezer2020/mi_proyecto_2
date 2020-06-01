import "package:flutter/material.dart";
import 'package:my_proyecto_2/src/horizontalview_widget.dart';
import 'package:my_proyecto_2/src/providers/peliculas_provides.dart';
import 'package:my_proyecto_2/src/swipecard_widget.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final peliculasProvider = new PeliculaProvider();
  

  @override
  Widget build(context) {
    // disparamos el metodo para hacer el sink y cargar los datos inciales
    peliculasProvider.getPopulares();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("peliculas en cines"),
        backgroundColor: Colors.indigoAccent,
        centerTitle: false,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _swipeCard(),
          _footer(context),
        ],
      ),
    );
  }

  Widget _swipeCard() {
    return FutureBuilder(
      future: peliculasProvider.enCines(),
      //si utilizo inicial data el loader ya no funciona
      //initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          return SwipeWidget(peliculasArreglo: snapshot.data);
        } else {
          return Center(
              //cuantas veces el tamaño del widget
              heightFactor: 5.0,
              child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    
    return Container(
      padding: EdgeInsets.all(5.0),

      //infinity horizontal scroll
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //texto con estilo general del tema
          Container(
              padding: EdgeInsets.only(left: 10.0),
              child:
                  Text("footer", style: Theme.of(context).textTheme.subtitle2)),

          //future builder se ejecuta una sola vez mientras stream cada vez que hay una entrada

/*
          FutureBuilder(
              future: peliculasProvider.getPopulares(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.hasData) {
                  return HorizontalView(peliculas: snapshot.data);
                } else {
                  return CircularProgressIndicator();
                }
              }),              */

          StreamBuilder(
              stream: peliculasProvider.streamObject.popularesStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.hasData) {
                  //sin los parentesis porque no se esta ejecutando solo se asigna la variable
                  return HorizontalView(peliculas: snapshot.data, siguientesPopulares: peliculasProvider.getPopulares, );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ],
      ),
    );
  }
}
