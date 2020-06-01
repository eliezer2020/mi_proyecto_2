class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> rawJason) {

    // ALV pincje json
    // si uso lo espacios ya no lo encuentra
    //tomar en cuenta los espacios 
    castId = rawJason["cast_id"];
    //no va a encontrar character pero si name cast, etc
    character = rawJason["    character"];
    creditId = rawJason["    credit_id"];
    gender = rawJason["    gender"];
    id = rawJason["id"];
    name = rawJason["name"];
    order = rawJason["    order"];
    profilePath = rawJason["profile_path"];
  }

  String getFoto() {
    if (profilePath == null) return "https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png";

    return "https://image.tmdb.org/t/p/w500/$profilePath";
  }
}

class Cast {
  List<Actor> actores = new List();

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

//lista de mapas json convertida en lista de actores
    jsonList.forEach((element) {
      //se procesa cada elemento
      final actor = Actor.fromJsonMap(element);

      actores.add(actor);
    });
  }
}
