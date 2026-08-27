import '../dao/aluno.dart';

class Aluno {

  int? id; // id PODE ser nulo
  String nome;
  String matricula;
  String telefone;

  Aluno({
    this.id, // Não ser opcional
    required this.nome,
    required this.matricula,
    required this.telefone,
  });

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "nome": nome.toString(),
      "matricula": matricula.toString(),
      "telefone": telefone.toString()
      };
  }

  static Future<int> inserir(Aluno aluno) async {
    return await insertDatabase(aluno);
  }

  static Future<List<Map<String, dynamic>>> fetchAll() async {
    return await findAllDatabase();
  }

  static Future<int> deleteById(int id) async {
    return await deleteByIdDatabase(id);
  }

  static Future<List<Map<String, dynamic>>> findByName(String nome) async {
    return findByNameDatabase(nome);
  }

  @override 
  String toString() {
    return "Aluno:(id: $id, nome: $nome, matricula: $matricula, telefone: $telefone)";
  }
}