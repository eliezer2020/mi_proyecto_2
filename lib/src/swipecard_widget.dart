import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:my_proyecto_2/src/models/pelicula_model.dart';

class SwipeWidget extends StatelessWidget {
  final List<Pelicula> peliculasArreglo;

  SwipeWidget({@required this.peliculasArreglo});

  @override
  Widget build(BuildContext context) {
    //coje el tamaño del dispositivo y los agrega a los atributo widht y height
    Size _screensize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: GestureDetector(
              onTap: (){
                print(peliculasArreglo[index].originalTitle);
                Navigator.pushNamed(context, "detalles", arguments:peliculasArreglo[index]);
              },
                          child: FadeInImage(
                
                placeholder: AssetImage("assets/loading3.gif"),
              image: NetworkImage(peliculasArreglo[index].getImage()),
              fit: BoxFit.fill,),
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        layout: SwiperLayout.STACK,
        //el paginacion se desborda 

       pagination: SwiperPagination( 
         margin: new EdgeInsets.all(5.0),
         alignment: Alignment.topCenter,
       
        builder: SwiperPagination.fraction
        ),
        itemCount: peliculasArreglo.length,
        loop: false,
        //entra en juego a la hora de mandar a horizontal 
        viewportFraction: 0.8,
        scale: 0.9,

        itemWidth: _screensize.width * 0.70,
        itemHeight: _screensize.height * 0.50,
      ),
    );
    /*return  Swiper(
        
        
        //containerHeight:_screensize.height*0.4 ,
        //containerWidth: _screensize.width *0.4 ,
        itemBuilder: (BuildContext context, int index) {
          
          //envolver image en un cliprred para redondear

          return FadeInImage(
                
                
               placeholder: AssetImage("assets/loading3.gif"),
               //esto es una imagen e imagen.Network es un widget
               image:NetworkImage(peliculasArreglo[index].getImage()),
               fit: BoxFit.contain,
            );
          
        },


        itemCount: peliculasArreglo.length,
        itemWidth: _screensize.width *0.3,
        itemHeight: _screensize.width *0.3,
        layout: SwiperLayout.STACK,
        //numero de paginas
        pagination: new SwiperPagination(),
        //vlechitas de los costados
        //control: new SwiperControl(),
      );
    

    */
  }
}
