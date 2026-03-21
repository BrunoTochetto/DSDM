// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

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
  late List<List<Ladrilho>> ladrilhos;
  late int areaTabuleiro = tamanhoVertical * tamanhoHorizontal;
  late int totalMinas = (areaTabuleiro / 4).floor();
  late ToggleButton toggleButton;
  

  Mapa(
    [this.tamanhoVertical = 20,
    this.tamanhoHorizontal = 20]
  );

  

  @override
  Future<void> onLoad() async {
    _criarLadrilhos();
  }

  void _criarLadrilhos() async {
    await Imagens.loadAll();

    ladrilhos = List.generate(tamanhoVertical, (x) => 
      List.generate(tamanhoHorizontal, (y) => 
      // Está posX = y, pq a IA fez ao contrário. Hmnf, essas máquinas
        Ladrilho(posX: x, posY: y, position: Vector2(x * LADRILHO_TAMANHO, y * LADRILHO_TAMANHO))
      )
    );

    for (var row in ladrilhos) {
      for (var ladrilho in row) {
        add(ladrilho);
      }
    }

    toggleButton = ToggleButton();
    toggleButton.position = Vector2(0, tamanhoVertical*LADRILHO_TAMANHO);
    add(toggleButton);
  }

  void popularMapa() {
    espalharMinas();
    colocarNumeros();
  }


  void espalharMinas() {
    int minasFaltando = totalMinas;
    Random random = Random();

    while (minasFaltando > 0) {
      int x = random.nextInt(tamanhoHorizontal);
      int y = random.nextInt(tamanhoVertical);

      if (!ladrilhos[y][x].ehMina && !ladrilhos[y][x].semMina) {
        ladrilhos[y][x].ehMina = true;
        minasFaltando--;
      }
    }
  }

  void colocarNumeros() {
    for (List row in ladrilhos) {
      for (Ladrilho ladrilhoAtual in row) {
        ladrilhoAtual.definirNumero();
      }
    }
  }
}