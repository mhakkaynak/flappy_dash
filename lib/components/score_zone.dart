import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../my_game.dart';
import 'player.dart';

class ScoreZone extends PositionComponent
    with HasGameReference<MyGame>, CollisionCallbacks {
  bool _hasScored = false;

  ScoreZone({required super.position, required super.size});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= 100 * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player && !_hasScored) {
      _hasScored = true;
      game.incrementScore();
    }
  }
}
