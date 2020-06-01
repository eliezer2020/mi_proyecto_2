import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_proyecto_2/src/models/actores_model.dart';
import 'package:my_proyecto_2/src/providers/peliculas_provides.dart';

import 'models/pelicula_model.dart';

class PeliculaDetalles extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) {
    //push llama al constructor
    //la clase permanece vacia hasta push por eso

    final Pelicula _item = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        //childrens
        slivers: <Widget>[
          crearAppbar(_item),
          SliverList(
              delegate: SliverChildListDelegate([
            //solo se encoje cuando hay desborde
            _crearsubAppbar(context, _item),
            _crearDescripcion(context, _item),
            Divider(),
            crearActores(context, _item),
          ])),
        ],
      ),
    );
  }

  Widget crearAppbar(Pelicula item) {
    return SliverAppBar(
      elevation: 2.0,

      //permanece pinned en scaffold
      pinned: true,

      floating: false,
      centerTitle: true,
      //stretch: false,
      expandedHeight: 150.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          item.title,
          //black 26 le da una opacidad media transparente
          style: TextStyle(
            backgroundColor: Colors.black26,
          ),
        ),
        centerTitle: true,
        //ya
        background: Hero(
          tag: item.id,
          child: Image.network(item.getImage(), fit: BoxFit.cover)),
      ),
    );
  }

  Widget _crearsubAppbar(BuildContext context, Pelicula item) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image(
              image: NetworkImage(item.getPoster()),

              //heig scala mi imagen para evitar desborde
              //aplicar mediaquery con porciones
              height: 100.0,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),

          //abarca todo el espacio
          Flexible(
              fit: FlexFit.tight,
              child: Column(
                //queden alineados los textos
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.originalTitle,
                    style: Theme.of(context).textTheme.headline5,
                    overflow: TextOverflow.visible,
                  ),
                  Text(item.title,
                      style: Theme.of(context).textTheme.headline6,
                      overflow: TextOverflow.ellipsis),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.yellowAccent,
                      ),
                      Text(item.voteAverage.toString()),
                    ],
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Widget _crearDescripcion(BuildContext context, Pelicula item) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        item.overview,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget crearActores(BuildContext context, Pelicula item) {
    final peliculasProvider = new PeliculaProvider();

    return FutureBuilder(
        //initialData: [],
        future: peliculasProvider.getActores(item.id.toString()),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            print("has data*******");
            print(snapshot.data);
            return _crearActoresview(snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _crearActoresview(List<Actor> actores) {
    print("creando actores view");
    print(actores);
    return Container(
      height: 200.0,
      child: PageView.builder(
        itemCount: actores.length,
        pageSnapping: true,
        controller: PageController(viewportFraction: 0.4, initialPage: 1),
        itemBuilder: (context, i) {
          return Column(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: FadeInImage(
                    placeholder: AssetImage("assets/loading3.gif"),
                    image: NetworkImage(actores[i].getFoto()),
                    height: 100.0,
                    fit: BoxFit.cover,
                  )),
              Text(
                actores[i].name,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 8.0,
              )
            ],
          );
        },
      ),
    );
  }
}
