import 'package:flutter/material.dart';
import 'listas/projetos/projetos.dart';

void main() {
  runApp(MaterialApp(home: Perfilusuario())); // Função que chama o FLUTTER
}

class Perfilusuario extends StatelessWidget {

  const Perfilusuario({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 10,
            children: [
              
              // Image.asset('images/hexatombe.jpg', width: 200,),
              Text(
                "Bruno Tochetto",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight(800),
                  fontSize: 20
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Projeto()  )),
              child: Text('Projetos')
              )
            ],
          ),
        ),
      ),
    );
  }
}