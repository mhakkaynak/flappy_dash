import 'package:flame/components.dart';

import '../my_game.dart';

class Player extends SpriteComponent with HasGameReference<MyGame> {
  bool _isOpen = true;
  final Vector2 _movement = Vector2(0, 0);
  final double _gravity = 600.0;
  final double _jumpForce = -100.0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await game.loadSprite('bird_open.png');
  }

  @override
  void update(double dt) {
    _movement.y += _gravity * dt;
    position += _movement.normalized() * 300 * dt;
    super.update(dt);
  }

  void fly() async {
    _movement.y = _jumpForce;
    if (_isOpen) {
      sprite = await game.loadSprite('bird_close.png');
    } else {
      sprite = await game.loadSprite('bird_open.png');
    }
    _isOpen = !_isOpen;
  }
}
