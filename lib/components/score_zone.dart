import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../my_game.dart';

class ScoreZone extends PositionComponent
    with HasGameReference<MyGame>, CollisionCallbacks {
  final String id;
  ScoreZone({required super.position, required super.size, required this.id});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    priority = 1;
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= 100 * dt;
  }
}
