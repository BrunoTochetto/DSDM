import 'dart:io';

import 'classes.dart';

main() {
  // Inicializa o tabuleiro e as equipes aqui.
  Tabuleiro mapa = new Tabuleiro(16);

  // Tem que cuidar pra se os 2 n colocaram o navio no mesmo local
  while (true){
  mapa.equipes[0].inicializarNavios(mapa);
  bool deuCerto = mapa.equipes[1].inicializarNavios(mapa);
  if (deuCerto) break;
  clearTerminal();
  print('Vocês colocaram o navio no mesmo local... Terão que fazer tudo denovo');
  }


}