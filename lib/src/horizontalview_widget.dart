import "package:flutter/material.dart";
import 'package:my_proyecto_2/src/models/pelicula_model.dart';

class HorizontalView extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientesPopulares;
  final controlPage = new PageController(
    //mostrar 1 item al inicio
    initialPage: 1,
    //fraccion que cada item ocupa 1 es el maximo
    viewportFraction: 0.4,
  );

  HorizontalView({@required this.peliculas, @required this.siguientesPopulares()});

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
//escucha del control
    controlPage.addListener(() {
      if (controlPage.position.pixels >= controlPage.position.maxScrollExtent-80){
      print("ultima posicion del horizontal VIew");
      siguientesPopulares();

      } 
    });

    return Container(
      //si no lo pongo retorna error HAZ SIZE
      height: _screenSize.height * 0.20,

      //el builder significa renderizar bajo demanda 
      child: PageView.builder(
//page snaping encuadra en automatico el item seleccionado
        pageSnapping: false,
        //renderizado dinamico
        itemCount: peliculas.length,
        controller: controlPage,
        itemBuilder: (context, int i) => _tarjetas(_screenSize, context, item: peliculas[i]),

        
      ),
    );
  }

  Widget _tarjetas(Size _screenSize, BuildContext context, {@required Pelicula item}) {
    //itera cada elemento de una lista y los transforma
   final tarjetasWidget = Container(
            margin: EdgeInsets.only(right: 10.0),
            child: Column(
              children: <Widget>[
                //giro en inicio y en fin y hace la transicion 
                Hero(
                  tag: item.id,
                                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: FadeInImage(
                      placeholder: AssetImage("assets/loading3.gif"),

                      //duplico el heig del container en el widget image
                      //cancela arregle el problema del overflow del texto restandole
                      //_screensize al hal height factor para que me dejara
                      //espacio para el text
                      height: _screenSize.height * 0.15,
                      image: NetworkImage(item.getImage()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // el texto estaba envuelto en expanded pero se corrigio
                //utilizando el scrren size heig factor distribuyendo
                //cuando modifique por un tema texto mas grande el expanded
                //soluciono el desborde
                //expanded evita el desborde
                Expanded(
                  //if null o zero desborde
                  //if 1 force space between 1 item
                  flex: 1,
                  child: Text(
                    item.title,
                    //indica ... en desborde de texto
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ],
            ),
          );

          return GestureDetector(
            child: tarjetasWidget,
            onTap: (){
              print("nombre = ${item.title}");
              //estoy mandando todo el item por el push que es mi pelicula 
              Navigator.pushNamed(context, "detalles", arguments: item   );
            },
          );
       
  }
}
