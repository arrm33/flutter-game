import 'package:flame/game.dart';
import 'package:flutter_game/components/background.dart';

class FlappyBirdGame extends FlameGame{
  Future<void> onLode() async{
    add(Background());
  }
}