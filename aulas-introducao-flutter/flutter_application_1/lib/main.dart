import 'package:flutter/material.dart';
import 'perfilUsuario.dart';
import 'outraPagina.dart';
import 'classes/aluno.dart';

void main() {
  runApp(MaterialApp(home: TelaInicial())); // Função que chama o FLUTTER
}

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  List<Aluno> registros = [
    Aluno(nome: "Antoni", telefone: "49999169602", matricula: "2024311369"),
    Aluno(nome: "Pedro Freitas", telefone: "4998888660", matricula: "2024305138"),
  ];

  @override
  Widget build(BuildContext context) {
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
            color: Colors.greenAccent,
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
                onPressed: () => {
                  setState(() {
                    registros.remove(registros[index]);
                  })
                  
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
