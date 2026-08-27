// ignore_for_file: public_member_api_docs, sort_constructors_first
class Episodio {
  int id;
  String name;
  String air_date;
  String episode;
  List? characters;
  String url;

  Episodio({
    required this.id,
    required this.name,
    required this.air_date,
    required this.episode,
    required this.characters,
    required this.url,
  });

  factory Episodio.fromJson(Map<String, dynamic> json) {
    return Episodio(
      id: json['id'],
      name: json['name'],
      air_date: json['air_date'],
      episode: json['episode'],
      characters: json['characters'],
      url: json['url'],
    );
  }
}
