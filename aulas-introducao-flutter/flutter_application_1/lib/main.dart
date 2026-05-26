import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'perfilUsuario.dart';
import 'outraPagina.dart';
import 'model/aluno.dart';


void main() {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit(); // Iniciar o sqlite
    databaseFactory = databaseFactoryFfi;
  } else {
    databaseFactory = databaseFactoryFfiWeb;
  }
  Aluno alunoNovo = Aluno(nome: "ola", matricula: "123", telefone: "123");
  Aluno.inserir(alunoNovo);

  // Aluno.fetchAll().then((alunos){
  //   for (Map aluno in alunos) {
  //     debugPrint("Alunos cadastrados: $aluno");
  //   }
  // });
  Aluno.fetchAll().then( (valores) {
    for (Map valor in valores) {
      debugPrint(valor.toString());
    }
  });
  
  // runApp(MaterialApp(
  //       home: TelaInicial()
  //     )
  //   ); // Função que chama o FLUTTER
}

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {  

  @override
  Widget build(BuildContext context) {
    List<Aluno> registros = [];


    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Titulo muito legal'),
        actions: [Text('aqui os botões')],
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.red[600],
            child: ListTile(
              leading: IconButton(
                icon: Image.asset('images/sabrina.jpg'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Perfilusuario(aluno: registros[index], imagem: index))
                ),
              ),
              title: Text(registros[index].nome),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    registros.remove(registros[index]);
                  });
                },
                icon: Icon(Icons.delete_forever_outlined),
              ),
              subtitle: Text("Matricula: ${registros[index].matricula} Telefone: ${registros[index].telefone}"),
            ),
          );
        },
        itemCount: registros.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PaginaDois()),
            ).then((aluno) {
              // registros.add(aluno);
              setState(() {
                registros.add(
                  aluno,
                );
              });
            }),
      ),
    );
  }
}
