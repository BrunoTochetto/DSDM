import 'package:curriculo/listas/classe.dart';
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              ImagensCarrosell(),

              const SizedBox(height: 10),
              const Text(
                "Bruno Tochetto",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Projeto() )),
                child: const Text('Projetos'),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class ImagensCarrosell extends StatefulWidget {
  const ImagensCarrosell({super.key});

  @override
  State<ImagensCarrosell> createState() => _ImagensCarrosellState();
}

class _ImagensCarrosellState extends State<ImagensCarrosell> {
  final List<String> gifs = [
    'assets/gifs/amarelo.gif',
    'assets/gifs/regata.gif',
    'assets/gifs/camisetaIf.gif',
  ];
  
  List<List<double>> tamanhos = [TamanhoCarrossell.sizePequeno, TamanhoCarrossell.sizeNormal, TamanhoCarrossell.sizePequeno];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate( 3, (int index) {
          return Opacity(
            opacity: tamanhos[index] == TamanhoCarrossell.sizePequeno ? 0.4 : 1,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  List<List<double>> tamanhosAgora = [
                    TamanhoCarrossell.sizePequeno,
                    TamanhoCarrossell.sizePequeno,
                    TamanhoCarrossell.sizePequeno,
                  ];
                  tamanhosAgora[index] = TamanhoCarrossell.sizeNormal;
                  tamanhos = tamanhosAgora;
                });
              },
              child: Image.asset(
                gifs[index],
                height: 300 * tamanhos[index][0],
                width: 220 * tamanhos[index][1],
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        })
        );
  }
}