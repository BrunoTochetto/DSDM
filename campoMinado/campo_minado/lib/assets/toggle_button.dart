import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'mapa.dart';
import 'imagens.dart';

class ToggleButton extends PositionComponent {
  late SpriteButtonComponent button;

  @override
  Future<void> onLoad() async {
    button = SpriteButtonComponent(
      button: Imagens.buttonFlag,
      buttonDown: Imagens.buttonPressed,
      size: Vector2(75, 25),
      onPressed: _onPressed,
    );
    add(button);
  }

  void _onPressed() {
    final mapa = findGame()!.world as Mapa;
    mapa.createFlag = !mapa.createFlag;
    button.button = mapa.createFlag ? Imagens.buttonFlag : Imagens.buttonClick;
  }
}