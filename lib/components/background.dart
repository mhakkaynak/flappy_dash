import 'package:flame/components.dart';

import '../my_game.dart';

class Background extends SpriteComponent with HasGameReference<MyGame> {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await game.loadSprite('background.png');
    final secondSprite = await game.loadSprite('background.png');
    final secondBackground = SpriteComponent(
      sprite: secondSprite,
      position: Vector2(size.x, 0),
      size: size,
    );
    add(secondBackground);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= 100 * dt;
    if (position.x * 2 <= -size.x) {
      position.x = size.x / 2;
    }
  }
}
