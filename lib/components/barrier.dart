import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../my_game.dart';

class Barrier extends SpriteComponent with HasGameReference<MyGame> {
  final bool isInverted;
  bool _isStopped = false;
  Barrier({required super.position, this.isInverted = false});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await game.loadSprite('barrier.png');
    size = Vector2(size.x / 4, size.y);
    anchor = Anchor.center;
    priority = 1;
    if (isInverted) {
      angle = pi;
    }
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!_isStopped) {
      position.x -= 100 * dt;
    }
  }

  void stop() {
    _isStopped = true;
  }
}
