import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter_game/flappy_bird_game.dart';

import '../assets/images/assets.dart';

class Background extends SpriteComponent with HasGameReference<FlappyBirdGame>{
  Background();
  @override
  Future<void> onLoad() async {
    await Flame.images.load(Assets.background);
  }
}