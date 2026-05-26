import '../dao/aluno.dart';

class Aluno {

  int? id; // id PODE ser nulo
  String nome;
  String telefone;
  String matricula;

  Aluno({
    this.id, // Não ser opcional
    required this.nome,
    required this.telefone,
    required this.matricula,
  });

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "nome": nome,
      "matricula": matricula,
      "telefone": telefone
      };
  }

  static Future<int> inserir(Aluno aluno) {
    return insert(aluno);
  }

  static Future<List<Map<String, dynamic>>> fetchAll() {
    return findAll();
  }



  @override 
  String toString() {
    return "Aluno:(id: $id, nome: $nome, matricula: $matricula, telefone: $telefone)";
  }
}