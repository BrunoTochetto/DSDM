import 'dart:io';

import 'classes.dart';

/*
Dúvidas para tirar:
Como eu faria para deixar a "Equipe" na classe mapa sem precisar enviar ela toda vez
 */

main() {
  int turno = 0;
  bool jogar = true;
  // Inicializa o tabuleiro e as equipes aqui.
  Tabuleiro mapa = new Tabuleiro(16); 
  while (jogar) {
    // Tem que cuidar pra se os 2 n colocaram o navio no mesmo local
    while (true){
      mapa.equipes[0].inicializarNavios(mapa); //função que pede para escolher onde colocar
      bool deuCerto = mapa.equipes[1].inicializarNavios(mapa); 
      if (deuCerto) break; //se ambas as equipes escolheram, segue para o próximo
      clearTerminal();
    }

    // Lógica principal do jogo
  
    int x, y;
    do {
      clearTerminal();    
      // Lógica dos turnos
      Equipe equipeAtual = mapa.equipes[turno]; //alterna entre equipe 0 = 1 e 1 = 2
      mapa.imprimirTabuleiroDeJogo(equipeAtual);
      String pergunta = '>>> ' + equipeAtual.getNameComCor() + ' tente adivinhar onde o adversário colocou seu navio. Coloque os valores separados. Ex: E 11';
      (x,y) = mapa.verificarInputDoXeY(equipeAtual, pergunta, '[a-p]', 0);
      Ponto pontoSelecionado = mapa.tabuleiro[x][y];

      pontoSelecionado.grifo = Simbolos.erro; // x
      pontoSelecionado.cor = equipeAtual.cor;

      if (pontoSelecionado.ehNavio) {
        pontoSelecionado.grifo = Simbolos.acerto; // quadradinho
        equipeAtual.incrementarAcertos();
        // Acertar o navio, tenta denovo
        continue;
      }

      // Uso do operador XOR para "inverter" valores, fazendo com que altere entre 0 e 1. -> também altera a equipe
      turno ^= 1;
    } while(mapa.equipes[0].acertos != 3 && mapa.equipes[1].acertos != 3); //confere se os jogadores já não estão na condição de vitória

    //Finalização do jogo
    clearTerminal();
    mapa.imprimirTabuleiro(true, mapa.equipes[turno].cor);

    


    while (true){
      print('Parabéns ' + mapa.equipes[turno].getNameComCor() + '! Você ganhou!');
      print('Jogar novamente? Sim (S) / Não (N)');
      String? input = stdin.readLineSync();
      if (input == null) continue;
      
      clearTerminal();
      if (input.toLowerCase() == 'n') {
        jogar = false;
        break;
      } else if (input.toLowerCase() == 's') {
        clearTerminal();
        mapa.zerar();
        mapa.equipes[0].acertos = 0;
        mapa.equipes[1].acertos = 0;
        
        break;
      }
    }
  }




}