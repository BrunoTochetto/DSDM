import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:rickapi/model/info.dart';

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
  late String proximoURI = "https://rickandmortyapi.com/api/${widget.listaParaBuscaNaAPI}?page=1";

  late Future<List<dynamic>?> FuturaListaDeItens = pageData();

  final ScrollController _scrollController = ScrollController();
  bool pegandosInfosProximaPagia = false;
  bool existeProximaPagia = true; // Momento q isso virar TRUE não carrega mais NADA

  late List<dynamic> itensFinais = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final ScrollPosition posicao = _scrollController.position;
      if (posicao.pixels >= posicao.maxScrollExtent - MediaQuery.of(context).size.height * 1.2 && !pegandosInfosProximaPagia && existeProximaPagia) {
        setState(() {
          pegandosInfosProximaPagia = true;
          FuturaListaDeItens = pageData();
        });
      }
    });
  }

  void pegarUltimaPagina(Info info) {
    if (info.next == null) {
      existeProximaPagia = false;
      return debugPrint("Não exite próxima página");
    }

    proximoURI = info.next!;
  }

  Future<List<dynamic>?> pageData() async {
    final Response response;

    response = await http.get(Uri.parse(proximoURI));

    pegarUltimaPagina(Info.fromJson(json.decode(response.body)["info"]));

    return widget.manusearResposta(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.nomePagina)),
      body: ListView(
        controller: _scrollController,  
        children: [
          ListView.builder(
            itemCount: itensFinais.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), // Ia mandou fazer isso, por causa de erro no hasSize

            itemBuilder: (context, index) {
              dynamic listaAtual = itensFinais[index];
      
              return widget.widgetParaEmpilhar(listaAtual);
            },
          ),
          FutureBuilder(
            future:FuturaListaDeItens, // Aqui vai a função que contém os dados via HTTP:
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return AlertDialog(
                    title: Text("Não há conexão com a internet"),
                  );
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  if (!snapshot.hasData) {
                    pegandosInfosProximaPagia = false;
                    return Text("Não há informações, mas é possível você estar sendo rate-limited.");
                  }
      
                  List<dynamic> listaListada = snapshot.data as List<dynamic>;
                  itensFinais.addAll(listaListada);
                  pegandosInfosProximaPagia = false;
      
                  return ListView.builder(
                    
                    itemCount: listaListada.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
      
                    itemBuilder: (context, index) {
                      dynamic listaAtual = listaListada[index];
      
                      return widget.widgetParaEmpilhar(listaAtual);
                    },
                  );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
