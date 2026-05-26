//Arquivo para juntar tanto a estrutura do banco de dados como o banco em sí.
import 'package:sqflite/sqflite.dart';
// Pega todos os arquivos para integrar
import '../model/aluno.dart';
import '../database/db.dart';
const String tabela = "alunos";

Future<int> insert(Aluno aluno) async {
  final Database db = await getDataBase();
  return db.insert(tabela, aluno.toMap()); // Basicamente um DB Insert de um JSON
  // o db.inser retorna o id q foi criado
}

// Get
Future<List<Map<String, dynamic>>> findAll() async {
  final Database db = await getDataBase();
  List<Map<String, dynamic>> result = await db.query(tabela);
  return result;
}