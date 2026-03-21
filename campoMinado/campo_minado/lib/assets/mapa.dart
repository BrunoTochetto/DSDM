// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flame/components.dart';

import 'package:campo_minado/assets/ladrilhos/ladrilho.dart';
import 'package:flame/input.dart';
import 'imagens.dart';
import 'toggle_button.dart';

class Mapa extends World {
  bool createFlag = false;
  late double LADRILHO_TAMANHO = Ladrilho.LADRILHO_TAMANHO;

  int tamanhoVertical;
  int tamanhoHorizontal;
  List<Ladrilho>? ladrilhos = [];
  late int areaTabuleiro = tamanhoVertical * tamanhoHorizontal;
  late ToggleButton toggleButton;
  

  Mapa(
    [this.tamanhoVertical = 20,
    this.tamanhoHorizontal = 20]
  );

  

  @override
  Future<void> onLoad() async {
    await Imagens.loadAll();

    for (int x = 0; x < tamanhoHorizontal; x++) {
      for (int y = 0; y < tamanhoVertical; y++) {
        Ladrilho ultimoLadrilho = Ladrilho(position: Vector2(x*LADRILHO_TAMANHO, y*LADRILHO_TAMANHO));
        ladrilhos?.add(ultimoLadrilho);
        add(ultimoLadrilho);
      }
    }

    toggleButton = ToggleButton();
    toggleButton.position = Vector2(LADRILHO_TAMANHO, findGame()!.size.y - 75);
    add(toggleButton);
  }
}