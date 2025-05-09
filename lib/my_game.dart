import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flappy_dash/components/background.dart';
import 'package:flappy_dash/components/barrier.dart';

import 'components/player.dart';

class MyGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  late Player _player;
  late SpawnComponent _barrierSpawner;
  final Random _random = Random();

  MyGame() {
    _player = Player();
  }

  @override
  Future<void> onLoad() async {
    await Flame.device.fullScreen();
    await Flame.device.setPortrait();
    await startGame();
    super.onLoad();
  }

  Future<void> startGame() async {
    await _createPlayer();
    await _createBackground();
    await _createBarrier();
    await _createBarrierSpawner();
  }

  Future<void> _createPlayer() async {
    _player.position = Vector2(size.x / 2, size.y / 2);
    _player.size = Vector2(size.x / 4, size.y / 4);
    _player.anchor = Anchor.center;
    _player.priority = 1;
    add(_player);
  }

  Future<void> _createBackground() async {
    final background = Background();
    background.position = Vector2(size.x / 2, size.y / 2);
    background.size = Vector2(size.x, size.y);
    background.anchor = Anchor.center;
    background.priority = 0;
    add(background);
  }

  Future<void> _createBarrier() async {
    final barrier = Barrier(position: _generateRandomPosition());
    final invertedBarrier = Barrier(
      position: Vector2(
        barrier.position.x,
        barrier.position.y - size.y,
      ),
      isInverted: true,
    );
    add(barrier);
    add(invertedBarrier);
  }

  Future<void> _createBarrierSpawner() async {
    _barrierSpawner = SpawnComponent.periodRange(
      factory: (index) {
        final barrier = Barrier(position: _generateRandomPosition());
        final invertedBarrier = Barrier(
          position: Vector2(
            barrier.position.x,
            barrier.position.y - size.y,
          ),
          isInverted: true,
        );
        add(invertedBarrier);
        return barrier;
      },
      minPeriod: 1.2,
      maxPeriod: 3,
      selfPositioning: true,
    );
    add(_barrierSpawner);
  }

  Vector2 _generateRandomPosition() {
    return Vector2(
      size.x / 0.6,
      size.y - (_random.nextDouble() * 0.4 * (size.y / 2)),
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    _player.fly();
    super.onTapDown(event);
  }
}
