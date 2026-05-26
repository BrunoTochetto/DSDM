import 'package:flutter/material.dart';
import 'adicao.dart';
import '../classe.dart';

class Projeto extends StatefulWidget {
  const Projeto({super.key});

  @override
  State<Projeto> createState() => _ProjetoState();
}

class _ProjetoState extends State<Projeto> {
  List<Projetos> registros = [
    Projetos(
      nomeProjeto: 'Reforço em programação',
      coordenador: 'Alisson Borges Zanetti',
      dataInicio: DateTime(2025, 4),
      dataFim: DateTime(2026, 11), 
      descricaoProjeto: 'Reforço em programação para o primeiro ano do curso técnico em informática para o IFC Campus Concórdia.'
    ),
    Projetos(
      nomeProjeto: 'História do tempo presente - HTP News',
      coordenador: 'Edimar Sérgio da Silva',
      dataInicio: DateTime(2025, 4),
      dataFim: DateTime(2025, 11), 
      descricaoProjeto: 'Projeto da história do tempo presente'
    ),
    Projetos(
      nomeProjeto: '60 Anos IFC Concórdia',
      coordenador: 'Sílvia Fernanda Souza Dalla Costa',
      dataInicio: DateTime(2025, 4),
      dataFim: DateTime(2025, 11), 
      descricaoProjeto: '60 anos do ifc concórdia'
    )
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.navigate_before_outlined)),
        title: Text('Projetos do Bruno'),
        actions: [Image.asset("assets/img/center.png")],
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          Projetos projetoAtual = registros[index];
          String dataInicio = "${projetoAtual.dataInicio.month}/${projetoAtual.dataInicio.year}";
          String dataFim = 'Atual até ${projetoAtual  .dataFim.month}/${projetoAtual.dataFim.year}';

          if ((projetoAtual.dataFim.month != DateTime.now().month && projetoAtual.dataFim.day != DateTime.now().day && projetoAtual.dataFim.year != DateTime.now().year) || !DateTime.now().isBefore(projetoAtual.dataFim)) {
            dataFim = "${projetoAtual.dataFim.month}/${projetoAtual.dataFim.year}";
          }
          
          return Container(
            color: Colors.greenAccent,
            child: ListTile(
              leading: IconButton(
                icon: Icon(Icons.bookmark),
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Descrição do projeto'),
                    content: Text(projetoAtual.descricaoProjeto),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Fechar'),
                      ),
                    ],
                  ),
                ),
      
                ),
              title: Text("${projetoAtual.nomeProjeto}   $dataInicio | $dataFim"),
              trailing: IconButton(
                onPressed: () => {
                  setState(() {
                    registros.remove(projetoAtual);
                  })
                  
                },
                icon: Icon(Icons.delete_forever_outlined),
              ),
              subtitle: Text("Coordenador: ${projetoAtual.coordenador}"),
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
              MaterialPageRoute(builder: (context) => AdicaoProjeto()),
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


