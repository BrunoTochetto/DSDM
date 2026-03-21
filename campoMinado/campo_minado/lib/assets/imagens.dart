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
  static late Map<int, Sprite> numeros;

  static late Sprite um;
  static late Sprite dois;
  static late Sprite tres;
  static late Sprite quatro;
  static late Sprite cinco;
  static late Sprite seis;
  static late Sprite sete;
  static late Sprite oito;
  
  
  

  static Future<void> loadAll() async {
    tile = await loadSprite('tile');
    flagTile = await loadSprite('flag_tile');
    mineTile = await loadSprite('mine_tile');
    emptyTile = await loadSprite('tile_empty');
    buttonClick = await loadSprite('button/button_click');
    buttonFlag = await loadSprite('button/button_flag');
    buttonPressed = await loadSprite('button/button_pressed');

    numeros = {};
    numeros[0] = emptyTile;
    numeros[1] = await loadSprite('numero/tile_um');
    numeros[2] = await loadSprite('numero/tile_dois');
    numeros[3] = await loadSprite('numero/tile_tres');
    numeros[4] = await loadSprite('numero/tile_quatro');
    numeros[5] = await loadSprite('numero/tile_cinco');
    numeros[6] = await loadSprite('numero/tile_seis');
    numeros[7] = await loadSprite('numero/tile_sete');
    numeros[8] = await loadSprite('numero/tile_oito');
  }
}