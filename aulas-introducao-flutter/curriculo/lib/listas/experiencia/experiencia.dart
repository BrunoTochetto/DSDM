import 'package:flutter/material.dart';
import 'adicao.dart';
import '../classe.dart';

class Experiencia extends StatefulWidget {
  const Experiencia({super.key});

  @override
  State<Experiencia> createState() => _ExperienciaState();
}

class _ExperienciaState extends State<Experiencia> {
  List<Experiencias> registros = [
    Experiencias(
      titulo: 'Experiência em desenvolvimento Flutter',
      dataInicio: DateTime(2024),
      dataFim: DateTime(2024),
      descricao: 'Desenvolvimento de aplicações pela disciplina de Desenvolvimento para dispositíveis móveis',
      empresa: 'IFC Campus Concórdia',
    ),
    Experiencias(
      titulo: 'Desenvolvimento de atividades com Python',
      dataInicio: DateTime(2024),
      dataFim: DateTime(2026),
      descricao: 'Pesquisa, aplicação e uso contínuo do Python pelo projeto de Reforço em programação.',
      empresa: 'IFC Campus Concórdia',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.navigate_before_outlined)),
        title: Row(
          children: [
            Text('Experiências do Bruno'),

            SizedBox(
              width: 56,
              child: Image.asset(
                "assets/gifs/pensando.gif",
                fit: BoxFit.scaleDown,
              
                ),
            )
          ],
        ),
        actions: [Image.asset("assets/img/center.png")],
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          Experiencias ExperienciaAtual = registros[index];
          String dataInicio = "${ExperienciaAtual.dataInicio.month}/${ExperienciaAtual.dataInicio.year}";
          String dataFim = 'Atual';
          if (ExperienciaAtual.dataFim.month != DateTime.now().month && ExperienciaAtual.dataFim.day != DateTime.now().day) {
            
            dataFim = "${ExperienciaAtual.dataFim.month}/${ExperienciaAtual.dataFim.year}";
          }
          
          return Container(
            color: Colors.greenAccent,
            child: ListTile(
              leading: IconButton(
                icon: Icon(Icons.school_rounded),
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Descrição do projeto'),
                    content: Text(ExperienciaAtual.descricao),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Fechar'),
                      ),
                    ],
                  ),
                ),
      
                ),
              title: Text("${ExperienciaAtual.titulo}   $dataInicio | $dataFim"),
              subtitle: Text(ExperienciaAtual.empresa),
              trailing: IconButton(
                onPressed: () => {
                  setState(() {
                    registros.remove(ExperienciaAtual);
                  })
                  
                },
                icon: Icon(Icons.delete_forever_outlined),
              ),
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
              MaterialPageRoute(builder: (context) => AdicaoExperiencia()),
            ).then((experiencia) {
              
              setState(() {
                registros.add(
                  experiencia,
                );
              });
            }),
      ),
    );
  }
}
