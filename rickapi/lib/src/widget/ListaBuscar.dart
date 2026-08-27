import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:rickapi/model/info.dart';


class ListaBuscar extends StatelessWidget {
  final Function manusearResposta;
  final Function widgetParaEmpilhar;
  final int pagina;
  final String listaParaBuscaNaAPI;
  final Function retornarUltimaPagina;
  final String uri;

  const ListaBuscar(
    {
      super.key,
      required this.manusearResposta,
      required this.widgetParaEmpilhar,
      required this.pagina,
      required this.listaParaBuscaNaAPI,
      required this.retornarUltimaPagina,
      required this.uri
    });

    Future<List<dynamic>?> pageData() async {
      final Response response;
      
      response = await http.get(Uri.parse(uri));
      
      
      retornarUltimaPagina( Info.fromJson(json.decode(response.body)["info"]) );
      return manusearResposta(response);
    }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // initialData: ,
        future: pageData(), // Aqui vai a função que contém os dados via HTTP:
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            
            case ConnectionState.none:
              return AlertDialog(title: Text("Não há conexão com a internet"),);
            case ConnectionState.waiting:
            case ConnectionState.active:
              return CircularProgressIndicator();
            case ConnectionState.done:
              if (!snapshot.hasData) {
                return Text("Não há informações");
              }

              List<dynamic> listaListada = snapshot.data as List<dynamic>;

              return Column(
                children: [
                  Text(uri.toString()),
                  ListView.builder(
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: listaListada.length,
                    itemBuilder: (context, index) {
                      dynamic listaAtual = listaListada[index];
                  
                      return widgetParaEmpilhar(listaAtual);
                  
                    },
                  ),
                ],
              );

          }
        },
      );
  }
}