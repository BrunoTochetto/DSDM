
import 'package:flutter/material.dart';
import 'model/aluno.dart';

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
                if (nome.text.isNotEmpty && numero.text.isNotEmpty && matricula.text.isNotEmpty) {
                    final Aluno alunoCriado = Aluno(nome: nome.text, telefone: numero.text, matricula: matricula.text);
                    Aluno.inserir(alunoCriado);
                    Navigator.pop(context);
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