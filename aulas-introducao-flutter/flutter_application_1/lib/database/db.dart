import 'package:path/path.dart';
import "package:sqflite/sqflite.dart";

Future<Database> getDataBase() async {
  final String caminhoBanco = join(await getDatabasesPath(), 'alunos.db'); // Variável do endereço padrão do armazenamento do banco de dados no dispositivo
  return openDatabase(
    caminhoBanco,
    onCreate: (db, version) { // Só executa isso se não existe o banco;
      db.execute("CREATE TABLE alunos (id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, matricula TEXT, telefone TEXT)"); // Criação das tabelas
    },
    version: 2
  );
}