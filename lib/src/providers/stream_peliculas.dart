
import 'dart:async';

import 'package:my_proyecto_2/src/models/pelicula_model.dart';

class StreamPeliculas {

//corriente de datos broadcast
final _popularesStream = new StreamController<List<Pelicula>>.broadcast();

//cerrar streams obligatorio
void disposeStreams (){
_popularesStream?.close();

}

//getters y setter -> sink agregar , stream fluit

Function(List<Pelicula>)get popularesSink => _popularesStream.sink.add; 

Stream<List<Pelicula>> get popularesStream => _popularesStream.stream;




}




