class Personagem {
  int id;
  String name;
  String status;
  String species;
  String type;
  String gender;
  Map<String, String>? origin;
  Map<String, String>? location;
  String image;
  List<String>? episode;
  String url;
  String created;

  Personagem({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    this.origin,
    this.location,
    required this.image,
    this.episode,
    required this.url,
    required this.created
  });

  // transforma o JSON em objeto tipo Personagem.
  factory Personagem.fromJson(Map<String, dynamic> json) {
    return Personagem(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      image: json['image'],
      url: json['url'],
      created: json['created'],
    );
  }
}
