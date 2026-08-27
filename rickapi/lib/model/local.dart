// ignore_for_file: public_member_api_docs, sort_constructors_first
class Local {
  int id;
  String name;
  String type;
  String dimension;
  List? residents;
  String url;

  Local({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
    required this.url,
  });

  factory Local.fromJson(Map<String, dynamic> json) {
    return Local(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      dimension: json['dimension'],
      residents: json['residents'],
      url: json['url'],
    );
  }
}
