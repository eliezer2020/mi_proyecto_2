import 'dart:async';

import 'package:my_proyecto_2/src/models/actores_model.dart';
import 'package:my_proyecto_2/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_proyecto_2/src/providers/stream_peliculas.dart';

class PeliculaProvider {
  String _apiKey = "993524ae7527c7c903cd1b6d067860ca";
  String _language = "es-ES";
  String _url = "api.themoviedb.org";
  int _popularesPage = 0;
  List<Pelicula> _popularesList = new List();
  final streamObject = new StreamPeliculas();

  Future<List<Pelicula>> enCines() async {
//equivalente:
//https://api.themoviedb.org/3/movie/now_playing?api_key=993524ae7527c7c903cd1b6d067860ca&language=en-US&page=1

    final urlNow = Uri.https(_url, "3/movie/now_playing", {
      "api_key": _apiKey,
      "language": _language,
    });

    final respNow = await http.get(urlNow);
// las respuesta http esta en el body

//convierte la respuestas string en un json valido
    final decodeData = json.decode(respNow.body);

    final arraypeliculas = new Peliculas.fromJsonmap(decodeData["results"]);
    //print(arraypeliculas.items[0].title);
    //print(arraypeliculas.items[0].overview);

    return arraypeliculas.items;
  }

  bool cargando = false;

  Future<List<Pelicula>> getPopulares() async {
    if (cargando) return [];

    cargando = true;
    print("cargando populares...");

    _popularesPage++;

    final urlPopular = Uri.https(_url, "3/movie/popular", {
      "api_key": _apiKey,
      "language": _language,
      "page": _popularesPage.toString(),
    });

    final respPopular = await http.get(urlPopular);
    final decodeData = json.decode(respPopular.body);

    final arraypeliculas = new Peliculas.fromJsonmap(decodeData["results"]);

    _popularesList.addAll(arraypeliculas.items);
    streamObject.popularesSink(_popularesList);
    cargando = false;

    return arraypeliculas.items;
  }

  Future<List<Actor>> getActores(String movieId) async {
    final url = Uri.https(_url, "3/movie/$movieId/credits", {
      "api_key": _apiKey,
      "language": _language,
    });

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final casting = Cast.fromJsonList(decodeData["cast"]);

    
    return casting.actores;


  }
}
