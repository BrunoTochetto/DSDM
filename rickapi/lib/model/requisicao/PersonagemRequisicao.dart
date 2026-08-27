import '../info.dart';
import '../personagem.dart';
// Trata toda a resposta do json
class PersonagemRequisicao {
  Info info;
  List<Personagem> results;

  PersonagemRequisicao({
    required this.info,
    required this.results,
  });

  factory PersonagemRequisicao.fromJson(Map<String, dynamic> json) {
    return PersonagemRequisicao(
      info: Info.fromJson(json['info']),
      results: List<Personagem>.from(json['results'].map(
        (x) => Personagem.fromJson(x)
      )),
    );
  }
}