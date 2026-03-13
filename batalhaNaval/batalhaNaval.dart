import 'dart:io';

import 'classes.dart';
main() {
  int turno = 0;
  // Inicializa o tabuleiro e as equipes aqui.
  Tabuleiro mapa = new Tabuleiro(16);

  // Tem que cuidar pra se os 2 n colocaram o navio no mesmo local
  while (true){
    mapa.equipes[0].inicializarNavios(mapa);
    bool deuCerto = mapa.equipes[1].inicializarNavios(mapa);
    if (deuCerto) break;
    clearTerminal();
  }

  int x, y;
  do {
    clearTerminal();    
    // Lógica dos turnos
    Equipe equipeAtual = mapa.equipes[turno];
    mapa.imprimirTabuleiroDeJogo(equipeAtual);
    print('>>> ' + equipeAtual.getNameComCor() + ' tente adivinhar onde o adversário colocou seu navio.');
    (x,y) = mapa.verificarInputDoXeY(equipeAtual, '[a-p]', 0);
    Ponto pontoSelecionado = mapa.tabuleiro[x][y];

    pontoSelecionado.grifo = Simbolos.erro; // x
    pontoSelecionado.cor = equipeAtual.cor;

    if (pontoSelecionado.ehNavio) {
      pontoSelecionado.grifo = Simbolos.acerto; // quadradinho
      equipeAtual.incrementarAcertos();
      // Acertar o navio, tenta denovo
      continue;
    }

    // Uso o oeprador XOR, com sua característica de "inverter" valores, faço que altere entre 0 e 1 o tudo.
    turno ^= 1;
  } while(mapa.equipes[0].acertos != 3 && mapa.equipes[1].acertos != 3);

  //Finalização do jogo
  clearTerminal();
  mapa.imprimirTabuleiro(true, mapa.equipes[turno].cor);
  print(mapa.equipes[turno].getNameComCor() +' Parabens! você ganhou!');



}