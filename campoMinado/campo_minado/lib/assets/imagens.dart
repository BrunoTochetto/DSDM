import 'package:flame/components.dart';

Future<Sprite> loadSprite(String spriteName) async {
  return await Sprite.load('$spriteName.png');
}

class Imagens {
  static late Sprite tile;
  static late Sprite flagTile;
  static late Sprite mineTile;
  static late Sprite emptyTile;
  static late Sprite buttonClick;
  static late Sprite buttonFlag;
  static late Sprite buttonPressed;

  static Future<void> loadAll() async {
    tile = await loadSprite('tile');
    flagTile = await loadSprite('flag_tile');
    mineTile = await loadSprite('mine_tile');
    emptyTile = await loadSprite('tile_empty');
    buttonClick = await loadSprite('button/button_click');
    buttonFlag = await loadSprite('button/button_flag');
    buttonPressed = await loadSprite('button/button_pressed');
  }
}