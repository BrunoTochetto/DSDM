import '../info.dart';
import '../episodio.dart';
// Trata toda a resposta do json
class EpisodioRequisicao {
  Info info;
  List<Episodio> results;

  EpisodioRequisicao({
    required this.info,
    required this.results,
  });

  factory EpisodioRequisicao.fromJson(Map<String, dynamic> json) {
    return EpisodioRequisicao(
      info: Info.fromJson(json['info']),
      results: List<Episodio>.from(json['results'].map(
        (x) => Episodio.fromJson(x)
      )),
    );
  }
}