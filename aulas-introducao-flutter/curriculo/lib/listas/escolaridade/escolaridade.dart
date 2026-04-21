import 'package:flutter/material.dart';
import 'adicao.dart';
import '../classe.dart';

class Escolaridade extends StatefulWidget {
  const Escolaridade({super.key});

  @override
  State<Escolaridade> createState() => _EscolaridadeState();
}

class _EscolaridadeState extends State<Escolaridade> {
  List<Escolaridades> registros = [
    Escolaridades(nomeInstituicao: 'Escola Básica Municipal Anna Zamarchi Coldebella', dataInicio: DateTime(2011), dataFim: DateTime(2024), curso: 'Ensino fundamental'),
    Escolaridades(nomeInstituicao: 'Sesi', dataInicio: DateTime(2012), dataFim: DateTime(2014), curso: 'Robótica básica'),
    Escolaridades(nomeInstituicao: 'Terra cursos', dataInicio: DateTime(2016), dataFim: DateTime(2017), curso: 'Design gráfico'),
    Escolaridades(nomeInstituicao: 'Athus', dataInicio: DateTime(2015), dataFim: DateTime(2017), curso: 'Inglês básico e intermediário'),
    Escolaridades(nomeInstituicao: 'Instituto Federal Catarinense - Campus concórdia', dataInicio: DateTime(2024), dataFim: DateTime(2026, 12, 21), curso: 'Ensino médio')
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.navigate_before_outlined)),
        title: Row(
          children: [
            Text('Escolaridade do Bruno'),

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
          Escolaridades EscolaridadeAtual = registros[index];
          String dataInicio = "${EscolaridadeAtual.dataInicio.month}/${EscolaridadeAtual.dataInicio.year}";
          String dataFim = 'Atual até ${EscolaridadeAtual.dataFim.month}/${EscolaridadeAtual.dataFim.year}';
          
          if (EscolaridadeAtual.dataFim.month != DateTime.now().month && EscolaridadeAtual.dataFim.day != DateTime.now().day && EscolaridadeAtual.dataFim.year != DateTime.now().year || !DateTime.now().isBefore(EscolaridadeAtual.dataFim)) {
            dataFim = "${EscolaridadeAtual.dataFim.month}/${EscolaridadeAtual.dataFim.year}";
          }
          
          return Container(
            color: Colors.greenAccent,
            child: ListTile(
              leading: Icon(Icons.school),
              title: Text("${EscolaridadeAtual.nomeInstituicao}   $dataInicio | $dataFim"),
              trailing: IconButton(
                onPressed: () => {
                  setState(() {
                    registros.remove(EscolaridadeAtual);
                  })
                  
                },
                icon: Icon(Icons.delete_forever_outlined),
              ),
              subtitle: Text("Cursado: ${EscolaridadeAtual.curso}"),
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
              MaterialPageRoute(builder: (context) => AdicaoEscolaridade()),
            ).then((Escolaridade) {
              
              setState(() {
                registros.add(
                  Escolaridade,
                );
              });
            }),
      ),
    );
  }
}
