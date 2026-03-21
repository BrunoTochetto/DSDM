import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'ladrilho.dart';

class LadrilhoBandeira extends Ladrilho {
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('tile.png');
  }

  @override
  void onTapUp(TapUpEvent info) async {
    sprite = await Sprite.load('flag_tile.png');
  }

}