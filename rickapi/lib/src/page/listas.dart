import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:rickapi/model/info.dart';
import 'package:rickapi/src/widget/ListaBuscar.dart';

class ListaListada extends StatefulWidget {
  final String listaParaBuscaNaAPI;
  final String nomePagina;
  final Function widgetParaEmpilhar;
  final Function manusearResposta;

  const ListaListada({
    required this.listaParaBuscaNaAPI,
    required this.nomePagina,
    required this.widgetParaEmpilhar,
    required this.manusearResposta,
    super.key,
  });

  @override
  State<ListaListada> createState() => _ListaListadaState();
}

class _ListaListadaState extends State<ListaListada> {
  late int ultimaPagina = 2;
  late List<String> urls = ["https://rickandmortyapi.com/api/${widget.listaParaBuscaNaAPI}?page=1"]; //  campo URI de ListaBuscar funcionar com primeira página.

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final posicao = _scrollController.position;
      if (posicao.pixels >= posicao.maxScrollExtent - 200) {
        print("é para atualizar página");
        print(urls.toString());
        setState(() {debugPrint("Deu setState");});
      }
    });
  }

  void pegarUltimaPagina(Info info) {
    if (info.next == null) {
      return debugPrint("não exite próxima página");
    }
    
    if (urls.contains(info.next)) {
      return;
    } else {
      urls.add(info.next!);
    }
      
    
    // ultimaPagina = max(int.parse(info.next.toString()[-1]), ultimaPagina);
    // ultimaPagina++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.nomePagina)),
      body: ListView.builder(
        itemCount: urls.length,
        itemBuilder: (context, index) {
          return ListaBuscar(
            manusearResposta: widget.manusearResposta,
            widgetParaEmpilhar: widget.widgetParaEmpilhar,
            pagina: 1,
            listaParaBuscaNaAPI: widget.listaParaBuscaNaAPI,
            retornarUltimaPagina: pegarUltimaPagina,
            uri: urls[index],
          );
        },
      ),
    );
  }
}
