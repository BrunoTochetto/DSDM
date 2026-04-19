import 'package:curriculo/listas/classe.dart';
import 'package:flutter/material.dart';
import 'listas/escolaridade/escolaridade.dart';
import 'listas/projetos/projetos.dart';
import 'listas/experiencia/experiencia.dart';

void main() {
  runApp(MaterialApp(
    home: Perfilusuario(),
    title: 'Curriculo do Bruno',
    
    ),
    ); // Função que chama o FLUTTER
}

class Perfilusuario extends StatefulWidget {
  const Perfilusuario({super.key});

  @override
  State<Perfilusuario> createState() => _PerfilusuarioState();
}

class _PerfilusuarioState extends State<Perfilusuario> {
  String estado = 'casual';
  void atualizarTela(String novoEstado) {
    setState(() {
      estado = novoEstado;
    });
  }

  Widget textoBotaoComMeuRosto(String texto) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/img/left.png', fit: BoxFit.fitHeight,height: 60,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(texto, style: TextStyle(fontSize: 16),),
        ),
        Image.asset('assets/img/right.png', fit: BoxFit.fitHeight,height: 60,),
      ]
    );
  }

  ButtonStyle estiloBotao = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(Colors.amber),
  );

  @override
  Widget build(BuildContext context) {
    String suffixo = '';
    const String nome = 'Bruno Tochetto';
    String prefixo = '';

    if (estado == 'casual') suffixo = 'casual';
    if (estado == 'if') suffixo = 'no IF';
    if (estado == 'frio') suffixo = 'com frio';

    return Scaffold(
      body: ListView(

        children: [Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                ImagensCarrosell(atualizarStatus: atualizarTela),
        
                const SizedBox(height: 10),
                Text(
                  "$prefixo $nome $suffixo",
                  style: TextStyle(
                    fontWeight: FontWeight(600),
                    fontSize: 20
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  spacing: 20,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Projeto() )),
                      style: estiloBotao,
                      child: textoBotaoComMeuRosto('Projetos'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Escolaridade() )),
                      style: estiloBotao,
                      child: textoBotaoComMeuRosto('Escolaridade'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Experiencia() )),
                      style: estiloBotao,
                      child: textoBotaoComMeuRosto('Experiência'),
                    ),
                  ],
                )
                
              ],
            ),
          ),
        ),
        ]
      ),
    );
  }
}


class ImagensCarrosell extends StatefulWidget {
  final Function atualizarStatus;
  const ImagensCarrosell({super.key, required this.atualizarStatus});

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

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 25,
      // ! Heitor HELP, não sei pq n consigo usar isso com ListView.builder. 
      // Dá erro de "gesturedetector has no size", mas coloco um sizedBox e nada.
      // Achei no stackoverflow esse jeito.
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
    
                  if (index == 0) widget.atualizarStatus('frio');
                  if (index == 1) widget.atualizarStatus('casual');
                  if (index == 2) widget.atualizarStatus('if');
    
                  
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