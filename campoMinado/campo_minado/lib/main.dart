import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import "assets/mapa.dart";
import "assets/ladrilhos/ladrilho.dart";

void main() {
    final int tamanhoHorizontal = 12;
  final int tamanhoVertical = 12;


  final cameraDoJogo = CameraComponent.withFixedResolution(
    width: Ladrilho.LADRILHO_TAMANHO*(tamanhoHorizontal+2),
    height: Ladrilho.LADRILHO_TAMANHO*(tamanhoVertical+3),
  );

  runApp(
    GameWidget(
      game:
      FlameGame(
        world: Mapa(tamanhoVertical, tamanhoHorizontal),
        camera: cameraDoJogo
    ),
  ));

  cameraDoJogo.moveTo(
    Vector2(Ladrilho.LADRILHO_TAMANHO*tamanhoHorizontal/2, Ladrilho.LADRILHO_TAMANHO*tamanhoVertical/2)
  );
}