import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rickapi/model/episodio.dart';
import 'package:rickapi/model/local.dart';
import 'package:rickapi/model/personagem.dart';
import 'package:rickapi/model/requisicao/EpisodioRequisicao.dart';
import 'package:rickapi/model/requisicao/LocalRequisicao.dart';
import 'package:rickapi/model/requisicao/PersonagemRequisicao.dart';
import 'package:rickapi/src/page/listas.dart';
import 'package:rickapi/src/widget/tiles/tileEpisodios.dart';
import 'package:rickapi/src/widget/tiles/tileLocais.dart';
import 'package:rickapi/src/widget/tiles/tilePersonagens.dart';
import 'src/page/inicial.dart';
import 'package:http/http.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // <- Necessário na Web;
  // também deve dar: dart run sqflite_common_ffi_web:setup
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: '/',
      routes: {
        '/': (context) => Inicial(),
        '/personagem': (context) {
          // final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          // final String categoria = args?['categoria'] as String? ?? 'cabeca';
          
          return ListaListada( // Personagem
            listaParaBuscaNaAPI: "character",
            nomePagina: "Personagens",
            widgetParaEmpilhar: (Personagem persona) {
              return TilePersonagem(data: persona);
            },
            manusearResposta: (Response resposta) async {
              if (resposta.statusCode == 200) {
                return PersonagemRequisicao.fromJson(json.decode(resposta.body)).results;
              } else {
                throw Exception("Falha na conexão e na obtenção dos dados com a API");
              }
            },
          );
        },
        '/local': (context) {
          // final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          // final String categoria = args?['categoria'] as String? ?? 'cabeca';
          return ListaListada(
            listaParaBuscaNaAPI: "location",
            nomePagina: "Locais",
            widgetParaEmpilhar: (Local local) {
              return TileLocais(data: local);
            },
            manusearResposta: (Response resposta) async {
              if (resposta.statusCode == 200) {
                return LocalRequisicao.fromJson(json.decode(resposta.body)).results;
              } else {
                throw Exception("Falha na conexão e na obtenção dos dados com a API");
              }
            },
          );
        },
        '/episodio': (context) {
          // final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          // final String categoria = args?['categoria'] as String? ?? 'cabeca';
          // return ListaEpisodios();
          return ListaListada( // Episódio
            listaParaBuscaNaAPI: "episode",
            nomePagina: "Episódios",
            widgetParaEmpilhar: (Episodio ep) {
              return TileEpisodios(data: ep);
            },
            manusearResposta: (Response resposta) async {
              if (resposta.statusCode == 200) {
                return EpisodioRequisicao.fromJson(json.decode(resposta.body)).results;
              } else {
                throw Exception("Falha na conexão e na obtenção dos dados com a API");
              }
            },
          );
        },
      },
    ),
  );
}
