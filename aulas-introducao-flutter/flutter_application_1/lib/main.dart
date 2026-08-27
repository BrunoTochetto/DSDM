import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'perfilUsuario.dart';
import 'outraPagina.dart';
import 'model/aluno.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized(); // <- Necessário na Web;
  // Isso basicamente adiciona o JS na web;
  // também deve dar: dart run sqflite_common_ffi_web:setup

  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  } else if(Platform.isWindows || Platform.isLinux || Platform.isMacOS) { //padrão para qualquer app
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi; //usa essa biblioteca
  } else {
    //de outro
    databaseFactory = databaseFactoryFfiWeb;
  }

  Aluno.findByName("BrunadaSilvaDonati").then((valores) {
    for(Map valor in valores) {
      debugPrint(valor.toString());
    }
  });
  
  runApp(MaterialApp(
        home: TelaInicial()
      )
    ); // Função que chama o FLUTTER
}

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {  
  TextEditingController pesquisa = TextEditingController();
  Future<List<Map<String, dynamic>>> queryBanco = Aluno.findByName("");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: SearchBar(controller: pesquisa, onChanged: (valor) {setState(() {queryBanco = Aluno.findByName(pesquisa.text);});},),
        actions: [Text('aqui os botões')],
      ),
      body: FutureBuilder(
        initialData: const [Text("Dados carregando...")], // Dados inicias. Uma tela padrão
        future: queryBanco, // Onde vai pegar todos os dados
        builder: (context, snapshot) {
      
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("Erro de conexão com o banco de dados.");
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              // Obter as informações do banco
              List<Map<String, dynamic>> valores = snapshot.data as List<Map<String, dynamic>>; // Casting, fazendo o snapshot ser forçadamente um Map
      
              return ListView.builder(
                itemCount: valores.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(valores[index]["nome"]),
                    leading: Image.asset('images/sabrina.jpg'),
                    subtitle: Text(valores[index]["matricula"]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState((){
                          Aluno.deleteById(valores[index]["id"]);
                        });
                        
                      },
                    ),
                    ); // Pegar valores como map
                },
                );
          }
        }, 
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PaginaDois()),
            )
      ),
    );
  }
}
