import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/cupertino.dart';
import '../mapa.dart';
import '../imagens.dart';

class Ladrilho extends SpriteComponent with TapCallbacks {
  late bool ehBandeira = false;
  late bool ehMina = false;
  late bool clicado = false;
  late int numero = 0;
  bool semMina = false;

  late Sprite spriteNumero;

  static bool primeiraJogada = false;

  int posX;
  int posY;

  static const double LADRILHO_TAMANHO = 25;
  late Mapa mapa = (findGame()!.world as Mapa);
  
  Ladrilho({required this.posX, required this.posY, super.position}) :
    super(size: Vector2.all(LADRILHO_TAMANHO), anchor: Anchor.topLeft);

  @override
  Future<void> onLoad() async {
    sprite = Imagens.tile;
  }

  @override
  void onTapDown(TapDownEvent info) async {
    if (Ladrilho.primeiraJogada == false) {
      semMina = true;
      mapa.popularMapa();
      Ladrilho.primeiraJogada = true;
    }
    onClick();
  }

  void onClick() {
    // achar Jogo -> Mundo, e dai lê a variável createFlag
    if (mapa.createFlag && !clicado) {

      if (ehBandeira) {
        sprite = Imagens.tile;
        ehBandeira = false;
        return;
      }

      sprite = Imagens.flagTile;
      ehBandeira = true;
      return;
    }

    // Acima, é a lógica de colocar/tirar a bandeira.
    // Ela se dá pela variável do mundo "createFlag".
    // Se passou dessa lógica, aqui é para quando vc clica na célula ela explode ou vira um número.
    // mas se for uma bandeira, n deve fazer nada.

    if (ehBandeira) return;

    if (clicado) {
      clicarTilesAdjacentes();
      return;
    }

    clicado = true;

    // Clicked tile logic;
    revelarLadrilho();
    
  }

  void revelarLadrilho() {
    if (ehMina) {
      sprite = Imagens.mineTile;
      numero = -1;
      return;
    }

    sprite = spriteNumero;

    if (numero == 0) {
      clicarTilesAdjacentes();
    }

  }

  void clicarTilesAdjacentes() {
    for (int x = posX-1; x < posX+2; x++) {
      for (int y = posY-1; y < posY+2; y++) {
        if (x >= 0 && x < mapa.tamanhoHorizontal && y >= 0 && y < mapa.tamanhoVertical) {
          Ladrilho ladrilhoAtual = mapa.ladrilhos[x][y];
          if (ladrilhoAtual.clicado) continue;
          ladrilhoAtual.onClick();
        }
      }
    }
  }

  void definirNumero() {
    print('Definir numero');
    if (ehMina == true) return;

    for (int x = posX-1; x < posX+2; x++) {
      for (int y = posY-1; y < posY+2; y++) {
        if (x >= 0 && x < mapa.tamanhoHorizontal && y >= 0 && y < mapa.tamanhoVertical) {
          Ladrilho ladrilhoAtual = mapa.ladrilhos[x][y];
          if (ladrilhoAtual.clicado) continue;

          if (ladrilhoAtual.ehMina == true)  {
            numero++;
          }
        }
      }
    }
    spriteNumero = Imagens.numeros[numero]!;
  }
}

