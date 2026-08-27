import '../info.dart';
import '../local.dart';
// Trata toda a resposta do json
class LocalRequisicao {
  Info info;
  List<Local> results;

  LocalRequisicao({
    required this.info,
    required this.results,
  });

  factory LocalRequisicao.fromJson(Map<String, dynamic> json) {
    return LocalRequisicao(
      info: Info.fromJson(json['info']),
      results: List<Local>.from(json['results'].map(
        (x) => Local.fromJson(x)
      )),
    );
  }
}