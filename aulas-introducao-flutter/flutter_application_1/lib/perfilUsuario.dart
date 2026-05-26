import 'package:flutter/material.dart';
import 'model/aluno.dart';

class Perfilusuario extends StatelessWidget {
  final Aluno aluno;
  final int imagem;
  
  const Perfilusuario({super.key, usuario, required this.aluno, required this.imagem});
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 10,
            children: [
              // Image(image: image)
              // Icon(Icons.person_4, size: 50,),
              Image.asset('images/hexatombe.jpg', width: 200,),
              Text(
                aluno.nome,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight(800),
                  fontSize: 20
                ),
              ),
              Text(
                "Matricula: ${aluno.matricula}",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight(500)
                ),
              ),
              Text(
                "Telefone: ${aluno.telefone}",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight(500)
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
              child: Text('Voltar')
              )
            ],
          ),
        ),
      ),
    );
  }
}