import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_dash/components/barrier.dart';
import 'package:flappy_dash/components/score_zone.dart';

import '../my_game.dart';

class Player extends SpriteComponent
    with HasGameReference<MyGame>, CollisionCallbacks {
  bool _isOpen = true;
  final Vector2 _movement = Vector2(0, 0);
  final double _gravity = 600.0;
  final double _jumpForce = -100.0;
  final Map<String, bool> _scoredZones = {};

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await game.loadSprite('bird_open.png');
    add(RectangleHitbox());
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

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Barrier) {}
    if (other is ScoreZone && _scoredZones[other.id] != true) {
      _scoredZones[other.id] = true;
      game.incrementScore();
    }
  }
}
