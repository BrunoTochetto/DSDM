import 'package:flame/components.dart';
import 'package:flame/events.dart';
import '../mapa.dart';
import '../imagens.dart';

class Ladrilho extends SpriteComponent with TapCallbacks {
  late bool ehBandeira = false;
  late bool ehMina = false;
  late bool clicado = false;
  late int numero = 0;

  static const double LADRILHO_TAMANHO = 25;
  
  Ladrilho({super.position}) :
    super(size: Vector2.all(LADRILHO_TAMANHO), anchor: Anchor.topLeft);

  @override
  Future<void> onLoad() async {
    sprite = Imagens.tile;
  }

  @override
  void onTapDown(TapDownEvent info) async {
    // achar Jogo -> Mundo, e dai lê a variável createFlag
    if ((findGame()!.world as Mapa).createFlag && !clicado) {

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

    clicado = true;

    // Clicked tile logic;
    sprite = Imagens.emptyTile;
  }
}

