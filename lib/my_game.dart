import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flappy_dash/components/background.dart';
import 'package:flappy_dash/components/barrier.dart';
import 'package:flappy_dash/components/score_zone.dart';
import 'package:flutter/material.dart';

import 'components/player.dart';

class MyGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  late Player _player;
  late SpawnComponent _barrierSpawner;
  late TextComponent _scoreText;
  final Random _random = Random();
  late TextComponent _gameOverText;
  late Background _background;
  final List<Barrier> _barriers = [];
  int _score = 0;

  MyGame() {
    _player = Player();
  }

  @override
  Future<void> onLoad() async {
    await Flame.device.fullScreen();
    await Flame.device.setPortrait();
    debugMode = true;
    await startGame();
    super.onLoad();
  }

  Future<void> startGame() async {
    await _createPlayer();
    await _createBackground();
    await _createBarrierSpawner();
    _createScoreDisplay();
  }

  Future<void> _createPlayer() async {
    _player.position = Vector2(size.x / 2, size.y / 2);
    _player.size = Vector2(size.x / 4, size.y / 4);
    _player.anchor = Anchor.center;
    _player.priority = 1;
    add(_player);
  }

  Future<void> _createBackground() async {
    _background = Background();
    _background.position = Vector2(size.x / 2, size.y / 2);
    _background.size = Vector2(size.x, size.y);
    _background.anchor = Anchor.center;
    _background.priority = 0;
    add(_background);
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
        final scoreZone = ScoreZone(
          position:
              Vector2(barrier.position.x, barrier.position.y - size.y / 1.5),
          size: Vector2(_player.size.x, _player.size.y + 200),
          id: DateTime.now().millisecondsSinceEpoch.toString(),
        );
        _barriers.add(barrier);
        _barriers.add(invertedBarrier);
        add(invertedBarrier);
        add(scoreZone);
        return barrier;
      },
      minPeriod: 2,
      maxPeriod: 6,
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

  void _createScoreDisplay() {
    _score = 0;
    _scoreText = TextComponent(
      text: '0',
      anchor: Anchor.topCenter,
      position: Vector2(size.x / 2, 50),
      priority: 10,
      textRenderer: TextPaint(
        style: TextStyle(
          color: Colors.white,
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(_scoreText);
  }

  void incrementScore() {
    _score++;
    _scoreText.text = _score.toString();
    final ScaleEffect scaleEffect = ScaleEffect.to(
      Vector2.all(2),
      EffectController(
        duration: 0.1,
        curve: Curves.easeInOut,
        alternate: true,
      ),
    );
    _scoreText.add(scaleEffect);
  }

  void gameOver() {
    _gameOverText = TextComponent(
      text: 'Game Over',
      anchor: Anchor.center,
      position: Vector2(size.x / 2, size.y / 2),
      priority: 10,
      textRenderer: TextPaint(
        style: TextStyle(
          color: Colors.white,
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(_gameOverText);
    _player.removeFromParent();
    _background.stop();
    _barrierSpawner.removeFromParent();
    for (final barrier in _barriers) {
      barrier.stop();
    }
  }
}
