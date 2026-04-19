// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';

import '../classe.dart';

class AdicaoExperiencia extends StatefulWidget {
  const AdicaoExperiencia({super.key});

  @override
  State<AdicaoExperiencia> createState() => _AdicaoExperienciaState();
}

class _AdicaoExperienciaState extends State<AdicaoExperiencia> {
  final TextEditingController tituloExperiencia = TextEditingController();
  final TextEditingController empresa = TextEditingController();
  final TextEditingController descricaoExperiencia = TextEditingController();
  DateTime dataInicial = DateTime.now();
  DateTime dataFinal = DateTime.now();

  @override
  void dispose() {
    tituloExperiencia.dispose();
    empresa.dispose();
    descricaoExperiencia.dispose();
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
            Text('Título da experiência'),
            TextField(controller: tituloExperiencia),
            const SizedBox(height: 16),
            Text('Empresa / Local'),
            TextField(controller: empresa),
            const SizedBox(height: 16),
            Text('Descrição da experiência'),
            TextField(
              controller: descricaoExperiencia,
              minLines: 2,
              maxLines: 6,
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
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

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (tituloExperiencia.text.isNotEmpty &&
                    empresa.text.isNotEmpty &&
                    descricaoExperiencia.text.isNotEmpty) {
                  Navigator.pop(
                    context,
                    Experiencias(
                      titulo: tituloExperiencia.text,
                      dataInicio: dataInicial,
                      dataFim: dataFinal,
                      descricao: descricaoExperiencia.text,
                      empresa: empresa.text,
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
