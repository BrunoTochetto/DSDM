import 'package:flutter/material.dart';

class Inicial extends StatelessWidget {
  const Inicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("images/app-icon.png"),
        title: Text("API do Rick and Morty"),
      ),
      body: ListView(
        children: [
          _Seletores(imagem: "characters", link: "personagem", texto: "Personagens"),
          _Seletores(imagem: "episodes", link: "episodio", texto: "Episódios"),
          _Seletores(imagem: "locations", link: "local", texto: "Locais"),
        ],
      ),
    );
  }
}

class _Seletores extends StatelessWidget {
  final String imagem;
  final String texto;
  final String link;
  const _Seletores({
    required this.imagem,
    required this.link,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/$link');
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Image.asset("images/$imagem.png", height: (MediaQuery.of(context).size.height * 0.24)),
            Text(texto, style: TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}