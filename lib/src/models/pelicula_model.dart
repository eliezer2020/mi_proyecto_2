// Generated by https://quicktype.io
class Peliculas {
List <Pelicula> items = new List();

Peliculas.fromJsonmap (List<dynamic> rawJson ){
  if (rawJson==null ) {
    print("jason vacio ");
    return;
  }
  
for (var itemRaw in rawJson){
  final pelicula = new Pelicula.fromJS(itemRaw);
  items.add(pelicula);
  
}



  }





}



class Pelicula {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Pelicula({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Pelicula.fromJS(Map<String, dynamic> jsonmap) {
       voteCount     = jsonmap['vote_count'];
    id               = jsonmap['id'];
    video            = jsonmap['video'];
    //castear a double
    voteAverage      = jsonmap['vote_average'] / 1;
    title            = jsonmap['title'];
    popularity       = jsonmap['popularity'] / 1;
    posterPath       = jsonmap['poster_path'];
    originalLanguage = jsonmap['original_language'];
    originalTitle    = jsonmap['original_title'];
    genreIds         = jsonmap['genre_ids'].cast<int>();
    backdropPath     = jsonmap['backdrop_path'];
    adult            = jsonmap['adult'];
    overview         = jsonmap['overview'];
    releaseDate      = jsonmap['release_date'];
  }

String getImage (){

  if(posterPath == null) return "https://webhostingmedia.net/wp-content/uploads/2018/01/http-error-404-not-found.png";
  
  return "https://image.tmdb.org/t/p/w300/$posterPath";
  
}

String getPoster (){

  if(backdropPath == null) return "https://webhostingmedia.net/wp-content/uploads/2018/01/http-error-404-not-found.png";
  
  return "https://image.tmdb.org/t/p/w300/$backdropPath";
  
}

}
