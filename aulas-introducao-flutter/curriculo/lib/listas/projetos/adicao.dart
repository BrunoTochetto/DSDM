// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';

import '../classe.dart';


class AdicaoProjeto extends StatefulWidget {
  const AdicaoProjeto({super.key});

  @override
  State<AdicaoProjeto> createState() => _AdicaoProjetoState();
}

class _AdicaoProjetoState extends State<AdicaoProjeto> {
  final TextEditingController nome = TextEditingController();
  final TextEditingController coordenador = TextEditingController();
  final TextEditingController descricaoDoProjeto = TextEditingController();
  DateTime dataInicial = DateTime.now();
  DateTime dataFinal = DateTime.now();

  @override
  void dispose() {
    nome.dispose();
    coordenador.dispose();
    descricaoDoProjeto.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
                // nomeProjeto: 'Reforço em programação',
                // coordenador: 'Alisson Borges Zanetti',
                // dataInicio: DateTime(2025, 4),
                // dataFim: DateTime.now(), 
                // descricaoProjeto
                Text('Nome do projeto'),
                TextField(controller: nome),
                Text('Coordenador(es)'),
                TextField(maxLength: 12, controller: coordenador),
                Text('Descrição do projeto'),
                TextField(controller: descricaoDoProjeto, minLines: 2, maxLines: 10,),
                Text('Data de início'),
                DateTimeField(
                  decoration: const InputDecoration(
                    labelText: 'Enter Date',
                    helperText: 'YYYY/MM/DD',
                  ),
                  dateFormat: DateFormat('dd/MM/yyyy'),
                  value: dataInicial,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        dataInicial = value;
                      });
                    }
                  },
                ),
                Text('Data de fim'),
                DateTimeField(
                  decoration: const InputDecoration(
                    labelText: 'Enter Date',
                    helperText: 'YYYY/MM/DD',
                  ),
                  dateFormat: DateFormat('dd/MM/yyyy'),
                  
                  value: dataFinal,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        dataFinal = value;
                      });
                    }
                  },
                ),
                
                ElevatedButton(onPressed: () {
                  if (nome.text.isNotEmpty && coordenador.text.isNotEmpty && descricaoDoProjeto.text.isNotEmpty) {
                    Navigator.pop(
                      context,
                      Projetos(
                        nomeProjeto: nome.text,
                        dataInicio: dataInicial,
                        dataFim: dataFinal,
                        descricaoProjeto: descricaoDoProjeto.text,
                        coordenador: coordenador.text,
                      ),
                    );
                    return;
                  }
          
                  debugPrint('Preencher todos os dados');
                }, 
                child: Text('Salvar')
              )
            ],
          ),
        ),
      );
  }
}