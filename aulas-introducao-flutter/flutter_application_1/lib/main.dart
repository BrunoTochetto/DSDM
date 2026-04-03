import 'package:flutter/material.dart';
import 'outraPagina.dart';

void main() {
  runApp(
    MaterialApp(
      home: TelaInicial(),
      )
    ); // Função que chama o FLUTTER
}

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Titulo muito legal'),
        actions: [
          Text('aqui os botões')
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [Text("Olá 3G! :D"), Text("Olá 3G! :D"), Text("Olá 3G! :D"), Text("Olá 3G! :D"), Text("Olá 3G! :D"), Text("Olá 3G! :D"), Text("Olá 3G! :D"),Text("Olá 3G! :D"),Text("Olá 3G! :D"),Text("Olá 3G! :D"),Text("Olá 3G! :D"),Text("Olá 3G! :D"),Text("Olá 3G! :D"),Text("Olá 3G! :D"),Text("Olá 3G! :D"),Text("Olá 3G! :D"),Text("Olá 3G! :D"),],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),        
        onPressed: () => Navigator.push(
          context, MaterialPageRoute(
            builder: (context) => PaginaDois(),
          )).then((aluno) {
            debugPrint(aluno.nome);
          },
          ),
        ),
    );
  }
}

