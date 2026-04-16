import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Contador()));
}

class Contador extends StatefulWidget {
  const Contador({super.key});

  @override
  State<Contador> createState() => _ContadorState();
}

class _ContadorState extends State<Contador> {
  int quantidade = 0;

  TextStyle textoMaior = TextStyle( fontSize: 19 );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.all(200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          
            children: [
              Text('Quantas vezes o João chamou o professor esta aula', style: TextStyle(
                fontWeight: FontWeight(700),
                fontSize: 20
              ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  ElevatedButton(
                    onPressed: () => {
                      setState(() {
                        if (quantidade <=0) {quantidade = 0; return;}
                        quantidade--;
                      }),
                    },
                    child: Text("-", style: textoMaior),
                  ),

                  Text("$quantidade",
                    style: textoMaior
                  ),
                  
                  ElevatedButton(onPressed: () => {
              setState(() {
                quantidade++;
              })
            }, child: Text("+", style: textoMaior))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
