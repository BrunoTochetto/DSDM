// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'classes/aluno.dart';

class PaginaDois extends StatelessWidget {
  const PaginaDois({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nome = TextEditingController();
    TextEditingController numero = TextEditingController();
    TextEditingController matricula = TextEditingController();

    return (
      Scaffold(
        appBar: AppBar(),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
              Text('Nome'),
              TextField(controller: nome),
              Text('Telefone'),
              TextField(maxLength: 12, controller: numero),
              Text('Matricula'),
              TextField(controller: matricula, maxLength: 10),

              ElevatedButton(onPressed: () {
                if (nome.text.isNotEmpty && numero.text.isNotEmpty && matricula.text.length == 10) {
                    // Tudo okey
                    Navigator.pop(context, Aluno(nome: nome.text, telefone: numero.text, matricula: matricula.text));
                    return;
                }

                // Deu merda, algo não está certo.
                debugPrint('Preencher todos os dados');
              }, 
              child: Text('Salvar')
            )
          ],
        ),
      )
    );
  }
}