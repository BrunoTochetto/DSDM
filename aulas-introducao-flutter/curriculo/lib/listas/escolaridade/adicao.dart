// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';

import '../classe.dart';

class AdicaoEscolaridade extends StatefulWidget {
  const AdicaoEscolaridade({super.key});

  @override
  State<AdicaoEscolaridade> createState() => _AdicaoEscolaridadeState();
}

class _AdicaoEscolaridadeState extends State<AdicaoEscolaridade> {
  final TextEditingController nomeInstituicao = TextEditingController();
  final TextEditingController curso = TextEditingController();
  DateTime dataInicial = DateTime.now();
  DateTime dataFinal = DateTime.now();

  @override
  void dispose() {
    nomeInstituicao.dispose();
    curso.dispose();
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
            // Escolaridades(nomeInstituicao: 'Escola Básica Municipal Anna Zamarchi Coldebella', dataInicio: DateTime(2011), dataFim: DateTime(2024), curso: 'Ensino fundamental')
            Text('Nome da institução'),
            TextField(controller: nomeInstituicao),
            Text('Curso'),
            TextField(maxLength: 12, controller: curso),
            Text('Descrição do projeto'),
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

            ElevatedButton(
              onPressed: () {
                if (nomeInstituicao.text.isNotEmpty &&
                    curso.text.isNotEmpty) {
                  Navigator.pop(
                    context,
                    Escolaridades(
                      nomeInstituicao: nomeInstituicao.text,
                      dataInicio: dataInicial,
                      dataFim: dataFinal,
                      curso: curso.text,
                    ),
                  );
                  return;
                }

                debugPrint('Preencher todos os dados');
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
