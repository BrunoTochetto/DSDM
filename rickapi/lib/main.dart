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
  WidgetsFlutterBinding.ensureInitialized(); // <- Necessário na Web; // Sinceramente estava aqui, deve ser de um CTRL V que eu dei no main, vai q precisa de vdd, n sei
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Inicial(),
        '/personagem': (context) {
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
